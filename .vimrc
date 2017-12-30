set nocompatible
set encoding=utf-8
scriptencoding utf-8

set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
set number
set cursorline
set laststatus=2
set cmdheight=2
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set confirm
set autoread
set nobackup
set noswapfile
set tabstop=2
set expandtab
set shiftwidth=2
set smarttab
set list
set listchars=tab:>\
set wildmenu
set backspace=indent,eol,start
syntax on
colorscheme molokai
set t_Co=256

if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする・・・・・・①
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" ここに追加したいVimプラグインを記述する・・・・・・②

" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'
"----------------------------------------------------------
" ステータスラインの設定
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する

" 末尾の全角と半角の空白文字を赤くハイライト
NeoBundle 'bronson/vim-trailing-whitespace'


if has('lua') " lua機能が有効になっている場合・・・・・・①
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    NeoBundle "Shougo/neosnippet"
    " スニペット集
    NeoBundle 'Shougo/neosnippet-snippets'
endif

"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1

"----------------------------------------------------------
call neobundle#end()


" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定・・・・・・③
NeoBundleCheck


