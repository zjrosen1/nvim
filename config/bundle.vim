if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
  call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
  call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
endif

if &compatible
  set nocompatible
endif
set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('~/.cache/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/denite.nvim')

call dein#add('neomake/neomake')

call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-unimpaired')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-abolish')

call dein#add('scrooloose/nerdcommenter')
call dein#add('scrooloose/nerdtree')

call dein#add('mattn/webapi-vim')
call dein#add('mattn/gist-vim')

call dein#add('itchyny/lightline.vim')
call dein#add('sjl/gundo.vim')
call dein#add('coderifous/textobj-word-column.vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('osyo-manga/vim-over')
call dein#add('junegunn/vim-easy-align')
call dein#add('arecarn/crunch.vim')
" call dein#add('tmux-plugins/vim-tmux')

" call dein#add('kana/vim-smartinput')
call dein#add('Raimondi/delimitMate', {'on_ft': ['javascript', 'typescript', 'css', 'scss']})
call dein#add('terryma/vim-multiple-cursors')
call dein#add('tommcdo/vim-exchange')
call dein#add('Lokaltog/vim-easymotion')
call dein#add('mattn/emmet-vim', {'on_ft': 'html'})
call dein#add('AndrewRadev/splitjoin.vim')
call dein#add('flazz/vim-colorschemes') 
call dein#add('Valloric/ListToggle')
" call dein#add('marcweber/vim-addon-mw-utils')
" call dein#add('tomtom/tlib_vim')
" call dein#add('garbas/vim-snipmate')
" call dein#add('honza/vim-snippets')

call dein#add('editorconfig/editorconfig-vim')

" Filetype Specific
" Javascript
call dein#add('carlitux/deoplete-ternjs', {'on_ft': 'javascript'})
call dein#add('ternjs/tern_for_vim', {'on_ft': 'javascript'})
call dein#add('heavenshell/vim-jsdoc', {'on_ft': 'javascript'})
call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})
" call dein#add('othree/javascript-libraries-syntax.vim', {'on_ft': 'javascript'})
" call dein#add('pangloss/vim-javascript', {'on_ft': 'javascript'})
call dein#add('leafgarland/typescript-vim', {'on_ft': 'typescript'})
call dein#add('mxw/vim-jsx', {'on_ft': 'javascript'})
call dein#add('mtscout6/syntastic-local-eslint.vim', {'on_ft': 'javascript'})
call dein#add('joukevandermaas/vim-ember-hbs')
" call dein#add('isRuslan/vim-es6')
" call dein#add('kchmck/vim-coffee-script')
" call dein#add('evidens/vim-twig')
" call dein#add('raichoo/purescript-vim')

" Elixer
"call dein#add('elixir-lang/vim-elixir')

" PHP
call dein#add('StanAngeloff/php.vim')

call dein#add('vim-scripts/Tabular')
call dein#add('vim-scripts/ctrlp.vim')
call dein#add('vim-scripts/matchit.zip')
call dein#add('vim-scripts/ag.vim')

if dein#check_install()
  call dein#install()
endif

call dein#end()
filetype plugin indent on
