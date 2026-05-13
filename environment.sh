#!/bin/bash

set -euo pipefail

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

DRY_RUN=0
MODE="install"
THEME_NAME=""
DOTFILES_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
THEME_FILE="$DOTFILES_DIR/.theme"
DEFAULT_THEME="catppuccin-mocha"
VERSION_DIR="$HOME/.local/share/.dotfiles-tool-versions"
CARGO_PACKAGES=(du-dust zoxide zellij cargo-cache cargo-update viu tuckr)

usage() {
    cat <<EOF
Usage: $0 [install|update|update-neovim|update-helix|update-hunkdiff|update-ghostty|update-cmux|theme|theme-list|cleanup] [theme-name] [--dry-run]

Commands:
  install          Install the full development environment. This is the default.
  update           Update the full development environment.
  update-neovim    Update only Neovim.
  update-helix     Update only Helix.
  update-hunkdiff  Update only hunkdiff.
  update-ghostty   Update only Ghostty on macOS.
  update-cmux      Update only cmux on macOS.
  theme NAME       Set the shared UI theme and sync dotfiles.
  theme-list       List supported shared UI themes.
  cleanup          Remove old extracted binary tool versions.

Options:
  --dry-run        Print the actions without changing files.
  -h, --help       Show this help.

Supported themes:
  catppuccin-mocha
  gruvbox-dark
  gruvbox-light
  tokyonight-dark
EOF
}

parse_args() {
    mode_set=0

    while [ "$#" -gt 0 ]; do
        arg="$1"

        case "$arg" in
            --dry-run)
                DRY_RUN=1
                ;;
            -h|--help|help)
                usage
                exit 0
                ;;
            install|update|update-neovim|update-helix|update-hunkdiff|update-ghostty|update-cmux|theme-list|cleanup)
                if [ "$mode_set" -eq 1 ]; then
                    usage
                    exit 1
                fi

                MODE="$arg"
                mode_set=1
                ;;
            theme)
                if [ "$mode_set" -eq 1 ]; then
                    usage
                    exit 1
                fi

                MODE="$arg"
                mode_set=1
                shift

                if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
                    echo "Missing theme name."
                    usage
                    exit 1
                fi

                THEME_NAME="$1"
                ;;
            *)
                usage
                exit 1
                ;;
        esac

        shift
    done
}

run() {
    if [ "$DRY_RUN" -eq 1 ]; then
        printf '+'
        printf ' %q' "$@"
        printf '\n'
    else
        "$@"
    fi
}

ensure_local_dirs() {
    run mkdir -p "$HOME/.local/bin" "$HOME/.local/share" "$VERSION_DIR"
}

append_line_once() {
    file="$1"
    line="$2"

    if [ "$DRY_RUN" -eq 1 ]; then
        if [ -f "$file" ] && grep -Fqx "$line" "$file"; then
            echo "Already configured in $file: $line"
        else
            echo "Would append to $file: $line"
        fi
        return
    fi

    mkdir -p "$(dirname "$file")"
    touch "$file"

    if ! grep -Fqx "$line" "$file"; then
        echo "$line" >> "$file"
    fi
}

installed_version() {
    tool="$1"
    version_file="$VERSION_DIR/$tool"

    if [ -f "$version_file" ]; then
        cat "$version_file"
    fi
}

write_installed_version() {
    tool="$1"
    version="$2"

    ensure_local_dirs
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would record $tool version: $version"
    else
        echo "$version" > "$VERSION_DIR/$tool"
    fi
}

list_themes() {
    cat <<EOF
catppuccin-mocha
gruvbox-dark
gruvbox-light
tokyonight-dark
EOF
}

is_supported_theme() {
    case "$1" in
        catppuccin-mocha|gruvbox-dark|gruvbox-light|tokyonight-dark) return 0 ;;
        *) return 1 ;;
    esac
}

current_theme() {
    if [ -n "$THEME_NAME" ]; then
        echo "$THEME_NAME"
    elif [ -f "$THEME_FILE" ]; then
        sed -n '1p' "$THEME_FILE"
    else
        echo "$DEFAULT_THEME"
    fi
}

theme_ghostty_name() {
    case "$1" in
        catppuccin-mocha) echo "Catppuccin Mocha" ;;
        gruvbox-dark) echo "Gruvbox Dark" ;;
        gruvbox-light) echo "Gruvbox Light" ;;
        tokyonight-dark) echo "TokyoNight Night" ;;
    esac
}

theme_helix_name() {
    case "$1" in
        catppuccin-mocha) echo "catppuccin_mocha" ;;
        gruvbox-dark) echo "gruvbox" ;;
        gruvbox-light) echo "gruvbox_light" ;;
        tokyonight-dark) echo "tokyonight" ;;
    esac
}

theme_starship_palette() {
    case "$1" in
        catppuccin-mocha) echo "catppuccin_mocha" ;;
        gruvbox-dark) echo "gruvbox_dark" ;;
        gruvbox-light) echo "gruvbox_light" ;;
        tokyonight-dark) echo "tokyonight_dark" ;;
    esac
}

write_managed_file() {
    file="$1"

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would write $file"
        cat >/dev/null
        return
    fi

    mkdir -p "$(dirname "$file")"
    cat > "$file"
}

replace_toml_value() {
    file="$1"
    key="$2"
    value="$3"
    quote="$4"

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would set $key in $file to $value"
        return
    fi

    tmp_file="$(mktemp)"
    awk -v key="$key" -v value="$value" -v quote="$quote" '
        BEGIN { done = 0 }
        $0 ~ "^" key " = " && done == 0 {
            print key " = " quote value quote
            done = 1
            next
        }
        { print }
        END {
            if (done == 0) {
                print key " = " quote value quote
            }
        }
    ' "$file" > "$tmp_file"
    mv "$tmp_file" "$file"
}

replace_config_value() {
    file="$1"
    key="$2"
    value="$3"

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would set $key in $file to $value"
        return
    fi

    mkdir -p "$(dirname "$file")"
    touch "$file"

    tmp_file="$(mktemp)"
    awk -v key="$key" -v value="$value" '
        $0 ~ "^" key " *= " && done == 0 {
            print key " = " value
            done = 1
            next
        }
        $0 ~ "^" key " *= " {
            next
        }
        { print }
        END {
            if (done == 0) {
                print key " = " value
            }
        }
    ' "$file" > "$tmp_file"
    mv "$tmp_file" "$file"
}

replace_managed_block() {
    file="$1"
    begin_marker="$2"
    end_marker="$3"
    content="$4"

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would update managed block in $file"
        return
    fi

    mkdir -p "$(dirname "$file")"
    touch "$file"

    content_file="$(mktemp)"
    tmp_file="$(mktemp)"
    printf '%s\n' "$content" > "$content_file"

    awk -v begin="$begin_marker" -v end="$end_marker" -v content_file="$content_file" '
        function print_content() {
            while ((getline line < content_file) > 0) {
                print line
            }
            close(content_file)
        }
        $0 == begin {
            print begin
            print_content()
            in_block = 1
            found = 1
            next
        }
        $0 == end {
            print end
            in_block = 0
            next
        }
        in_block != 1 {
            print
        }
        END {
            if (found != 1) {
                print ""
                print begin
                print_content()
                print end
            }
        }
    ' "$file" > "$tmp_file"
    mv "$tmp_file" "$file"
    rm -f "$content_file"
}

zellij_themes_block() {
    cat <<'EOF'
themes {
    catppuccin-mocha {
        fg 205 214 244
        bg 30 30 46
        black 24 24 37
        red 243 139 168
        green 166 227 161
        yellow 249 226 175
        blue 137 180 250
        magenta 245 194 231
        cyan 137 220 235
        white 205 214 244
        orange 250 179 135
    }
    gruvbox-dark {
        fg 235 219 178
        bg 40 40 40
        black 40 40 40
        red 204 36 29
        green 152 151 26
        yellow 215 153 33
        blue 69 133 136
        magenta 177 98 134
        cyan 104 157 106
        white 235 219 178
        orange 214 93 14
    }
    gruvbox-light {
        fg 60 56 54
        bg 251 241 199
        black 40 40 40
        red 204 36 29
        green 152 151 26
        yellow 215 153 33
        blue 69 133 136
        magenta 177 98 134
        cyan 104 157 106
        white 251 241 199
        orange 214 93 14
    }
    tokyonight-dark {
        fg 192 202 245
        bg 26 27 38
        black 21 22 30
        red 247 118 142
        green 158 206 106
        yellow 224 175 104
        blue 122 162 247
        magenta 187 154 247
        cyan 125 207 255
        white 192 202 245
        orange 255 158 100
    }
}
EOF
}

