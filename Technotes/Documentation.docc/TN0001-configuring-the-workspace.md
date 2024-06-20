# Configuring your environment

Explore suggestions to help set up your fresh development environment


## Overview

Setting up your development environment from scratch can be a rare task, so
automating it may seem unnecessary in various situations. However, having at
least one go-to guide for these scenarios can be very beneficial.


## Xcode

Download and install [**Xcode**](https://developer.apple.com/xcode/) and the
corresponding **Command Line Tools** package from the [Software Downloads -
Apple Developer](https://developer.apple.com/download/all/) page. Here you will find
the latest SDKs and beta operating systems for all Apple platforms.


## Visual Studio Code

Download and install [**Visual Studio Code**](https://code.visualstudio.com)
from its dedicated [download](https://code.visualstudio.com/download) page.


## Homebrew Package Manager

Run these commands in your terminal to install and configure Homebrew:

```zsh
# Install
% /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Uninstall
% /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

Once installed, don't forget to configure your shell environment for Homebrew:

```zsh
# Configure the shell environment for Homebrew
% (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
% eval "$(/opt/homebrew/bin/brew shellenv)"
```

Optionally, you can also disable Homebrew's analytics system:

```zsh
# Disable Homebrew analytics
% brew analytics off
```


## System-wide Git user preferences

To configure `user.name` and `email.address` preferences for every repository
on your computer, it is enough to perform the following commands in your terminal:

```zsh
# Configure the global user.name value.
% git config --global user.name "Jake Appleseed"

# Configure the global user.email value.
% git config --global user.email "email@example.com"
```

To confirm the changes, you can query each value using:

```zsh
# Query the global user.name value.
% git config --global user.name
Jake Appleseed

# Query the global user.email value.
% git config --global user.email
email@example.com
```

## Repository-specific Git user preferences

Alternatively, you can configure your `user.name` and `email.address` for each
repository independently. This change will override the global Git configuration
at the repository level.

To perform these changes, open your terminal in the repository's root directory
and run these commands:

```zsh
# Configure the repository-specific user.name value.
% git config user.name "Jake Appleseed"

# Configure the repository-specific user.email value.
% git config user.email "email@example.com"
```

To confirm the changes, you can query each value using:

```zsh
# Query the repository-specific user.name value.
% git config user.name
Jake Appleseed

# Query the repository-specific user.email value.
% git config user.email
email@example.com
```

## Automate SSH identity loading

If you prefer to connect to GitHub with SSH (via Terminal), you can automate
adding your SSH key to the `ssh-agent`. This removes the need to always link
the corresponding private key with the `ssh-agent` after each system startup,
saving you some time and frustration down the road.

After you've generated the keys, the first step is to add your SSH private key
to the `ssh-agent` and store your passphrase in the keychain.

```zsh
# Add an SSH key to the ssh-agent and store the passphrase in the keychain.
% ssh-add --apple-use-keychain ~/.ssh/id_rsa
```

To automatically load keys into the `ssh-agent`, you will need to modify your
`~/.ssh/config` file to contain the following lines:

```text
Host github.com
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
```
If your SSH key file has a different name or path than the example above,
modify the filename or path to match your current setup.

## Developer binaries folder

Sometimes you may need to compile various executables yourself, and you need to
keep them for a while. For a cleaner file system and a tidier `$PATH` variable,
consider nesting all these binaries under `/opt/developer/bin`. This way, you
have a clear file structure, and you only need to append a single folder to the
`$PATH`, making everything easier to maintain and reason about.

```zsh
# Create the folder
% mkdir -p "/opt/developer/bin"
```

To configure your shell environment to reference this location, edit your
`~/.zprofile` and make sure to append (or prepend) it to the path variable:

```zsh
# append
path+=('/opt/developer/bin')
# or prepend
path=('/opt/developer/bin' $path)
# export to sub-processes (make it inherited by child processes)
export PATH
```

## Revision History
* 2024-06-20 First published.

## References

* [Homebrew Docs](https://docs.brew.sh/Installation)
* [GitHub Docs - Managing Email Preferences](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address)
* [GitHub Docs - Connecting to GitHub with SSH](https://docs.github.com/en/enterprise-cloud@latest/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
* [StackExchange - Automate SSH identity loading](https://apple.stackexchange.com/questions/48502/how-can-i-permanently-add-my-ssh-private-key-to-keychain-so-it-is-automatically)


<!-- Copyright (c) 2024 Beilmo Global Network SRL. All Rights Reserved. -->
