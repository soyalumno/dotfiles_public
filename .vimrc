set encoding=utf-8

" SpaceをLeaderキーに
let mapleader = "\<Space>"

" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dotfiles/vim/dein.toml'
let s:lazy_file = fnamemodify(expand('<sfile>'), ':h').'/dotfiles/vim/lazy.toml'

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy' : 0})
  call dein#load_toml(s:lazy_file, {'lazy' : 1})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}


" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}


" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}
" }}}

packadd! dracula
syntax enable
filetype on
filetype plugin indent on

if has('vim_starting')
  "挿入モード時に非点滅の縦棒タイプのカーソル
  let &t_SI .= "\e[6 q"
  " ノーマルモード時に非点滅のブロックタイプのカーソル
  let &t_EI .= "\e[2 q"
  " 置換モード時に非点滅の下線タイプのカーソル
  let &t_SR .= "\e[4 q"
endif


"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
  " Windows用
  set guifont=VL_Gothic:cSHIFTJIS:qDRAFT:h9
  "set guifont=MS_Mincho:cSHIFTJIS:h12
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  " if has('kaoriya')
    " set ambiwidth=auto
  " endif
elseif has('mac')
  "set guifont=Osaka－等幅:h14
  set guifont=Ricty_Diminished:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif
" ○▲□※などの表示が崩れる問題を解決
set ambiwidth=double

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  inoremap <ESC> <ESC>:set iminsert=0<CR>
  " for MacVim
  set imdisable
endif

"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
set guioptions+=a

" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
" set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する
" コマンドラインの補完
" set wildmode=list:longest
set wildmenu
set history=5000
" 折り返し時に表示行単位での移動できるようにする
nmap j gj
nmap k gk
" 行頭・行末にカーソル移動
map <S-h>  ^
map <S-j>  }
map <S-k>  {
map <S-l>  $
" バッファ全体のインデント整理
nmap == gg=G''

" ステータスライン
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

" vim-lspの定義ジャンプが出来ないときは、通常の処理を行う
nnoremap <expr> <C-]> execute('LspPeekDefinition') =~ "not supported" ? "g\<C-]>" : ":LspDefinition<cr>"

" 検索時にvery magicを有効化
nnoremap /  /\v

" ファイルジャンプ時に行番号を参照
nnoremap gf gF

" Tab系
" 不可視文字を可視化
set list listchars=tab:>-,trail:-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
" ESCキー2度押しでハイライトの切り替え
" nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
" ESCはKarabinerで紐付けるので不要
"inoremap <C-j> <esc>
"inoremap jj <ESC>

" 分割ウィンドウのサイズ変更
nmap - <C-w>-
nmap + <C-w>+
" ウィンドウ分割を楽にする設定
" 水平
nnoremap ss :<C-u>sp<CR>
" 垂直
nnoremap sv :<C-u>vs<CR>
" 閉じる
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-

" カラースキーム
set t_Co=256
""colorscheme lucius
colorscheme hybrid
""colorscheme molokai
""colorscheme dracula

try
  silent hi CursorIM
catch /E411/
  " CursorIM (IME ON中のカーソル色)が定義されていなければ、紫に設定
  hi CursorIM ctermfg=16 ctermbg=127 guifg=#000000 guibg=#af00af
endtry

" セッションを跨いだundo情報の保持禁止
set noundofile

" quickfixに項目数を表示する
" setlocal statusline+=\ %L
" 検索結果をQuickFix-Windowに出力
autocmd QuickFixCmdPost *grep* cwindow

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

" tagsの設定(末尾の;は上方検索の意味)
set tags=./tags,tags;

" キーワード補完の候補
set complete-=i " インクルードファイル無効
set complete-=t " タグ無効

" 日本語入力がオンのままでも使えるコマンド
nmap あ a
nmap い i
nmap う u
nmap え e
nmap お o
nmap ｄｄ dd
nmap ｙｙ yy

" EOLの挿入を抑制
set noeol

au BufRead,BufNewFile *.txt set filetype=txt

" HTML出力時のフォント指定
let g:html_font = "VL Gothic"

" UTF-8対応
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

" バイナリ形式ファイル
" vim -b : edit binary using xxd-format!
augroup BinaryXXD
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost * if &bin | silent %!xxd -g 1
  au BufReadPost * set ft=xxd | endif
  au BufWritePre * if &bin | %!xxd -r
  au BufWritePre * endif
  au BufWritePost * if &bin | silent %!xxd -g 1
  au BufWritePost * set nomod | endif
augroup END

" カレントディレクトリの変更
set autochdir

" set guicursor+=a:blinkon1700-blinkoff700	" カーソルのブリンクをまったりさせる
set nofixendofline                " Windowsのエディタの人達に嫌われない設定

set helplang=ja,en

set backspace=indent,eol,start

set clipboard+=unnamed

" キーコードシーケンスの終了待ちを短くする
" - ESCキー押下時の待ち時間対応
set ttimeoutlen=10

" インクリメントを10進数に
set nf=""

" 折りたたみ方式をインデント単位に
"set foldmethod=indent
set foldmethod=manual
set foldlevel=100

" netrw
let g:netrw_liststyle=3
let g:netrw_sizestyle="H"
let g:netrw_banner=0
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview=1
let g:netrw_altv=1
let g:netrw_alto=1
let g:netrw_browse_split=4
let g:netrw_winsize=25
let g:netrw_keepdir=0
let g:netrw_fastbrowse=0
let g:netrw_list_hide = '.DS_Store'

"Netrw を toggle する関数を設定
"元処理と異なり Vex を呼び出すことで左 window に表示
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Vex
    endif
endfunction
nnoremap <C-e> :call ToggleNetrw()<CR>

" enc sjis
nnoremap <Leader>sj :e ++enc=sjis<CR>

" コード補完の挙動
" - menuone:対象が1件でもメニューを表示
" - noinsert:勝手に挿入しない
set completeopt=menuone,noinsert
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
" 上下選択時に挿入を行わない
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" ターミナル
set termwinsize=20x0
nnoremap <Leader>bt :bo term<CR>

" 括弧補完
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>

"全角スペースをハイライト表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
  augroup ZenkakuSpace
  autocmd!
  autocmd ColorScheme       * call ZenkakuSpace()
  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif