" vim:fdm=marker
" Vim Color File
" Name:       onedark.vim
" Maintainer: https://github.com/joshdick/onedark.vim/
" License:    The MIT License (MIT)
" Based On:   https://github.com/MaxSt/FlatColor/

" Companion statusline plugin and terminal themes are included with onedark.vim:
"  * https://github.com/joshdick/onedark.vim#lightlinevim-colorscheme
"  * https://github.com/joshdick/onedark.vim#vim-airline-theme
"  * https://github.com/joshdick/onedark.vim/tree/main/term

" Color Reference {{{

" The following colors were measured inside Atom using its built-in inspector.

" +---------------------------------------------+
" |  Color Name  |         RGB        |   Hex   |
" |--------------+--------------------+---------|
" | Black        | rgb(40, 44, 52)    | #282c34 |
" |--------------+--------------------+---------|
" | White        | rgb(171, 178, 191) | #abb2bf |
" |--------------+--------------------+---------|
" | Light Red    | rgb(224, 108, 117) | #e06c75 |
" |--------------+--------------------+---------|
" | Dark Red     | rgb(190, 80, 70)   | #be5046 |
" |--------------+--------------------+---------|
" | Green        | rgb(152, 195, 121) | #98c379 |
" |--------------+--------------------+---------|
" | Light Yellow | rgb(229, 192, 123) | #e5c07b |
" |--------------+--------------------+---------|
" | Dark Yellow  | rgb(209, 154, 102) | #d19a66 |
" |--------------+--------------------+---------|
" | Blue         | rgb(97, 175, 239)  | #61afef |
" |--------------+--------------------+---------|
" | Magenta      | rgb(198, 120, 221) | #c678dd |
" |--------------+--------------------+---------|
" | Cyan         | rgb(86, 182, 194)  | #56b6c2 |
" |--------------+--------------------+---------|
" | Gutter Grey  | rgb(76, 82, 99)    | #4b5263 |
" |--------------+--------------------+---------|
" | Comment Grey | rgb(92, 99, 112)   | #5c6370 |
" +---------------------------------------------+

" }}}

" Initialization {{{

highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let g:colors_name="onedark"

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
" (a 16-color palette for this color scheme is available; see
" < https://github.com/joshdick/onedark.vim/blob/main/README.md >
" for more information.)
if !exists("g:onedark_termcolors")
  let g:onedark_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:onedark_terminal_italics")
  let g:onedark_terminal_italics = 0
endif

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
let s:group_colors = {} " Cache of default highlight group settings, for later reference via `onedark#extend_highlight`
function! s:h(group, style, ...)
  if (a:0 > 0) " Will be true if we got here from onedark#extend_highlight
    let s:highlight = s:group_colors[a:group]
    for style_type in ["fg", "bg", "sp"]
      if (has_key(a:style, style_type))
        let l:default_style = (has_key(s:highlight, style_type) ? copy(s:highlight[style_type]) : { "cterm16": "NONE", "cterm": "NONE", "gui": "NONE" })
        let s:highlight[style_type] = extend(l:default_style, a:style[style_type])
      endif
    endfor
    if (has_key(a:style, "gui"))
      let s:highlight.gui = a:style.gui
    endif
  else
    let s:highlight = a:style
    let s:group_colors[a:group] = s:highlight " Cache default highlight group settings
  endif

  if g:onedark_terminal_italics == 0
    if has_key(s:highlight, "cterm") && s:highlight["cterm"] == "italic"
      unlet s:highlight.cterm
    endif
    if has_key(s:highlight, "gui") && s:highlight["gui"] == "italic"
      unlet s:highlight.gui
    endif
  endif

  if g:onedark_termcolors == 16
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(s:highlight, "fg") ? s:highlight.fg.cterm : "NONE")
    let l:ctermbg = (has_key(s:highlight, "bg") ? s:highlight.bg.cterm : "NONE")
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(s:highlight, "fg")    ? s:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(s:highlight, "bg")    ? s:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(s:highlight, "sp")    ? s:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(s:highlight, "gui")   ? s:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(s:highlight, "cterm") ? s:highlight.cterm    : "NONE")
endfunction

" public {{{

function! onedark#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction

function! onedark#extend_highlight(group, style)
  call s:h(a:group, a:style, 1)
endfunction

" }}}

" }}}

" Color Variables {{{

let s:colors = onedark#GetColors()

let s:red = s:colors.red
let s:dark_red = s:colors.dark_red
let s:green = s:colors.green
let s:yellow = s:colors.yellow
let s:dark_yellow = s:colors.dark_yellow
let s:blue = s:colors.blue
let s:purple = s:colors.purple
let s:cyan = s:colors.cyan
let s:white = s:colors.white
let s:black = s:colors.black
let s:foreground = s:colors.foreground
let s:background = s:colors.background
let s:comment_grey = s:colors.comment_grey
let s:gutter_fg_grey = s:colors.gutter_fg_grey
let s:cursor_grey = s:colors.cursor_grey
let s:visual_grey = s:colors.visual_grey
let s:menu_grey = s:colors.menu_grey
let s:special_grey = s:colors.special_grey
let s:vertsplit = s:colors.vertsplit

" }}}

" Terminal Colors {{{

let g:terminal_ansi_colors = [
  \ s:black.gui, s:red.gui, s:green.gui, s:yellow.gui,
  \ s:blue.gui, s:purple.gui, s:cyan.gui, s:comment_grey.gui,
  \ s:visual_grey.gui, s:red.gui, s:green.gui, s:yellow.gui,
  \ s:blue.gui, s:purple.gui, s:cyan.gui, s:white.gui
\]

" }}}

" Syntax Groups (descriptions and ordering from `:h w18`) {{{

call s:h("Comment", { "fg": s:comment_grey, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:cyan }) " any constant
call s:h("String", { "fg": s:green }) " a string constant: "this is a string"
call s:h("Character", { "fg": s:green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:dark_yellow }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:dark_yellow }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:dark_yellow }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:red }) " any variable name
call s:h("Function", { "fg": s:blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:purple }) " any statement
call s:h("Conditional", { "fg": s:purple }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:purple }) " for, do, while, etc.
call s:h("Label", { "fg": s:purple }) " case, default, etc.
call s:h("Operator", { "fg": s:purple }) " sizeof", "+", "*", etc.
call s:h("Keyword", { "fg": s:purple }) " any other keyword
call s:h("Exception", { "fg": s:purple }) " try, catch, throw
call s:h("PreProc", { "fg": s:yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:blue }) " preprocessor #include
call s:h("Define", { "fg": s:purple }) " preprocessor #define
call s:h("Macro", { "fg": s:purple }) " same as Define
call s:h("PreCondit", { "fg": s:yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:yellow }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:yellow }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:yellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:yellow }) " A typedef
call s:h("Special", { "fg": s:blue }) " any special symbol
call s:h("SpecialChar", { "fg": s:dark_yellow }) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:comment_grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:red }) " any erroneous construct
call s:h("Todo", { "fg": s:purple }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" }}}

" Highlighting Groups (descriptions and ordering from `:h highlight-groups`) {{{
call s:h("ColorColumn", { "bg": s:cursor_grey }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:black, "bg": s:blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
if &diff
  " Don't change the background color in diff mode
  call s:h("CursorLine", { "gui": "underline" }) " the screen line that the cursor is in when 'cursorline' is set
else
  call s:h("CursorLine", { "bg": s:cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
endif
call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:green, "fg": s:black }) " diff mode: Added line
call s:h("DiffChange", { "fg": s:yellow, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:red, "fg": s:black }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:yellow, "fg": s:black }) " diff mode: Changed text within a changed line
if get(g:, 'onedark_hide_endofbuffer', 0)
    " If enabled, will style end-of-buffer filler lines (~) to appear to be hidden.
    call s:h("EndOfBuffer", { "fg": s:black }) " filler lines (~) after the last line in the buffer
endif
call s:h("ErrorMsg", { "fg": s:red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:vertsplit }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:comment_grey }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:yellow, "bg": s:comment_grey }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
call s:h("LineNr", { "fg": s:gutter_fg_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:blue, "gui": "underline", "cterm": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:foreground, "bg": s:background }) " normal text
" call s:h("Pmenu", { "fg": s:white, "bg": s:menu_grey }) " Popup menu: normal item.
call s:h("Pmenu", { "fg": s:white, "bg": s:special_grey }) " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:cursor_grey, "bg": s:blue }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:cursor_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:purple }) " hit-enter prompt and yes/no questions
call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow }) " Current quickfix item in the quickfix window.
call s:h("Search", { "fg": s:black, "bg": s:yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:dark_yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:white, "bg": s:cursor_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
call s:h("StatusLineTerm", { "fg": s:white, "bg": s:cursor_grey }) " status line of current :terminal window
call s:h("StatusLineTermNC", { "fg": s:comment_grey }) " status line of non-current :terminal window
call s:h("TabLine", { "fg": s:comment_grey }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white }) " tab pages line, active tab page label
call s:h("Terminal", { "fg": s:white, "bg": s:black }) " terminal window (see terminal-size-color)
call s:h("Title", { "fg": s:green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "bg": s:visual_grey }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:yellow }) " warning messages
call s:h("WildMenu", { "fg": s:black, "bg": s:blue }) " current match in 'wildmenu' completion

