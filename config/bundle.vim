if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin(expand('~/.cache/dein'))

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/denite.nvim')

  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-abolish')

  call dein#add('scrooloose/nerdcommenter')
  call dein#add('scrooloose/nerdtree')


  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  " call dein#add('mattn/webapi-vim')
  " call dein#add('mattn/gist-vim')

  " Theme
  call dein#add('morhetz/gruvbox')

  call dein#add('brooth/far.vim')

  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('sjl/gundo.vim')
  call dein#add('coderifous/textobj-word-column.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('osyo-manga/vim-over')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('arecarn/crunch.vim')

  call dein#add('Raimondi/delimitMate', {'on_ft': ['javascript', 'typescript', 'css', 'scss']})
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('tommcdo/vim-exchange')
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('mattn/emmet-vim', {'on_ft': 'html'})
  call dein#add('AndrewRadev/splitjoin.vim')
  call dein#add('Valloric/ListToggle')
  call dein#add('ryanoasis/vim-devicons')
  " call dein#add('marcweber/vim-addon-mw-utils')
  " call dein#add('tomtom/tlib_vim')

  call dein#add('editorconfig/editorconfig-vim')

  call dein#add('vim-scripts/Tabular')
  call dein#add('vim-scripts/matchit.zip')

  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
  " Filetype Specific
  " Javascript
  " call dein#add('ternjs/tern_for_vim', {'on_ft': 'javascript'})

  call dein#add('heavenshell/vim-jsdoc', {'on_ft': 'javascript'})
  call dein#add('pangloss/vim-javascript', {'on_ft': 'javascript'})
  call dein#add('leafgarland/typescript-vim', {'on_ft': 'typescript'})
  call dein#add('peitalin/vim-jsx-typescript')
  call dein#add('mxw/vim-jsx', {'on_ft': 'javascript'})
  call dein#add('mtscout6/syntastic-local-eslint.vim', {'on_ft': 'javascript'})
  call dein#add('joukevandermaas/vim-ember-hbs')

  " Go
  call dein#add('fatih/vim-go')

  " Ruby
  " call dein#add('tpope/vim-rails')

  " Elixer
  "call dein#add('elixir-lang/vim-elixir')

  " PHP
  " call dein#add('StanAngeloff/php.vim')

 call dein#end()
 call dein#save_state()
endif

filetype plugin indent on