zathura_theme_block() {
    case "$1" in
        catppuccin-mocha)
            name="Catppuccin Mocha"
            bg="#1e1e2e"
            fg="#cdd6f4"
            error="#f38ba8"
            warning="#fab387"
            highlight="#f9e2af"
            active="#89b4fa"
            surface="#45475a"
            mantle="#181825"
            ;;
        gruvbox-dark)
            name="Gruvbox Dark"
            bg="#282828"
            fg="#ebdbb2"
            error="#cc241d"
            warning="#d65d0e"
            highlight="#d79921"
            active="#458588"
            surface="#3c3836"
            mantle="#1d2021"
            ;;
        gruvbox-light)
            name="Gruvbox Light"
            bg="#fbf1c7"
            fg="#3c3836"
            error="#cc241d"
            warning="#d65d0e"
            highlight="#d79921"
            active="#458588"
            surface="#ebdbb2"
            mantle="#f2e5bc"
            ;;
        tokyonight-dark)
            name="TokyoNight Dark"
            bg="#1a1b26"
            fg="#c0caf5"
            error="#f7768e"
            warning="#ff9e64"
            highlight="#e0af68"
            active="#7aa2f7"
            surface="#292e42"
            mantle="#16161e"
            ;;
    esac

    cat <<EOF
# $name
set notification-error-bg       "$error"
set notification-error-fg       "$bg"
set notification-warning-bg     "$warning"
set notification-warning-fg     "$bg"
set notification-bg             "$bg"
set notification-fg             "$fg"

set completion-bg               "$bg"
set completion-fg               "$fg"
set completion-group-bg         "$bg"
set completion-group-fg         "$active"
set completion-highlight-bg     "$surface"
set completion-highlight-fg     "$fg"

set index-bg                    "$bg"
set index-fg                    "$fg"
set index-active-bg             "$surface"
set index-active-fg             "$fg"

set inputbar-bg                 "$bg"
set inputbar-fg                 "$fg"
set statusbar-bg                "$mantle"
set statusbar-fg                "$fg"

set highlight-color             "$highlight"
set highlight-active-color      "$active"

set default-bg                  "$bg"
set default-fg                  "$fg"

set render-loading              true
set render-loading-fg           "$bg"
set render-loading-bg           "$fg"

set recolor-lightcolor          "$bg"
set recolor-darkcolor           "$fg"
EOF
}

neovim_theme_module() {
    case "$1" in
        catppuccin-mocha)
            cat <<'EOF'
local M = {}

M.lazy_spec = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				mason = true,
				telescope = true,
				treesitter = true,
				which_key = true,
			},
		})

		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}

function M.use_packer(use)
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				term_colors = true,
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	})
end

return M
EOF
            ;;
        gruvbox-dark)
            cat <<'EOF'
local M = {}

local function apply()
	vim.o.background = "dark"
	require("gruvbox").setup({ contrast = "soft" })
	vim.cmd.colorscheme("gruvbox")
end

M.lazy_spec = {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = apply,
}

function M.use_packer(use)
	use({
		"ellisonleao/gruvbox.nvim",
		config = apply,
	})
end

return M
EOF
            ;;
        gruvbox-light)
            cat <<'EOF'
local M = {}

local function apply()
	vim.o.background = "light"
	require("gruvbox").setup({ contrast = "soft" })
	vim.cmd.colorscheme("gruvbox")
end

M.lazy_spec = {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = apply,
}

function M.use_packer(use)
	use({
		"ellisonleao/gruvbox.nvim",
		config = apply,
	})
end

return M
EOF
            ;;
        tokyonight-dark)
            cat <<'EOF'
local M = {}

local function apply()
	require("tokyonight").setup({
		style = "night",
		terminal_colors = true,
	})
	vim.cmd.colorscheme("tokyonight-night")
end

M.lazy_spec = {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = apply,
}

function M.use_packer(use)
	use({
		"folke/tokyonight.nvim",
		config = apply,
	})
end

return M
EOF
            ;;
    esac
}

