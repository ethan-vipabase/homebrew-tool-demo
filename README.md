## Purpose

This repo is to demo how to distribute a custom tool via Homebrew. The custom tool is compiled into an executable binary file.

## How to build it

1. Create the main POSIX script: `tool-demo.sh`
2. Compile the script to the executable binary file:
   - Install `shc` tool if not exist: `brew install shc`
   -  Compile: `shc -f tool-demo.sh -o tool-demo`
3. Zip the compiled binary file: `zip tool-demo-v1.0.1-macos.zip tool-demo`
4. Get checksum of the zip file, the sha256 value will be added into formula file `tool-demo.rb`: `shasum -a 256 tool-demo-v1.0.1-macos.zip`
5. Create formula file with info:
   - `sha256`: is the sha256 value of the zip file. It is to check the integrity of the zip file in the `url` field.
   - `url`: This is the link of the zip file. To get it. You need to create a new release version in GitHub page:
     -  Tag a new release version, for exmple v1.0.1 `git tag -a v1.0.1 -m "Release v1.0.1"` and `git push original v1.0.0.1`,
     -  In the Github page, create a new release with tag `v1.0.1`, and upload the zip file in this release.
    - `version`: "1.0.1", `brew` uses this value to upgrade/downgrade the version of the tool in your machine.
    - `homepage`: It's Github page `username/repo-name`
    - Notice: in the `install` function, `bin.install` should receive the file name of the binary `tool-demo`
    - the other info...
6. Remember increasing the version for each release.

## How to install it

You can install it in 2 steps:

```sh

# step 1: Download the GitHub repository into Homebrew' Taps (opt/homebrew/Library/Taps/username/repo-name)

brew tap ethan-vipabase/homebrew-tool-demo

# step 2: Install the tool with a [formula-file-name] as a param
# `brew` will find the formula name
# 1. in homebrew/core or homebrew/cask
# 2. if not found, it will find the formula-name inside `Taps` folder, it loops over repos and find the name of the .rb files
# 3. if not found, `brew` throws not-found error
# If found, the formula will be installed to `opt/homebrew/Cellar/tool-demo/1.0.0/
# the `symlink` is created at `opt/homebrew/bin/tool-demo` which points to `opt/homebrew/Cellar/tool-demo/1.0.0/bin/tool-demo`
brew install tool-demo


```

or just run `install.sh` script in a single command:


```sh

curl -fsSL https://raw.githubusercontent.com/ethan-vipabase/homebrew-tool-demo/main/install.sh | bash

```

## How to test it

- Ensure that `/opt/homebrew/bin`  path was added to `$PATH` in the most left: `PATH="/opt/homebrew/bin:$PATH"` in the shell profile (either `~/.zshrc` if using zsh by default or `~/.bash_profile` if using bash shell by default)
- After install the tool successfully, you run the `tool-demo` command in Terminal at anywhere:


```sh

which tool-demo

tool-demo help

tool-demo build

tool-demo deploy

```


## How to uninstall it

```sh
brew uninstall tool-demo

brew untap ethan-vipabase/homebrew-tool-demo
```