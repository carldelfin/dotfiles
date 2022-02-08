" --------------------------------------------------------------------------------------------------
" Initialisation:"{{{
" --------------------------------------------------------------------------------------------------

hi clear

if exists("syntax_on")
  syntax reset
endif

let s:style = get(g:, 'oner', 'regular')
let g:colors_name = "oner"
"}}}

" --------------------------------------------------------------------------------------------------
" Palettes:"{{{
" --------------------------------------------------------------------------------------------------

let s:palette = {}
let s:palette.bg           = {'deep': "#121417",      'regular': "#282c34",      'pale': "#3e4451"}
let s:palette.dark2        = {'deep': "#1c2129",      'regular': "#303440",      'pale': "#465165"}
let s:palette.dark3        = {'deep': "#22282e",      'regular': "#37414c",      'pale': "#4c5a6a"}
let s:palette.dark4        = {'deep': "#2c2c3d",      'regular': "#424a5b",      'pale': "#585679"}
let s:palette.comment      = {'deep': "#5f88b0",      'regular': "#81a1c1",      'pale': "#a3bbd2"}
let s:palette.structure    = {'deep': "#b7d9fc",      'regular': "#cfe6fd",      'pale': "#e7f3fe"}
let s:palette.fg           = {'deep': "#e0e5ed",      'regular': "#eceff4",      'pale': "#eceff4"}
let s:palette.function     = {'deep': "#5db7ff",      'regular': "#90ceff",      'pale': "#c3e5ff"}
let s:palette.string       = {'deep': "#82c789",      'regular': "#a5d7aa",      'pale': "#c8e7cb"}
let s:palette.boolean      = {'deep': "#ff9020",      'regular': "#ffa953",      'pale': "#ffc386"}
let s:palette.type         = {'deep': "#e4b860",      'regular': "#ebcb8b",      'pale': "#f3dfb7"}
let s:palette.regexp       = {'deep': "#f1f645",      'regular': "#f5f876",      'pale': "#f9faa7"}
let s:palette.operator     = {'deep': "#d163d8",      'regular': "#dd8ce2",      'pale': "#e9b5ec"}
let s:palette.citekey      = {'deep': "#76b5e6",      'regular': "#96dad4",      'pale': "#cce3f6"}
let s:palette.statement    = {'deep': "#37f6cb",      'regular': "#68f8d8",      'pale': "#99fae5"}
let s:palette.markup       = {'deep': "#ff1a4f",      'regular': "#ff4d76",      'pale': "#ff809d"}
let s:palette.find         = {'deep': "#1aff58",      'regular': "#4dff7d",      'pale': "#80ffa2"}
"}}}

" --------------------------------------------------------------------------------------------------
" Highlighting Primitives:"{{{
" --------------------------------------------------------------------------------------------------

function! s:build_prim(hi_elem, field)
  let l:vname = "s:" . a:hi_elem . "_" . a:field "
  let l:gui_assign = "gui".a:hi_elem."=".s:palette[a:field][s:style]
  exe "let " . l:vname . " = ' " . l:gui_assign . "'"
endfunction

let s:bg_none = ' guibg=NONE ctermbg=NONE'
let s:fg_none = ' guifg=NONE ctermfg=NONE'

for [key_name, d_value] in items(s:palette)
  call s:build_prim('bg', key_name)
  call s:build_prim('fg', key_name)
endfor
" }}}

" --------------------------------------------------------------------------------------------------
" Formatting Options:"{{{
" --------------------------------------------------------------------------------------------------

let s:none          = "NONE"
let s:t_none        = "NONE"
let s:n             = "NONE"
let s:c             = ",undercurl"
let s:r             = ",reverse"
let s:s             = ",standout"
let s:b             = ",bold"
let s:u             = ",underline"
let s:i             = ",italic"

exe "let s:fmt_none =    ' gui=NONE".            " cterm=NONE".            " term=NONE"        ."'"
exe "let s:fmt_bold =    ' gui=NONE".s:b.        " cterm=NONE".s:b.        " term=NONE".s:b    ."'"
exe "let s:fmt_bldi =    ' gui=NONE".s:b.        " cterm=NONE".s:b.        " term=NONE".s:b    ."'"
exe "let s:fmt_undr =    ' gui=NONE".s:u.        " cterm=NONE".s:u.        " term=NONE".s:u    ."'"
exe "let s:fmt_undb =    ' gui=NONE".s:u.s:b.    " cterm=NONE".s:u.s:b.    " term=NONE".s:u.s:b."'"
exe "let s:fmt_undi =    ' gui=NONE".s:u.        " cterm=NONE".s:u.        " term=NONE".s:u    ."'"
exe "let s:fmt_curl =    ' gui=NONE".s:c.        " cterm=NONE".s:c.        " term=NONE".s:c    ."'"
exe "let s:fmt_ital =    ' gui=NONE".s:i.        " cterm=NONE".s:i.        " term=NONE".s:i    ."'"
exe "let s:fmt_stnd =    ' gui=NONE".s:s.        " cterm=NONE".s:s.        " term=NONE".s:s    ."'"
exe "let s:fmt_revr =    ' gui=NONE".s:r.        " cterm=NONE".s:r.        " term=NONE".s:r    ."'"
exe "let s:fmt_revb =    ' gui=NONE".s:r.s:b.    " cterm=NONE".s:r.s:b.    " term=NONE".s:r.s:b."'"
"}}}

" --------------------------------------------------------------------------------------------------
" Vim Highlighting: (see :help highlight-groups)"{{{
" --------------------------------------------------------------------------------------------------

" TODO arrange alphabetically

exe "hi! Structure"                     .s:fg_structure           .s:bg_none            .s:fmt_none
exe "hi! Special"                       .s:fg_structure           .s:bg_none            .s:fmt_none
exe "hi! Underlined"                    .s:fg_statement           .s:bg_none            .s:fmt_undr
exe "hi! Ignore"                        .s:fg_none                .s:bg_none            .s:fmt_none
exe "hi! Error"                         .s:fg_fg                  .s:bg_markup          .s:fmt_none
exe "hi! Todo"                          .s:fg_markup              .s:bg_none            .s:fmt_none
exe "hi! qfLineNr"                      .s:fg_comment             .s:bg_none            .s:fmt_none
exe "hi! Conceal"                       .s:fg_structure           .s:bg_none            .s:fmt_none
exe "hi! CursorLineConceal"             .s:fg_structure           .s:bg_dark2           .s:fmt_none
exe "hi! Conditional"                   .s:fg_statement           .s:bg_none            .s:fmt_none
exe "hi! Comment"                       .s:fg_comment             .s:bg_none            .s:fmt_none
exe "hi! Title"                         .s:fg_comment             .s:bg_none            .s:fmt_none
exe "hi! Constant"                      .s:fg_type                .s:bg_none            .s:fmt_none
exe "hi! Identifier"                    .s:fg_statement           .s:bg_none            .s:fmt_none
exe "hi! Function"                      .s:fg_function            .s:bg_none            .s:fmt_none
exe "hi! Statement"                     .s:fg_statement           .s:bg_none            .s:fmt_none
exe "hi! Operator"                      .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! Normal"                        .s:fg_fg                  .s:bg_bg              .s:fmt_none
exe "hi! Boolean"                       .s:fg_boolean             .s:bg_none            .s:fmt_none
exe "hi! ColorColumn"                   .s:fg_none                .s:bg_dark2           .s:fmt_none
exe "hi! CursorColumn"                  .s:fg_none                .s:bg_dark2           .s:fmt_none
exe "hi! CursorLine"                    .s:fg_none                .s:bg_dark2           .s:fmt_none
exe "hi! CursorLineNr"                  .s:fg_fg                  .s:bg_dark2           .s:fmt_none
exe "hi! LineNr"                        .s:fg_comment             .s:bg_none            .s:fmt_none
exe "hi! Directory"                     .s:fg_function            .s:bg_none            .s:fmt_none
exe "hi! Delimiter"                     .s:fg_structure           .s:bg_none            .s:fmt_none
exe "hi! DiffAdd"                       .s:fg_string              .s:bg_dark3           .s:fmt_none
exe "hi! DiffChange"                    .s:fg_statement           .s:bg_dark3           .s:fmt_none
exe "hi! DiffText"                      .s:fg_fg                  .s:bg_dark3           .s:fmt_none
exe "hi! ErrorMsg"                      .s:fg_fg                  .s:bg_markup          .s:fmt_stnd
exe "hi! VertSplit"                     .s:fg_bg                  .s:bg_dark4           .s:fmt_none
exe "hi! Folded"                        .s:fg_dark4               .s:bg_dark3           .s:fmt_none
exe "hi! FoldColumn"                    .s:fg_none                .s:bg_dark3           .s:fmt_none
exe "hi! SignColumn"                    .s:fg_none                .s:bg_dark3           .s:fmt_none
exe "hi! Include"                       .s:fg_operator            .s:bg_none            .s:fmt_bold
exe "hi! MatchParen"                    .s:fg_dark2               .s:bg_function        .s:fmt_none
exe "hi! ModeMsg"                       .s:fg_string              .s:bg_none            .s:fmt_none
exe "hi! MoreMsg"                       .s:fg_string              .s:bg_none            .s:fmt_none
exe "hi! NonText"                       .s:fg_structure           .s:bg_none            .s:fmt_none
exe "hi! Pmenu"                         .s:fg_fg                  .s:bg_dark4           .s:fmt_none
exe "hi! PmenuSel"                      .s:fg_dark4               .s:bg_fg              .s:fmt_none
exe "hi! PreProc"                       .s:fg_type                .s:bg_none            .s:fmt_none
exe "hi! Question"                      .s:fg_string              .s:bg_none            .s:fmt_none
exe "hi! Search"                        .s:fg_bg                  .s:bg_type            .s:fmt_none
exe "hi! String"                        .s:fg_string              .s:bg_none            .s:fmt_none
exe "hi! SpecialKey"                    .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! SpellCap"                      .s:fg_structure           .s:bg_none            .s:fmt_undr
exe "hi! SpellLocal"                    .s:fg_structure           .s:bg_none            .s:fmt_undr
exe "hi! SpellBad"                      .s:fg_markup              .s:bg_none            .s:fmt_undr
exe "hi! SpellRare"                     .s:fg_type                .s:bg_none            .s:fmt_undr
exe "hi! WildMenu"                      .s:fg_bg                  .s:bg_markup          .s:fmt_none
exe "hi! TabLine"                       .s:fg_fg                  .s:bg_dark3           .s:fmt_revr
exe "hi! Type"                          .s:fg_type                .s:bg_none            .s:fmt_bold
exe "hi! Visual"                        .s:fg_none                .s:bg_dark4           .s:fmt_none
exe "hi! WarningMsg"                    .s:fg_markup              .s:bg_none            .s:fmt_none
exe "hi! LongLineWarning"               .s:fg_markup              .s:bg_none            .s:fmt_undr
exe "hi! EndOfBuffer"                   .s:fg_bg                  .s:bg_bg              .s:fmt_none
"}}}

" --------------------------------------------------------------------------------------------------
" Generic Syntax Highlighting: (see :help group-name)"{{{
" --------------------------------------------------------------------------------------------------

" R
exe "hi! rAssign"                       .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! rDollar"                       .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! rLstElmt"                      .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! rDelimiter"                    .s:fg_fg                  .s:bg_none            .s:fmt_bold

" R Markdown
exe "hi! rmdInLineDelim"                .s:fg_operator            .s:bg_none            .s:fmt_bold
exe "hi! rmdrInline"                    .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! rmdCodeDelim"                  .s:fg_fg                  .s:bg_dark4           .s:fmt_bold

" Tex
exe "hi! TexMathDelimZone"              .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! TexMathSuperSub"               .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! TexMathSub"                    .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! TexMathCmd"                    .s:fg_fg                  .s:bg_none            .s:fmt_none

" Pandoc
exe "hi! pandocDelimitedCodeBlockStart" .s:fg_fg                  .s:bg_dark3           .s:fmt_bold
exe "hi! pandocDelimitedCodeBlockEnd"   .s:fg_fg                  .s:bg_dark3           .s:fmt_bold
exe "hi! pandocDelimitedCodeBlockLanguage" .s:fg_fg               .s:bg_dark3           .s:fmt_bold
exe "hi! pandocDelimitedCodeBlock"      .s:fg_structure           .s:bg_none            .s:fmt_none
exe "hi! pandocAtxHeader"               .s:fg_string              .s:bg_none            .s:fmt_bold
exe "hi! pandocAtxStart"                .s:fg_string              .s:bg_none            .s:fmt_bold
exe "hi! pandocSuperscript"             .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! pandocSuperscriptMark"         .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! pandocSubscript"               .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! pandocSubscriptMark"           .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! pandocReferenceURL"            .s:fg_structure           .s:bg_none            .s:fmt_undr
exe "hi! pandocReferenceLabel"          .s:fg_structure           .s:bg_none            .s:fmt_none
exe "hi! pandocUListItemBullet"         .s:fg_citekey             .s:bg_none            .s:fmt_none
exe "hi! pandocReferenceDefinition"     .s:fg_citekey             .s:bg_none            .s:fmt_none
exe "hi! pandocCiteKey"                 .s:fg_citekey             .s:bg_none            .s:fmt_none
exe "hi! pandocOperator"                .s:fg_citekey             .s:bg_none            .s:fmt_none
exe "hi! pandocCiteAnchor"              .s:fg_statement           .s:bg_none            .s:fmt_none
exe "hi! pandocCiteLocator"             .s:fg_statement           .s:bg_none            .s:fmt_none
exe "hi! pandocPCite"                   .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! pandocEllipses"                .s:fg_fg                  .s:bg_none            .s:fmt_none

" HTML
exe "hi! htmlTag"                       .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! htmlTagName"                   .s:fg_statement           .s:bg_none            .s:fmt_none
exe "hi! htmlArg"                       .s:fg_function            .s:bg_none            .s:fmt_none

" Vim
exe "hi! vimCommentTitle"               .s:fg_comment             .s:bg_none            .s:fmt_none
exe "hi! vimVar"                        .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! vimFuncVar"                    .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! vimFuncName"                   .s:fg_function            .s:bg_none            .s:fmt_none
exe "hi! vimLet"                        .s:fg_statement           .s:bg_none            .s:fmt_none
exe "hi! vimCommand"                    .s:fg_statement           .s:bg_none            .s:fmt_none
exe "hi! vimHighlight"                  .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! vimHiClear"                    .s:fg_type                .s:bg_none            .s:fmt_none

" Shell
exe "hi! shVarAssign"                   .s:fg_operator            .s:bg_none            .s:fmt_none
exe "hi! shLoop"                        .s:fg_statement           .s:bg_none            .s:fmt_none
exe "hi! shFor"                         .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shSet"                         .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shSetList"                     .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shOption"                      .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shTestOpr"                     .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shVariable"                    .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shRepeat"                      .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! kshStatement"                  .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shSnglCase"                    .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shStatement"                   .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shQuote"                       .s:fg_string              .s:bg_none            .s:fmt_none
exe "hi! shDerefSimple"                 .s:fg_type                .s:bg_none            .s:fmt_none
exe "hi! shCmdSubRegion"                .s:fg_type                .s:bg_none            .s:fmt_none
exe "hi! shCommandSub"                  .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! shCtrlSeq"                     .s:fg_fg                  .s:bg_none            .s:fmt_none

" C/C++
exe "hi! cppNumber"                     .s:fg_type                .s:bg_none            .s:fmt_none
exe "hi! cStructure"                    .s:fg_type                .s:bg_none            .s:fmt_bold
exe "hi! cStatement"                    .s:fg_function            .s:bg_none            .s:fmt_bold
exe "hi! cOperator"                     .s:fg_operator            .s:bg_none            .s:fmt_bold
exe "hi! cLabel"                        .s:fg_operator            .s:bg_none            .s:fmt_bold

" Highlighted yank
exe "hi! HighlightedyankRegion"         .s:fg_dark4               .s:bg_type            .s:fmt_none

" Hop
exe "hi! HopNextKey"                    .s:fg_find                .s:bg_none            .s:fmt_bold
exe "hi! HopNextKey1"                   .s:fg_regexp              .s:bg_none            .s:fmt_bold
exe "hi! HopNextKey2"                   .s:fg_markup              .s:bg_none            .s:fmt_bold
exe "hi! HopUnmatched"                  .s:fg_dark4               .s:bg_none            .s:fmt_none

" Indent Blankline
exe "hi! IndentBlanklineIndent1"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent2"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent3"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent4"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent5"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent6"        .s:fg_dark4               .s:bg_none            .s:fmt_none

" NERDTree
exe "hi! NERDTreeClosable"              .s:fg_type                .s:bg_none            .s:fmt_none
exe "hi! NERDTreeOpenable"              .s:fg_function            .s:bg_none            .s:fmt_none
exe "hi! NERDTreeFlags"                 .s:fg_function            .s:bg_none            .s:fmt_none
exe "hi! NERDTreeDir"                   .s:fg_fg                  .s:bg_none            .s:fmt_none
exe "hi! NERDTreeDirSlash"              .s:fg_structure           .s:bg_none            .s:fmt_none
exe "hi! NERDTreeFile"                  .s:fg_structure           .s:bg_none            .s:fmt_none
exe "hi! NERDTreeExecFile"              .s:fg_structure           .s:bg_none            .s:fmt_bold
exe "hi! NERDTreeCWD"                   .s:fg_type                .s:bg_none            .s:fmt_none
exe "hi! NERDTreeUp"                    .s:fg_comment             .s:bg_none            .s:fmt_none
exe "hi! NERDTreeHelp"                  .s:fg_string              .s:bg_none            .s:fmt_none

" Statusline
exe "hi! StatusLine"                    .s:fg_fg                  .s:bg_dark3           .s:fmt_none
exe "hi! StatusLineNC"                  .s:fg_dark4               .s:bg_dark3           .s:fmt_none
exe "hi! User1"                         .s:fg_structure           .s:bg_dark3           .s:fmt_none
exe "hi! User2"                         .s:fg_fg                  .s:bg_statement       .s:fmt_none
exe "hi! User3"                         .s:fg_function            .s:bg_bg              .s:fmt_none
exe "hi! User4"                         .s:fg_fg                  .s:bg_bg              .s:fmt_none
exe "hi! NormalColor"                   .s:fg_bg                  .s:bg_string          .s:fmt_none
exe "hi! InsertColor"                   .s:fg_bg                  .s:bg_function        .s:fmt_none
exe "hi! ReplaceColor"                  .s:fg_bg                  .s:bg_statement       .s:fmt_none
exe "hi! VisualColor"                   .s:fg_bg                  .s:bg_operator        .s:fmt_none

" --------------------------------------------------------------------------------------------------
" This is necessary for some reason: {{{
" --------------------------------------------------------------------------------------------------

let &background = s:style

" }}}