apply_theme() {
    theme="$1"

    if ! is_supported_theme "$theme"; then
        echo "Unsupported theme: $theme"
        echo "Supported themes:"
        list_themes
        exit 1
    fi

    helix_theme="$(theme_helix_name "$theme")"
    ghostty_theme="$(theme_ghostty_name "$theme")"
    starship_palette="$(theme_starship_palette "$theme")"

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would record shared theme: $theme"
    else
        echo "$theme" > "$THEME_FILE"
    fi

    replace_toml_value "$DOTFILES_DIR/Configs/helix/.config/helix/config.toml" "theme" "$helix_theme" '"'
    replace_toml_value "$DOTFILES_DIR/Configs/starship/.config/starship.toml" "palette" "$starship_palette" "'"

    replace_config_value "$DOTFILES_DIR/Configs/ghostty/.config/ghostty/config" "theme" "$ghostty_theme"

    neovim_theme_module "$theme" | write_managed_file "$DOTFILES_DIR/Configs/neovim/.config/nvim/lua/theme.lua"

    zellij_block="$(zellij_themes_block)"
    zellij_selected="theme \"$theme\""

    replace_managed_block "$DOTFILES_DIR/Configs/zellij/.config/zellij/config.kdl" "// BEGIN DOTFILES THEMES" "// END DOTFILES THEMES" "$zellij_block"
    replace_managed_block "$DOTFILES_DIR/Configs/zellij/.config/zellij/config.kdl" "// BEGIN DOTFILES SELECTED THEME" "// END DOTFILES SELECTED THEME" "$zellij_selected"
    replace_managed_block "$DOTFILES_DIR/Configs/programs/.config/zellij/config.kdl" "// BEGIN DOTFILES THEMES" "// END DOTFILES THEMES" "$zellij_block"
    replace_managed_block "$DOTFILES_DIR/Configs/programs/.config/zellij/config.kdl" "// BEGIN DOTFILES SELECTED THEME" "// END DOTFILES SELECTED THEME" "$zellij_selected"

    zathura_block="$(zathura_theme_block "$theme")"
    replace_managed_block "$DOTFILES_DIR/Configs/programs/.config/zathura/zathurarc" "# BEGIN DOTFILES THEME" "# END DOTFILES THEME" "$zathura_block"
}

github_latest_tag() {
    repo="$1"

    response=$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest") || {
        echo "Unable to fetch latest release metadata for $repo" >&2
        return 1
    }

    tag=$(printf '%s\n' "$response" \
        | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p' \
        | head -n 1)

    if [ -z "$tag" ]; then
        echo "Unable to parse latest release tag for $repo" >&2
        return 1
    fi

    echo "$tag"
}

download_and_extract_archive() {
    url="$1"
    download_path="$2"
    extract_path="$3"
    compression="$4"

    ensure_local_dirs

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would download: $url"
        echo "Would extract $download_path into $extract_path"
        return
    fi

    curl -L --progress-bar -o "$download_path" "$url"

    case "$compression" in
        gz) tar xzf "$download_path" -C "$extract_path" ;;
        xz) tar xJf "$download_path" -C "$extract_path" ;;
        *)
            echo "Unsupported archive compression: $compression"
            exit 1
            ;;
    esac
}

cleanup_matching_dirs() {
    base_dir="$1"
    pattern="$2"
    keep_dir="${3:-}"

    for dir in "$base_dir"/$pattern; do
        [ -e "$dir" ] || continue
        [ -d "$dir" ] || continue

        if [ -n "$keep_dir" ] && [ "$dir" = "$keep_dir" ]; then
            continue
        fi

        run rm -rf "$dir"
    done
}

get_arch() {
    case "$(uname -m)" in
        x86_64) echo "x86_64" ;;
        arm64|aarch64) echo "arm64" ;;
        *) echo "unsupported" ;;
    esac
}

get_os() {
    case "$(uname -s)" in
        Linux) echo "linux" ;;
        Darwin) echo "macos" ;;
        *) echo "unsupported" ;;
    esac
}

get_helix_arch() {
    case "$(uname -m)" in
        x86_64) echo "x86_64" ;;
        arm64|aarch64) echo "aarch64" ;;
        *) echo "unsupported" ;;
    esac
}

get_hunkdiff_arch() {
    case "$(uname -m)" in
        x86_64) echo "x64" ;;
        arm64|aarch64) echo "arm64" ;;
        *) echo "unsupported" ;;
    esac
}

get_hunkdiff_os() {
    case "$(uname -s)" in
        Linux) echo "linux" ;;
        Darwin) echo "darwin" ;;
        *) echo "unsupported" ;;
    esac
}

