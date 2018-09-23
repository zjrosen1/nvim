" ┍--------------------------┑
" | Author: Zack Rosen       |
" | Email: zjrosen@gmail.com |
" ┕--------------------------┙

" [ Prefrences ] {{{1
let mapleader = " "                    " Set global mapleader to space
set noswapfile
set autoindent
set smartindent
set hidden                             " Useful for auto setting hidden buffers
syntax enable                          " Enable syntax highlighting
set nostartofline                      " Don't reset cursor to start of line when moving around
set ttyfast
set history=1000
" Searching/Moving {{{2
" nnoremap / /\v
" vnoremap / /\v
set gdefault                          " Add the g flag to search/replace by default
set incsearch                         " Highlight dynamically as pattern is typed
" set hlsearch
set ignorecase                        " Ignore case when searching
set smartcase                         " Try and be smart about cases
nnoremap j gj
nnoremap k gk
" Appearance {{{2
" set number                                   " Always show line numbers
set numberwidth=3                              " Change the width of line number columns
set listchars=space:\|\,tab:\|\ ,trail:·,eol:¬ " Use new symbols for tabstops and EOLs
set ts=2 sts=2 sw=2 expandtab                  " Default tab stops
set backspace=indent,eol,start
set showcmd                                    " Shows incomplete command
set novb noeb                                  " Turn off visual bell and remove error beeps
set splitbelow                                 " New window goes below
set splitright                                 " New windows goes right
set wildmenu                                   " Enhance command-line completion
set wildmode=longest:full,full
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*.DS_Store
"set encoding=utf-8
set cursorline                        " Highlight current line
set laststatus=2                      " Always show the statusline
set t_Co=256                          " Explicitly tell Vim that the terminal supports 256 colors
" Colors and Theme {{{2
set background=dark
"colorscheme badwolf

" TODO: Get this working better
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_vert_split = 'bg2'

"highlight Pmenu ctermfg=255 ctermbg=120
"highlight PmenuSel ctermfg=16 ctermbg=39

" [ Auto Commands ] {{{1
" Auto source vimrc on save {{{2
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Restore cursor position {{{2
if has("autocmd")
  filetype plugin indent on
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif

" Commit Messages should always start on first line
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
" Set filetype {{{2
" Currently for hbs using the hbs-ember-plugin
"if has("autocmd")
"au BufNewFile,BufRead *.hbs set ft=html
"au BufNewFile,BufRead *.eex set ft=html
"endif
" Save on losing focus {{{2
au FocusLost * :wa

" Lint on save {{{2
autocmd! BufWritePost * Neomake
" let g:neomake_open_list=1
" Resize splits when window is resized {{{2
au VimResized * exe "normal! \<c-w>="
" Clean up nlue: 'United States', label: 'United States' },
" Nasty wysiwig html {{{2
" Install pandoc first
" https://code.google.com/p/pandoc/downloads/list

function! FormatprgLocal(filter)
  if !empty(v:char)
    return 1
  else
    let l:command = v:lnum.','.(v:lnum+v:count-1).'!'.a:filter
    echo l:command
    execute l:command
  endif
endfunction

if has("autocmd")
  let pandoc_pipeline  = "pandoc --from=html --to=markdown"
  let pandoc_pipeline .= " | pandoc --from=markdown --to=html"
  autocmd FileType html setlocal formatexpr=FormatprgLocal(pandoc_pipeline)
endif
" [ Mappings ] {{{1
" Stuff {{{2
cmap w!! %!sudo tee> /dev/null %    " sudo that bitch
command! W w												" Remap :W to :w because shit happens

" nmap _j vipJV"+yu									" For a SO question i answered, joins lines and copies to system clipboard

" like gv but for pasted text
" nnoremap <leader>v V`]

" Not sure about this one quite yet
" nnoremap ; :

" :Wrap to wrap lines command! -nargs=* Wrap set wrap linebreak nolist

" Consistent movements for yank and delete
nnoremap Y y$												" Yank to end of line with Y
nnoremap D d$												" Delete to end of line with D
" Visual Selection {{{2

" Fix linewise visual selection of various text objects
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Don't move on *
nnoremap * *<c-o>

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Searching {{{2
" Control space to search mode
nnoremap <Nul> /

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
" Escaping {{{2
inoremap <C-c> <ESC>
inoremap jj <ESC>
inoremap jk <ESC>
" Spacemacs uses fd
inoremap fd <ESC>

" Force quit
noremap fq :q!<CR>
" Filetype {{{2
nmap _ht :set ft=html<CR>
nmap _ph :set ft=php<CR>
nmap _py :set ft=python<CR>
nmap _rb :set ft=ruby<CR>
nmap _js :set ft=javascript<CR>
nmap _ts :set ft=typescipt<CR>
nmap _zs :set ft=zsh<CR>
nmap _md :set ft=mkd<CR>
nmap _vi :set ft=vim<CR>
" Folding {{{2
nnoremap <Tab> za
" Use leader z to "focus" the current fold
nnoremap <leader>z zMzvzz
" Bubble single lines {{{2
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
" Window Switching {{{2
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Window Resizing {{{2
" Because you guys are a bunch of vaginas {()}
nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>
nnoremap <up> :tabnext<CR>
nnoremap <down> :tabprev<CR>
" Insert Movement {{{2
imap <C-e> <C-o>$
imap <C-a> <C-o>0
imap <C-f> <C-o>l
imap <C-b> <C-o>h
" Indent Mapping {{{2
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-[> >gv
" Viewport Scrolling {{{2
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
" Syntax highlighting groups for word under cursor {{{2
" nmap <C-S-P> :call <SID>SynStack()<CR>
" function! <SID>SynStack()
" 	if !exists("*synstack")
" 		return
" 	endif
" 	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc
" Awesome fucking pasting {{{2
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" F1 gets in the way plus one help to rule them all :h {{{2
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" [ Leader Mappings ] {{{1
" Save a file -- fs {{{2
nmap <leader>fs :w<CR>
" Update vimrc -- v OR ev {{{2
nmap <leader>v :tabedit $MYVIMRC<CR>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" Update .tmux.conf -- tc {{{2
nmap <leader>st :tabedit ~/.tmux.conf<CR>
" Update snipmate -- sc {{{2
nmap <leader>sc :tabedit ~/.vim/bundle/vim-snippets/snippets<CR>
" Toggle Highlighting -- h {{{2
nmap <silent> <leader>h :set hlsearch!<CR>
" Toggle Spell Checking -- s {{{2
nmap <silent> <leader>s :set spell!<CR>

" Toggle loclist -- l {{{2
let g:lt_location_list_toggle_map = '<leader>l'
" Toggle quickfix -- q {{{2
let g:lt_quickfix_list_toggle_map = '<leader>q'
" Ag -- a {{{2
nmap <leader>a :Ag<SPACE>
" Format JSON -- f {{{2
nmap <leader>f :%!python -m json.tool<CR>
" Surround selection with -- ` ' '' {{{2
" TODO: Used to use backticks to turn coffeescript to js
" but then es2015, probably can remove it
" nnoremap <leader>` 0vg_S`  " surround line with `

nnoremap <leader>" viwS"
nnoremap <leader>' viwS'
" Yank to system clipboard -- y {{{2
vnoremap <leader>y "*y
" Tab Editing {{{2
" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" Extras for now {{{2
" Fuck The World
nmap <leader>fw :silent execute "!say -v Daniel -r 120 fuck the world &>/dev/null &" <bar> redraw!<CR>
nmap <leader>fp :silent execute "!killall say &>/dev/null &" <bar> redraw!<CR>

" Fold an html container
nnoremap <leader>ft Vatzf

" TODO: figure this out one day
" This might sort css
" nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" Alphabetically sort CSS properties in file with :SortCSS
" :command! SortCSS :g#\({\n\)\@<=#.,/}/sort

" [ Functions ]{{{1
" Remove trailing white space {{{2
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

" Prune the arglist for matches
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  "	  Building a hash ensures we get each buffer only once
  let buffer_numbers = { }
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Set tabstop, softtabstop and shiftwidth to the same value {{{2
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expantab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" Run Tests {{{2
function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !clear
  if match(a:filename, '\.feature$') != -1
    exec ":!bundle exec cucumber " . a:filename
  elseif match(a:filename, '_test\.rb$') != -1
    if filereadable("bin/testrb")
      exec ":!bin/testrb " . a:filename
    else
      exec ":!ruby -Itest " . a:filename
    end
  else
    if filereadable("Gemfile")
      exec ":!bundle exec rspec --color " . a:filename
    else
      exec ":!rspec --color " . a:filename
    end
  end
endfunction

function! SetTestFile()
  " set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number . " -b")
endfunction

" run test runner
" map <leader>t :call RunTestFile()<cr>
" map <leader>T :call RunNearestTest()<cr>
" Visual Mode */# from Scrooloose {{{2
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
" [ Plugins ] {{{1
" Deoplete {{{2
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1 
set completeopt-=preview

let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
\]
" Neosnippet {{{2
let g:neosnippet#snippets_directory='~/.config/nvim/bundle/neosnippet-snippets/neosnippets'

function! s:tab_complete()
  " is completion menu open? cycle to next item
  if pumvisible()
    return "\<c-n>"
  endif

  " is there a snippet that can be expanded?
  " is there a placholder inside the snippet that can be jumped to?
  if neosnippet#expandable_or_jumpable() 
    return "\<Plug>(neosnippet_expand_or_jump)"
  endif

  " if none of these match just use regular tab
  return "\<tab>"
endfunction

imap <silent><expr><TAB> <SID>tab_complete()
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
" Easy-motion {{{2
let g:EasyMotion_leader_key = ','
hi EasyMotionTarget ctermbg=none ctermfg=DarkRed
" hi EasyMotionShade  ctermbg=none ctermfg=DarkGray
" Snipmate {{{2
" imap <C-J> <Plug>snipMateNextOrTrigger
" smap <C-J> <Plug>snipMateNextOrTrigger
" Emmet {{{2
let g:user_emmet_leader_key = '<c-e>'
"Fugitive Git {{{2
nmap <leader>ga :Git add -A<CR>
nmap <leader>gc :Gcommit -a<CR>
nmap <leader>gp :Git push<CR>
" CoffeeScript {{{2
nnoremap <leader>cw :CoffeeWatch<cr>
nnoremap <leader>cr :CoffeeRun<cr>
" CtrlP {{{2
let g:ctrlp_custom_ignore = '\v[\/](transpiled)|dist|tmp|bower_components|node_modules|(\.(swp|git|bak|pyc|DS_Store))$'
let g:ctrlp_match_window_bottom = 0 " Show at top of window
"let g:ctrlp_working_path_mode = 2 " Smart path mode
let g:ctrlp_mru_files = 1 " Enable Most Recently Used files feature
let g:ctrlp_max_height = 18
let g:ctrlp_jump_to_buffer = 2 " Jump to tab AND buffer if already open
let g:ctrlp_split_window = 1 " <CR> = 1 - Tab, 2 - Horizontal, 3 - Vertical
" MultipleCursors {{{2
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_quit_key='<C-j>'
" Mustache {{{2
let g:mustache_abbreviations = 1
" NerdCommenter {{{2
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" NerdTree {{{2
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=45
let g:NERDTreeAutoDeleteBuffer=1

autocmd vimenter * if !argc() | NERDTree | endif " Load NERDTree by default for directory

map <C-n><C-t> :NERDTreeToggle<CR>
map <leader>nt :NERDTreeToggle<CR>
" Airline {{{2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
"let g:airline_theme = 'powerlineish'
" Rainbow Parens {{{2
" nmap <leader>r :RainbowParenthesesToggle<CR>
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
" let g:rbpt_max = 16
" let g:rbpt_loadcmd_toggle = 0
" Syntastic {{{2
function! JavascriptLinter(curpath)
  let parent=1
  let local_path=a:curpath
  let local_jscs=local_path . '.jscsrc'
  let local_eslint=local_path . '.eslintrc'

  while parent <= 255
    let parent = parent + 1
    if filereadable(local_jscs)
      return ['jscs']
    endif
    if filereadable(local_eslint)
      return ['eslint']
    endif
    let local_path = local_path . "../"
    let local_jscs = local_path . '.jscsrc'
    let local_eslint = local_path . '.eslintrc'
  endwhile

  unlet parent local_jscs

  return ['jshint']
endfunction
let g:syntastic_javascript_checkers=JavascriptLinter(getcwd() . "/")
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 1
nmap <leader>st :SyntasticToggleMode<cr>
let g:syntastic_mode_map={ 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['html', 'handlebars'] }

"let g:syntastic_typescript_checkers = ['tsc']
let g:syntastic_typescript_checkers = ['tslint', 'tsc']
let g:syntastic_typescript_tsc_args = "-t ES5 --module commonjs --experimentalDecorators"
" Toggle errors
" Tabularize {{{2
vmap <Enter> <Plug>(EasyAlign)
if exists(":Tabularize")
  nmap <leader>tf vip :Tabularize /from<CR>
  vmap <leader>tf :Tabularize /from<CR>
  nmap <leader>t= :Tabularize /=<CR>
  vmap <leader>t= :Tabularize /=<CR>
  nmap <leader>t: :Tabularize /:\zs<CR>
  vmap <leader>t: :Tabularize /:\zs<CR>
  nmap <leader>t> :Tabularize /=><CR>
  vmap <leader>t> :Tabularize /=><CR>
endif
" Ag The Silver Searcher {{{2
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" JsDoc {{{2
nmap <silent> <leader>js <Plug>(jsdoc)
" Git Gutter {{{2
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
nmap <leader>gt :GitGutterToggle<cr>
" Unite {{{2
"nmap <leader>b :Unite -start-insert buffer<cr>
"nmap <leader>fd :Unite -start-insert file<cr>

" Fuzzy match by default
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])

" Fuzzy matching for plugins not using matcher_default as filter
"call unite#custom#source('outline,line,grep,session', 'matchers', ['matcher_fuzzy'])

"call unite#custom#source('file_rec,file_rec/async,file_mru,file,grep',
            "\ 'ignore_pattern', join([
            "\ '\.swp', '\.swo', '\~$',
            "\ '\.git/', '\.svn/', '\.hg/',
            "\ '^tags$', '\.taghl$',
            "\ '\.ropeproject/', '\.pbxproj$', '\.xcodeproj', '\.vcproj', 
            "\ 'node_modules/', 'bower_components/', 'log/', 'tmp/', 'obj/',
            "\ '/vendor/gems/', '/vendor/cache/', '\.bundle/', '\.sass-cache/',
            "\ '/tmp/cache/assets/.*/sprockets/', '/tmp/cache/assets/.*/sass/',
            "\ 'thirdparty/', 'Debug/', 'Release/', 'build/', 'dist/',
            "\ 'web/static/components/', 'web/static/external/', 'web/static/images/',
            "\ '\.pyc$', 'pb2\.py$', '\.class$', '\.jar$', '\.min\.js$',
            "\ '\.jpg$', '\.jpeg$', '\.bmp$', '\.png$', '\.gif$',
            "\ '\.o$', '\.out$', '\.obj$', '\.rbc$', '\.rbo$', '\.gem$',
            "\ '\.zip$', '\.tar\.gz$', '\.tar\.bz2$', '\.rar$', '\.tar\.xz$'
            "\ ], '\|'))

"let g:unite_source_history_yank_enable = 1

" Prettier prompt
"call unite#custom#profile('default', 'context', {
    "\   'prompt': '» ',
    "\   'start_insert': 1,
    "\   'update_time': 200,
    "\   'cursor_line_highlight': 'UniteSelectedLine',
    "\   'direction': 'botright',
    "\   'prompt_direction': 'top',
    "\ })

"if executable('ag')
  "let g:unite_source_grep_command = 'ag'
  "let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore-case --ignore tags'
  "let g:unite_source_grep_recursive_opt = ''
"endif 
" Gist {{{2
nmap <leader>gl :Gist -l<cr>
let g:gist_show_privates = 1
let g:gist_list_vsplit = 1
let g:gist_detect_filetype = 1
" Over {{{2
nnoremap <leader>fr :call VisualFindAndReplace()<CR>
xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>
let g:over_enable_auto_nohlsearch = 1
function! VisualFindAndReplace()
  :OverCommandLine%s/
  :w
endfunction
function! VisualFindAndReplaceWithSelection() range
  :'<,'>OverCommandLine s/
  :w
endfunction
" [ Modeline ] {{{1
set modelines=1
" }}}

" vim: set foldmethod=marker:
