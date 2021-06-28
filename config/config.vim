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
" Save on losing focus {{{2
au FocusLost * :wa
" Lint on save {{{2
" autocmd! BufWritePost * Neomake
" let g:neomake_open_list=1
" let g:neomake_javascript_enabled_makers = ['eslint']

let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
" let g:ale_fix_on_save = 1
" Resize splits when window is resized {{{2
au VimResized * exe "normal! \<c-w>="
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
cmap w!! %!sudo tee> /dev/null %
command! W w												" Remap :W to :w because shit happens

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
" Dont let the people use the arrow keys in vim xD
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
" nmap <leader>fs :w<CR>
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
" Format JSON -- f {{{2
" nmap <leader>f :%!python -m json.tool<CR>
" Surround selection with -- ` ' '' {{{2
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
" Fold an html container
nnoremap <leader>ft Vatzf
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

" Visual Mode */# from Scrooloose {{{2
" function! s:VSetSearch()
"   let temp = @@
"   norm! gvy
"   let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
"   let @@ = temp
" endfunction

" vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
" [ Plugins ] {{{1
" FZF {{{2
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': {'width': 0.90, 'height': 0.90} }

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>fs :RG<CR>
" Deoplete {{{2
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
" set completeopt-=preview

" let g:tern#command = ["tern"]
" let g:tern#arguments = ["--persistent"]

" let g:deoplete#omni#functions = {}
" let g:deoplete#omni#functions.javascript = [
"   \ 'tern#Complete',
" \]

" call deoplete#custom#option('sources', {
" \ '_': ['ale'],
" \})
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
map <leader>nf :NERDTreeFind<CR>
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
" nmap <leader>gt :GitGutterToggle<cr>
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
" vim-go {{{2
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_metalinter_command = 'gopls'
let g:go_fmt_command = 'goimports'
let g:go_gopls_staticcheck = 1
let g:go_metalinter_autosave = 1

let g:go_def_mapping_enabled = 0
let g:go_auto_type_info = 1
let g:go_debug_windows = {
      \ 'vars':       'rightbelow 60vnew',
      \ 'stack':      'rightbelow 10new',
\ }
map <leader>gi :GoImports<CR>
map <leader>gt :GoTest<CR>
map <leader>gr :GoRun<CR>
map <leader>gd :GoDebugStart<CR>
map <leader>gc :GoDebugContinue<CR>
map <leader>gb :GoDebugBreakpoint<CR>
" Coc {{{2
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