require_supported_platform() {
    tool="$1"
    os="$2"
    arch="$3"

    if [ "$arch" = "unsupported" ] || [ "$os" = "unsupported" ]; then
        echo "Unsupported platform for $tool: $(uname -s) $(uname -m)"
        exit 1
    fi
}

is_macos() {
    [ "$(uname -s)" = "Darwin" ]
}

ensure_homebrew() {
    if ! is_macos; then
        return
    fi

    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew is required to install Ghostty and cmux on macOS."
        echo "Install Homebrew first: https://brew.sh/"
        exit 1
    fi
}

brew_cask_installed() {
    cask="$1"
    brew list --cask "$cask" >/dev/null 2>&1
}

brew_cask_outdated() {
    cask="$1"
    brew outdated --cask --quiet | grep -Fxq "$cask"
}

install_or_update_homebrew_cask() {
    cask="$1"

    if ! is_macos; then
        echo "Skipping $cask: macOS only"
        return
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would install/update Homebrew cask: $cask"
        return
    fi

    ensure_homebrew

    if brew_cask_installed "$cask"; then
        if brew_cask_outdated "$cask"; then
            brew upgrade --cask "$cask"
        else
            echo "$cask already up to date"
        fi
    else
        brew install --cask "$cask"
    fi
}

install_or_update_ghostty() {
    install_or_update_homebrew_cask "ghostty"
}

install_or_update_cmux() {
    if ! is_macos; then
        echo "Skipping cmux: macOS only"
        return
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would tap Homebrew repository: manaflow-ai/cmux"
        echo "Would install/update Homebrew cask: cmux"
        echo "Would link cmux CLI into $HOME/.local/bin/cmux"
        return
    fi

    ensure_homebrew
    brew tap manaflow-ai/cmux
    install_or_update_homebrew_cask "cmux"

    cmux_cli="/Applications/cmux.app/Contents/Resources/bin/cmux"

    if [ -x "$cmux_cli" ]; then
        ensure_local_dirs
        ln -sf "$cmux_cli" "$HOME/.local/bin/cmux"
    fi
}

install_or_update_uv() {
    if [ "$DRY_RUN" -eq 1 ]; then
        if command -v uv >/dev/null 2>&1; then
            echo "Would update uv"
        else
            echo "Would install uv"
        fi
        return
    fi

    if command -v uv >/dev/null 2>&1; then
        uv self update || curl -LsSf https://astral.sh/uv/install.sh | sh
    else
        touch "$HOME/.profile"
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
}

install_or_update_rust_toolchain() {
    if [ "$DRY_RUN" -eq 1 ]; then
        if command -v rustup >/dev/null 2>&1; then
            echo "Would update Rust toolchain"
        else
            echo "Would install Rust toolchain"
        fi
        return
    fi

    if command -v rustup >/dev/null 2>&1; then
        rustup update
    else
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    fi

    . "$HOME/.cargo/env"
}

install_or_update_rust_programs() {
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would install/update cargo packages: ${CARGO_PACKAGES[*]}"
        echo "Would clean cargo cache"
        return
    fi

    . "$HOME/.cargo/env"

    cargo install --locked "${CARGO_PACKAGES[@]}"

    if command -v cargo-install-update >/dev/null 2>&1; then
        for package in "${CARGO_PACKAGES[@]}"; do
            cargo install-update "$package"
        done
    fi

    cargo cache --autoclean
}

install_or_update_starship() {
    ensure_local_dirs

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would install/update Starship into $HOME/.local/bin"
        return
    fi

    curl -sS https://starship.rs/install.sh | sh -s -- -b "$HOME/.local/bin" -y
}

install_or_update_neovim() {
    arch=$(get_arch)
    os=$(get_os)
    require_supported_platform "Neovim" "$os" "$arch"

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would fetch latest Neovim release from neovim/neovim"
        echo "Would download: https://github.com/neovim/neovim/releases/download/<latest>/nvim-${os}-${arch}.tar.gz"
        echo "Would install Neovim into $HOME/.local/share/nvim-$os-$arch"
        echo "Would link $HOME/.local/bin/nvim"
        return
    fi

    neovim_version=$(github_latest_tag "neovim/neovim")
    current_version=$(installed_version "neovim")
    install_dir="$HOME/.local/share/nvim-$os-$arch"

    if [ "$current_version" = "$neovim_version" ] && [ -x "$HOME/.local/bin/nvim" ]; then
        echo "Neovim already up to date: $neovim_version"
        return
    fi

    download_path="/tmp/nvim-${os}-${arch}.tar.gz"
    extract_path="$HOME/.local/share"
    url="https://github.com/neovim/neovim/releases/download/$neovim_version/nvim-${os}-${arch}.tar.gz"

    run rm -rf "$install_dir"
    download_and_extract_archive "$url" "$download_path" "$extract_path" "gz"
    run ln -sf "$install_dir/bin/nvim" "$HOME/.local/bin/nvim"
    write_installed_version "neovim" "$neovim_version"
}

