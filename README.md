[![](http://img.shields.io/badge/unicorn-approved-ff69b4.svg)](https://www.youtube.com/watch?v=9auOCbH5Ns4)

## Requirements

### Neovim

`brew install neovim/neovim/neovim`

### Python 2 & 3 Support

`pip install neovim`
`pip3 install neovim`

### Ruby Support

`gem install neovim`

### Ag (The Silver Searcher)

`brew install the_silver_searcher`

## Installation
_Simple AF_

```bash
mkdir ~/.config
git clone http://github.com/zjrosen1/nvim.git ~/.config/nvim
nvim
```

## Plugin Manager
[Denite](https://github.com/Shougo/denite.nvim)

Add a new plugin inside of ~/.config/nvim/config/bundle.vim

`call dein#add('neomake/neomake')`

## Autocompletion
[Deoplete](https://github.com/Shougo/deoplete.nvim)

Add Tern for javascript completion

- Install tern globally

`npm install -g tern`

- Include a `.tern-project` file in the root of your project

## Syntax Checking
[Neomake](https://github.com/neomake/neomake)

[Unimpaired](https://github.com/tpope/vim-unimpaired) is included so you can switch between next and previous errors in the loclist with `]l [l` respectively 

Toggle the loclist window with `<leader>l`

## Fuzzy Finder
[CtrlP](https://github.com/kien/ctrlp.vim)

Takes advantage of ag for faster searching.

## Project Search
[Ag.vim](https://github.com/rking/ag.vim)

The following mapping will open the command prompt

`:Ag search`

## Snippets
[Neosnippet](https://github.com/Shougo/neosnippet.vim)

Snippets Path
`~/.config/nvim/bundle/neosnippet-snippets/neosnippets/`

- Expand a snippet
`f<ctrl-j>`

`<tab>` or `<ctrl-j>` to jump to the next marker in the snippet
