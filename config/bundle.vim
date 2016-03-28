if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
  call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
  call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
endif
set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('~/.config/nvim'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')

call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-unimpaired')
call dein#add('tpope/vim-repeat')
call dein#add('scrooloose/nerdcommenter')
call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/syntastic')
call dein#add('sjl/gundo.vim')
call dein#add('mattn/webapi-vim')
call dein#add('mattn/gist-vim')

call dein#add('coderifous/textobj-word-column.vim')

call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('airblade/vim-gitgutter')
call dein#add('osyo-manga/vim-over')
call dein#add('junegunn/vim-easy-align')
call dein#add('tmux-plugins/vim-tmux')
call dein#add('arecarn/crunch.vim')

call dein#add('terryma/vim-multiple-cursors')
call dein#add('tommcdo/vim-exchange')
call dein#add('kchmck/vim-coffee-script')
call dein#add('kana/vim-smartinput')
"call dein#add('ervandew/supertab')
call dein#add('Lokaltog/vim-easymotion')
call dein#add('mattn/emmet-vim')
call dein#add('kien/rainbow_parentheses.vim')
call dein#add('AndrewRadev/splitjoin.vim')
call dein#add('gabesoft/vim-ags')
call dein#add('flazz/vim-colorschemes')

call dein#add('marcweber/vim-addon-mw-utils')
call dein#add('tomtom/tlib_vim')
call dein#add('garbas/vim-snipmate')
call dein#add('honza/vim-snippets')

" Filetype Specific
call dein#add('heavenshell/vim-jsdoc')
call dein#add('evidens/vim-twig')
"call dein#add('pangloss/vim-javascript')
call dein#add('othree/yajs.vim')
call dein#add('raichoo/purescript-vim')
call dein#add('leafgarland/typescript-vim')
call dein#add('elixir-lang/vim-elixir')
call dein#add('mxw/vim-jsx')
call dein#add('joukevandermaas/vim-ember-hbs')
call dein#add('mtscout6/syntastic-local-eslint.vim')
call dein#add('isRuslan/vim-es6')

" vim-scripts
call dein#add('Tabular')
call dein#add('ctrlp.vim')
call dein#add('matchit.zip')
call dein#add('ack.vim')

if dein#check_install()
  call dein#install()
endif
call dein#end()
filetype plugin indent on