install_or_update_helix() {
    arch=$(get_helix_arch)
    os=$(get_os)
    require_supported_platform "Helix" "$os" "$arch"

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would fetch latest Helix release from helix-editor/helix"
        echo "Would download: https://github.com/helix-editor/helix/releases/download/<latest>/helix-<latest>-${arch}-${os}.tar.xz"
        echo "Would install Helix into $HOME/.local/share/helix-<latest>-$arch-$os"
        echo "Would write $HOME/.local/bin/hx with HELIX_RUNTIME"
        return
    fi

    helix_version=$(github_latest_tag "helix-editor/helix")
    current_version=$(installed_version "helix")
    install_dir="$HOME/.local/share/helix-$helix_version-$arch-$os"

    if [ "$current_version" = "$helix_version" ] && [ -x "$HOME/.local/bin/hx" ]; then
        echo "Helix already up to date: $helix_version"
        return
    fi

    archive_name="helix-${helix_version}-${arch}-${os}.tar.xz"
    download_path="/tmp/$archive_name"
    extract_path="$HOME/.local/share"
    url="https://github.com/helix-editor/helix/releases/download/$helix_version/$archive_name"

    download_and_extract_archive "$url" "$download_path" "$extract_path" "xz"

    run rm -f "$HOME/.local/bin/hx"
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would write wrapper: $HOME/.local/bin/hx"
    else
        cat > "$HOME/.local/bin/hx" <<EOF
#!/bin/sh
export HELIX_RUNTIME="$install_dir/runtime"
exec "$install_dir/hx" "\$@"
EOF
        chmod +x "$HOME/.local/bin/hx"
    fi

    cleanup_matching_dirs "$extract_path" "helix-*-$arch-$os" "$install_dir"
    write_installed_version "helix" "$helix_version"
}

install_or_update_hunkdiff() {
    arch=$(get_hunkdiff_arch)
    os=$(get_hunkdiff_os)
    require_supported_platform "Hunk" "$os" "$arch"

    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would fetch latest hunkdiff release from modem-dev/hunk"
        echo "Would download: https://github.com/modem-dev/hunk/releases/download/<latest>/hunkdiff-${os}-${arch}.tar.gz"
        echo "Would install hunkdiff into $HOME/.local/share/hunkdiff-<latest>-$os-$arch"
        echo "Would link $HOME/.local/bin/hunk and $HOME/.local/bin/hunkdiff"
        return
    fi

    hunkdiff_version=$(github_latest_tag "modem-dev/hunk")
    current_version=$(installed_version "hunkdiff")
    archive_base="hunkdiff-${os}-${arch}"
    extract_path="$HOME/.local/share"
    extracted_dir="$extract_path/$archive_base"
    install_dir="$extract_path/hunkdiff-$hunkdiff_version-$os-$arch"

    if [ "$current_version" = "$hunkdiff_version" ] && [ -x "$HOME/.local/bin/hunk" ]; then
        echo "hunkdiff already up to date: $hunkdiff_version"
        return
    fi

    archive_name="$archive_base.tar.gz"
    download_path="/tmp/$archive_name"
    url="https://github.com/modem-dev/hunk/releases/download/$hunkdiff_version/$archive_name"

    run rm -rf "$extracted_dir" "$install_dir"
    download_and_extract_archive "$url" "$download_path" "$extract_path" "gz"
    run mv "$extracted_dir" "$install_dir"
    run ln -sf "$install_dir/hunk" "$HOME/.local/bin/hunk"
    run ln -sf "$install_dir/hunk" "$HOME/.local/bin/hunkdiff"

    cleanup_matching_dirs "$extract_path" "hunkdiff-*-$os-$arch" "$install_dir"
    write_installed_version "hunkdiff" "$hunkdiff_version"
}

