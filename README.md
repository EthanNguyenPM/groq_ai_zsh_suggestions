<!--toc:start-->

- [Overview](#overview)
- [Demo](#demo)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [1. Install the Groq Python Library](#1-install-the-groq-python-library)
  - [2. Set Up the API_KEY](#2-set-up-the-apikey)
  - [3. Clone the Groq AI Suggestions Repository](#3-clone-the-groq-ai-suggestions-repository)
  - [4. Configure Your .zshrc](#4-configure-your-zshrc)
- [Usage](#usage)
  - [Suggest command](#suggest-command)
  - [Explain command](#explain-command)
- [[!WARNING]](#warning)
- [References](#references)
<!--toc:end-->

## Overview

This repository provides a plugin for the Zsh terminal that integrates Groq's AI models to offer intelligent command suggestions and explanations. By using Groq's API, you can describe what you want to do in plain English, and the AI will suggest the appropriate terminal command. Additionally, it can explain complex commands that you may not understand.

## Demo

![demo](demo.gif)

## Prerequisites

- For Macos/Linux.
- Installed Python 3, `pygments`
- Installed Zsh, oh-my-zsh
- Sign up or log in to Groq.
- Generate your API key for free usage.

## Installation

### 1. Install the Groq Python Library

First, install the required `groq` Python library:

```zsh
pip install groq
```

### 2. Set Up the API_KEY

Next, add your `GROQ_API_KEY` to your global environment variables:

```zsh
echo "export GROQ_API_KEY=<your-api-key-here>" >> ~/.zshrc && source ~/.zshrc
```

In case you use `zsh` in `.config/zsh` folder, you can add it to your `base.zsh` file:

```zsh
echo "export GROQ_API_KEY=<your-api-key-here>" >> ~/.config/zsh/base.zsh && source ~/.zshrc
```

### 3. Clone the Groq AI Suggestions Repository

Clone the repository into your custom plugins folder in `Oh My Zsh`. This ensures that the plugin is available to use by `zsh`:

```zsh
git clone https://github.com/ThanhTanPM2000/groq_ai_zsh_suggestions.git ~/.oh-my-zsh/custom/plugins/groq_ai_zsh_suggestions
```

Anyone use `.config/zsh` folder just like me, you can clone it into your `.config/zsh` folder:

```zsh
git clone https://github.com/ThanhTanPM2000/groq_ai_zsh_suggestions.git ~/.config/zsh/plugins/groq_ai_zsh_suggestions
```

### 4. Configure Your .zshrc

To activate the plugin, open your `.zshrc` file and add `groq_ai_zsh_suggestions` to the list of plugins. Also, configure the hotkeys for triggering the suggestions and explanations.

1. Open `.zshrc` in your preferred editor:

```zsh
nvim ~/.zshrc # nano ~/.zshrc
```

2. Add the following lines:

If you're using `oh-my-zsh`, add the plugin to your plugins list. On the other hand, if you're using `.config/zsh`, you can skip this step.

```zsh
plugins=(... groq_ai_zsh_suggestions) # should update plugins by adding groq_ai_zsh_suggestions at the end of line
```

3. Apply the changes by sourcing your `.zshrc`:

```zsh
source ~/.oh-my-zsh/custom/plugins/groq_ai_zsh_suggestions/groq_ai_zsh_suggestions.plugin.zsh && \
source ~/.zshrc
```

If You're using "StarShip" instead of "oh-my-zsh" and applying ".config/zsh/base.zsh" file, you can source the plugin like this:

```zsh
source ~/.zshrc
```

## Usage

### Suggest command

Type out what you'd like to do in English, then hit the corresponding hotkey:

- Command + g

### Explain command

- Option + g

### Create a script for the command lines

- Option + shift + g

## [!WARNING]

> This can suggest incorrect or potentially harmful commands. Always review and understand the suggested commands before executing them.
> Using this may incur costs if `Groq` start to require to pay for API_KEY usage. You are responsible for any charges associated with API usage.

## References

This repository is a fork of the [zsh-llm-suggestions](https://github.com/stefanheule/zsh-llm-suggestions) project. The main difference is that this version is tailored to work only with Groq's AI models.