" }}}

" Termdebug highlighting for Vim 8.1+ {{{

" See `:h hl-debugPC` and `:h hl-debugBreakpoint`.
call s:h("debugPC", { "bg": s:special_grey }) " the current position
call s:h("debugBreakpoint", { "fg": s:black, "bg": s:red }) " a breakpoint

" }}}

" Language-Specific Highlighting {{{

" Fish Shell
call s:h("fishKeyword", { "fg": s:purple })
call s:h("fishConditional", { "fg": s:purple })

" Plugin Highlighting {{{

" airblade/vim-gitgutter
call s:h("GitGutterAdd", { "fg": s:green })
call s:h("GitGutterChange", { "fg": s:yellow })
call s:h("GitGutterDelete", { "fg": s:red })

" dense-analysis/ale
call s:h("ALEError", { "fg": s:red, "gui": "underline", "cterm": "underline" })
call s:h("ALEWarning", { "fg": s:yellow, "gui": "underline", "cterm": "underline"})
call s:h("ALEInfo", { "gui": "underline", "cterm": "underline"})

" easymotion/vim-easymotion
call s:h("EasyMotionTarget", { "fg": s:red, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2First", { "fg": s:yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionTarget2Second", { "fg": s:dark_yellow, "gui": "bold", "cterm": "bold" })
call s:h("EasyMotionShade",  { "fg": s:comment_grey })

" lewis6991/gitsigns.nvim
hi link GitSignsAdd    GitGutterAdd
hi link GitSignsChange GitGutterChange
hi link GitSignsDelete GitGutterDelete

" mhinz/vim-signify
hi link SignifySignAdd    GitGutterAdd
hi link SignifySignChange GitGutterChange
hi link SignifySignDelete GitGutterDelete

" neoclide/coc.nvim
call s:h("CocErrorSign", { "fg": s:red })
call s:h("CocWarningSign", { "fg": s:yellow })
call s:h("CocInfoSign", { "fg": s:blue })
call s:h("CocHintSign", { "fg": s:cyan })

" neomake/neomake
call s:h("NeomakeErrorSign", { "fg": s:red })
call s:h("NeomakeWarningSign", { "fg": s:yellow })
call s:h("NeomakeInfoSign", { "fg": s:blue })

" plasticboy/vim-markdown (keep consistent with Markdown, above)
call s:h("mkdDelimiter", { "fg": s:purple })
call s:h("mkdHeading", { "fg": s:red })
call s:h("mkdLink", { "fg": s:blue })
call s:h("mkdURL", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })

" prabirshrestha/vim-lsp
call s:h("LspError", { "fg": s:red })
call s:h("LspWarning", { "fg": s:yellow })
call s:h("LspInformation", { "fg": s:blue })
call s:h("LspHint", { "fg": s:cyan })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:green })
call s:h("diffRemoved", { "fg": s:red })

" }}}

" Git Highlighting {{{

call s:h("gitcommitComment", { "fg": s:comment_grey })
call s:h("gitcommitUnmerged", { "fg": s:green })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:purple })
call s:h("gitcommitDiscardedType", { "fg": s:red })
call s:h("gitcommitSelectedType", { "fg": s:green })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:cyan })
call s:h("gitcommitDiscardedFile", { "fg": s:red })
call s:h("gitcommitSelectedFile", { "fg": s:green })
call s:h("gitcommitUnmergedFile", { "fg": s:yellow })
call s:h("gitcommitFile", {})
call s:h("gitcommitSummary", { "fg": s:white })
call s:h("gitcommitOverflow", { "fg": s:red })

hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile

" }}}

" Neovim-Specific Highlighting {{{

if has("nvim")
  " Neovim terminal colors {{{
  let g:terminal_color_0 =  s:black.gui
  let g:terminal_color_1 =  s:red.gui
  let g:terminal_color_2 =  s:green.gui
  let g:terminal_color_3 =  s:yellow.gui
  let g:terminal_color_4 =  s:blue.gui
  let g:terminal_color_5 =  s:purple.gui
  let g:terminal_color_6 =  s:cyan.gui
  let g:terminal_color_7 =  s:white.gui
  let g:terminal_color_8 =  s:visual_grey.gui
  let g:terminal_color_9 =  s:dark_red.gui
  let g:terminal_color_10 = s:green.gui " No dark version
  let g:terminal_color_11 = s:dark_yellow.gui
  let g:terminal_color_12 = s:blue.gui " No dark version
  let g:terminal_color_13 = s:purple.gui " No dark version
  let g:terminal_color_14 = s:cyan.gui " No dark version
  let g:terminal_color_15 = s:comment_grey.gui
  let g:terminal_color_background = s:background.gui
  let g:terminal_color_foreground = s:foreground.gui
  " }}}

  " Neovim Diagnostics {{{
  " call s:h("DiagnosticError", { "fg": s:red })
  call s:h("DiagnosticError", { "fg": s:comment_grey })
  call s:h("DiagnosticWarn", { "fg": s:yellow })
  call s:h("DiagnosticInfo", { "fg": s:blue })
  call s:h("DiagnosticHint", { "fg": s:cyan })
  call s:h("DiagnosticUnderlineError", { "fg": s:red, "gui": "underline", "cterm": "underline" })
  call s:h("DiagnosticUnderlineWarn", { "fg": s:yellow, "gui": "underline", "cterm": "underline" })
  call s:h("DiagnosticUnderlineInfo", { "fg": s:blue, "gui": "underline", "cterm": "underline" })
  call s:h("DiagnosticUnderlineHint", { "fg": s:cyan, "gui": "underline", "cterm": "underline" })
  " }}}

  " Neovim cmp highlight
  " Reference: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! link CmpItemKindInterface CmpItemKindVariable
  highlight! link CmpItemKindText CmpItemKindVariable
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! link CmpItemKindMethod CmpItemKindFunction
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! link CmpItemKindProperty CmpItemKindKeyword
  highlight! link CmpItemKindUnit CmpItemKindKeyword
  
  " Neovim LSP (for versions < 0.5.1) {{{
  hi link LspDiagnosticsDefaultError DiagnosticError
  hi link LspDiagnosticsDefaultWarning DiagnosticWarn
  hi link LspDiagnosticsDefaultInformation DiagnosticInfo
  hi link LspDiagnosticsDefaultHint DiagnosticHint
  hi link LspDiagnosticsUnderlineError DiagnosticUnderlineError
  hi link LspDiagnosticsUnderlineWarning DiagnosticUnderlineWarn
  hi link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInfo
  hi link LspDiagnosticsUnderlineHint DiagnosticUnderlineHint
  " }}}
  highlight! link CmpItemAbbr Pmenu
  " highlight! link CmpItemKind Pmenu
  " highlight! link CmpItemMenu Pmenu

  " Neovim 0.10 breaking change
  " Reference: https://neovim.io/doc/user/news-0.10.html
  highlight! link WinSeparator VertSplit
  highlight! link NormalFloat Pmenu

  " ---------------------------------------------------------------------------------
  " Reference: https://github.com/neovim/neovim/blob/master/runtime/colors/vim.lua
  " ---------------------------------------------------------------------------------
  " Text
  highlight! link @markup.raw       Comment
  highlight! link @markup.link      Identifier
  highlight! link @markup.heading   Title
  highlight! link @markup.link.url  Underlined
  highlight! link @markup.underline Underlined
  highlight! link @comment.todo     Todo

  " Miscs
  highlight! link @comment     Comment
  highlight! link @punctuation Delimiter

  " Constants
  highlight! link @constant          Constant
  highlight! link @constant.builtin  Special
  highlight! link @constant.macro    Define
  highlight! link @keyword.directive Define
  highlight! link @string            String
  highlight! link @string.escape     SpecialChar
  highlight! link @string.special    SpecialChar
  highlight! link @character         Character
  highlight! link @character.special SpecialChar
  highlight! link @number            Number
  highlight! link @boolean           Boolean
  highlight! link @number.float      Float

  " Functions
  highlight! link @function                   Function
  highlight! link @function.builtin           Special
  highlight! link @function.macro             Macro
  highlight! link @function.method            Function
  highlight! link @variable.parameter         Identifier
  highlight! link @variable.parameter.builtin Special
  highlight! link @variable.member            Identifier
  highlight! link @property                   Identifier
  highlight! link @attribute                  Macro
  highlight! link @attribute.builtin          Special
  highlight! link @constructor                Special

  " Keywords
  highlight! link @keyword.conditional Conditional
  highlight! link @keyword.repeat      Repeat
  highlight! link @keyword.type        Keyword
  highlight! link @label               Label
  highlight! link @operator            Operator
  highlight! link @keyword             Keyword
  highlight! link @keyword.exception   Exception
  highlight! link @variable          Identifier
  highlight! link @variable.builtin  Identifier
  highlight! link @type              Type
  highlight! link @type.builtin      Keyword
  highlight! link @type.definition   Typedef
  highlight! link @module            Identifier
  highlight! link @keyword.import    Include
  highlight! link @keyword.directive PreProc
  highlight! link @keyword.debug     Debug
  highlight! link @tag               Tag
  highlight! link @tag.builtin       Special

  " Lsp color
  highlight! link @lsp.type.class         Structure
  highlight! link @lsp.type.comment       Comment
  highlight! link @lsp.type.decorator     Function
  highlight! link @lsp.type.enum          Structure
  highlight! link @lsp.type.enumMember    Constant
  highlight! link @lsp.type.function      Function
  highlight! link @lsp.type.interface     Structure
  highlight! link @lsp.type.macro         Macro
  highlight! link @lsp.type.method        Function
  highlight! link @lsp.type.namespace     Structure
  highlight! link @lsp.type.parameter     Identifier
  highlight! link @lsp.type.property      Identifier
  highlight! link @lsp.type.struct        Structure
  highlight! link @lsp.type.type          Type
  highlight! link @lsp.type.typeParameter TypeDef
  highlight! link @lsp.type.variable      Identifier
endif

set background=dark