cleanup_binary_tools() {
    arch=$(get_helix_arch)
    os=$(get_os)

    if [ "$arch" != "unsupported" ] && [ "$os" != "unsupported" ]; then
        helix_version=$(installed_version "helix")
        keep_dir=""

        if [ -n "$helix_version" ]; then
            keep_dir="$HOME/.local/share/helix-$helix_version-$arch-$os"
        fi

        cleanup_matching_dirs "$HOME/.local/share" "helix-*-$arch-$os" "$keep_dir"
    fi

    arch=$(get_hunkdiff_arch)
    os=$(get_hunkdiff_os)

    if [ "$arch" != "unsupported" ] && [ "$os" != "unsupported" ]; then
        hunkdiff_version=$(installed_version "hunkdiff")
        keep_dir=""

        if [ -n "$hunkdiff_version" ]; then
            keep_dir="$HOME/.local/share/hunkdiff-$hunkdiff_version-$os-$arch"
        fi

        cleanup_matching_dirs "$HOME/.local/share" "hunkdiff-*-$os-$arch" "$keep_dir"
        run rm -rf "$HOME/.local/share/hunkdiff-$os-$arch"
    fi
}

sync_dotfiles() {
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "Would sync dotfiles with Tuckr"
        return
    fi

    "$HOME/.cargo/bin/tuckr" add \*
    "$HOME/.cargo/bin/tuckr" add -fy neovim helix ghostty shell starship zellij
}

add_to_path() {
    path_line='export PATH="$HOME/.local/bin:$PATH"'
    cargo_line='source $HOME/.cargo/env'

    case "$SHELL" in
        */bash)
            append_line_once "$HOME/.bashrc" "$path_line"
            append_line_once "$HOME/.bashrc" "$cargo_line"
            append_line_once "$HOME/.bashrc" 'eval "$(starship init bash)"'
            append_line_once "$HOME/.bashrc" 'eval "$(zoxide init bash)"'
            ;;
        */zsh)
            append_line_once "$HOME/.zshrc" "$path_line"
            append_line_once "$HOME/.zshrc" "$cargo_line"
            append_line_once "$HOME/.zshrc" 'eval "$(starship init zsh)"'
            append_line_once "$HOME/.zshrc" 'eval "$(zoxide init zsh)"'
            ;;
        */fish)
            append_line_once "$HOME/.config/fish/config.fish" "fish_add_path $HOME/.local/bin"
            append_line_once "$HOME/.config/fish/config.fish" "fish_add_path $HOME/.cargo/bin"
            append_line_once "$HOME/.config/fish/config.fish" "starship init fish | source"
            append_line_once "$HOME/.config/fish/config.fish" "zoxide init fish | source"
            ;;
        *)
            echo "Unsupported shell: $SHELL"
            echo "Please manually add: $HOME/.local/bin and $HOME/.cargo/bin to your PATH"
            ;;
    esac
}

install_base_environment() {
    install_or_update_uv
    install_or_update_rust_toolchain
    install_or_update_rust_programs
    install_or_update_starship
}

update_base_environment() {
    install_or_update_uv
    install_or_update_rust_toolchain
    install_or_update_rust_programs
    install_or_update_starship
}

install_or_update_binary_tools() {
    install_or_update_neovim
    install_or_update_helix
    install_or_update_hunkdiff
}

install_or_update_macos_apps() {
    if ! is_macos; then
        echo "Skipping macOS apps: not running on macOS"
        return
    fi

    install_or_update_ghostty
    install_or_update_cmux
}

main() {
    parse_args "$@"

    case "$MODE" in
        install)
            install_base_environment
            install_or_update_binary_tools
            install_or_update_macos_apps
            apply_theme "$(current_theme)"
            sync_dotfiles
            add_to_path
            ;;
        update)
            update_base_environment
            install_or_update_binary_tools
            install_or_update_macos_apps
            apply_theme "$(current_theme)"
            sync_dotfiles
            add_to_path
            ;;
        update-neovim)
            install_or_update_neovim
            ;;
        update-helix)
            install_or_update_helix
            ;;
        update-hunkdiff)
            install_or_update_hunkdiff
            ;;
        update-ghostty)
            install_or_update_ghostty
            ;;
        update-cmux)
            install_or_update_cmux
            ;;
        theme)
            apply_theme "$(current_theme)"
            sync_dotfiles
            ;;
        theme-list)
            list_themes
            ;;
        cleanup)
            cleanup_binary_tools
            ;;
    esac
}

main "$@"
