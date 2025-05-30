#!/bin/bash

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

add_to_path() {
    PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'
    CARGO_LINE='source $HOME/.cargo/env'
    
    # Detect current shell
    case "$SHELL" in
        */bash)
            echo "$PATH_LINE" >> "$HOME/.bashrc"
            echo "$CARGO_LINE" >> "$HOME/.bashrc"
	    echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
	    echo 'eval "$(zoxide init bash)"' >> "$HOME/.bashrc"
            source "$HOME/.bashrc"
            ;;
        */zsh)
            echo "$PATH_LINE" >> "$HOME/.zshrc"
            echo "$CARGO_LINE" >> "$HOME/.zshrc"
	    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
	    echo 'eval "$(zoxide init zsh)"' >> "$HOME/.zshrc"
            source "$HOME/.zshrc"
            ;;
        */fish)
            fish -c "fish_add_path $HOME/.local/bin"
            fish -c "fish_add_path $HOME/.cargo/bin"
	    starship init fish | source
	    zoxide init fish | source
            ;;
        *)
            echo "Unsupported shell: $SHELL"
            echo "Please manually add: $HOME/.local/bin to your PATH"
            ;;
    esac
}

# Install uv
touch $HOME/.profile
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install the Rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install rust programs
. $HOME/.cargo/env
cargo install du-dust zoxide zellij cargo-cache cargo-update viu --locked
cargo install --locked --features clipboard broot
cargo install --git https://github.com/RaphGL/Tuckr.git
cargo cache --autoclean

# Install starship
curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin -y

# Install neovim
arch=$(get_arch)  # Will output "x86_64" or "arm64"
os=$(get_os)      # Will output "linux" or "macos"
download_path="/tmp/nvim-${os}-${arch}.tar.gz"
extract_path="$HOME/.local/share"
url="https://github.com/neovim/neovim/releases/download/stable/nvim-${os}-${arch}.tar.gz"
curl -L --progress-bar -o "$download_path" "$url"
mkdir -p $extract_path && tar xzf "$download_path" -C "$extract_path"
ln -sf "$extract_path/nvim-$os-$arch/bin/nvim" "$HOME/.local/bin/nvim"

# Create symlinks from dotfiles
$HOME/.cargo/bin/tuckr add \*
tuckr add -fy neovim shell starship zellij

# Add .local/bin to the path
add_to_path

