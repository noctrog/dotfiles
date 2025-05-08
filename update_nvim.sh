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

arch=$(get_arch)  # Will output "x86_64" or "arm64"
os=$(get_os)      # Will output "linux" or "macos"
download_path="/tmp/nvim-${os}-${arch}.tar.gz"
extract_path="$HOME/.local/share"
url="https://github.com/neovim/neovim/releases/download/stable/nvim-${os}-${arch}.tar.gz"
curl -L --progress-bar -o "$download_path" "$url"
mkdir -p $extract_path && tar xzf "$download_path" -C "$extract_path"
ln -sf "$extract_path/nvim-$os-$arch/bin/nvim" "$HOME/.local/bin/nvim"
