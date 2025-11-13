#!/bin/sh
# Copyright (c) 2025 VIPAREALITY TECH Ltd.
# Licensed under the Apache 2.0 License. See LICENSE file in the project root for license information.

# Script to install tool-demo via Homebrew
# Format link: https://raw.githubusercontent.com/[owner]/[repo]/[branch-or-tag]/[path/to/file]
# Run: curl -fsSL https://raw.githubusercontent.com/ethan-vipabase/homebrew-tool-demo/HEAD/install.sh | bash

set -euo pipefail # strict mode: exit on error, undefined variable, or error in pipeline

# function to check if Homebrew is installed

install_homebrew_if_not_exist() {
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # add Homebrew to PATH for the current session:
        export PATH="/opt/homebrew/bin:$PATH"
        export PATH="/usr/local/bin:$PATH"
        # add path to shell profile
        SHELL_PROFILE=""
        if [ -n "$ZSH_VERSION" ]; then
            SHELL_PROFILE="$HOME/.zshrc"
        elif [ -n "$BASH_VERSION" ]; then
            SHELL_PROFILE="$HOME/.bash_profile"
        fi
        if [ -n "$SHELL_PROFILE" ]; then
            echo "PATH=\"$PATH\"" >> "$SHELL_PROFILE"
            source "$SHELL_PROFILE"
            echo "Added Homebrew to PATH in $SHELL_PROFILE"
        fi
        echo "Homebrew installed successfully."
    else
        echo "Homebrew is already installed."
    fi
}

# function to tap and install tool-demo
tap_and_install_tool_demo() {
    local tap_name="ethan-vipabase/homebrew-tool-demo"
    local formula_name="tool-demo"

    # download GitHub repo ethan-vipabase/homebrew-tool-demo into /opt/homebrew/Library/Taps/ethan-vipabase/homebrew-tool-demo
    echo "Tapping the repository $tap_name..."

   if ! brew tap | grep -q "^$tap_name\$"; then
        brew tap $tap_name
        echo "Tapped $tap_name successfully."
    else
        echo "Repository $tap_name is already tapped. Updating..."
        brew update # get latest .rd
    fi


    # install tool-demo
    # The excecutable will be installed into /opt/homebrew/Cellar/tool-demo/<version>/bin/tool-demo
    # The symlink will be created in /opt/homebrew/bin/tool-demo
    # To run the tool-demo, just type "tool-demo" in the terminal
    echo "Installing tool-demo..."

    if brew list --formula | grep -q "^$formula_name\$"; then
        echo "tool-demo is already installed. Upgrading to the latest version..."
        brew upgrade $formula_name
        echo "tool-demo upgraded successfully."
        return
    fi

    brew install $formula_name

    echo "tool-demo installed successfully."

}

# Main script execution

main() {
    echo "Starting installation of tool-demo via Homebrew..."
    install_homebrew_if_not_exist
    tap_and_install_tool_demo
}

# entry point
 main
