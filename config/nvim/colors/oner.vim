" Theme: oneR 
" Author: Carl Delfin
" License: MIT
" Source: http://github.com/carldelfin/oner

" --------------------------------------------------------------------------------------------------
" Initialisation: "{{{
" --------------------------------------------------------------------------------------------------

hi clear

if exists("syntax_on")
  syntax reset
endif

let s:style = get(g:, 'oner', 'regular')
let g:colors_name = "oner"

"}}}

" --------------------------------------------------------------------------------------------------
" Colors: "{{{
" --------------------------------------------------------------------------------------------------

let s:palette = {}
let s:palette.dark1        = {'deep': "#121417",      'regular': "#282c34",      'pale': "#282c34"}
let s:palette.dark2        = {'deep': "#1a1c23",      'regular': "#303440",      'pale': "#303440"}
let s:palette.dark3        = {'deep': "#22282e",      'regular': "#37414c",      'pale': "#37414c"}
let s:palette.dark4        = {'deep': "#22262f",      'regular': "#424a5b",      'pale': "#424a5b"}
let s:palette.light1       = {'deep': "#424a5b",      'regular': "#576279",      'pale': "#576279"}
let s:palette.light2       = {'deep': "#6376a0",      'regular': "#8392b3",      'pale': "#8392b3"}
let s:palette.light3       = {'deep': "#b7d9fc",      'regular': "#cfe6fd",      'pale': "#e7f3fe"}
let s:palette.light4       = {'deep': "#dce1eb",      'regular': "#eceff4",      'pale': "#fcfdfd"}
let s:palette.brightblue   = {'deep': "#5db7ff",      'regular': "#90ceff",      'pale': "#c3e5ff"}
let s:palette.paleblue     = {'deep': "#7cc2fa",      'regular': "#add9fc",      'pale': "#c6e4fd"}
let s:palette.brightorange = {'deep': "#ff9020",      'regular': "#ffa953",      'pale': "#ffc386"}
let s:palette.paleorange   = {'deep': "#e4b860",      'regular': "#ebcb8b",      'pale': "#f3dfb7"}
let s:palette.brightyellow = {'deep': "#f9e50f",      'regular': "#faea41",      'pale': "#fbef73"}
let s:palette.paleyellow   = {'deep': "#ecdf57",      'regular': "#f1e885",      'pale': "#f6f1b3"}
let s:palette.brightgreen  = {'deep': "#51f862",      'regular': "#82fa8e",      'pale': "#b3fcba"}
let s:palette.palegreen    = {'deep': "#82c789",      'regular': "#a5d7aa",      'pale': "#c8e7cb"}
let s:palette.brightpurple = {'deep': "#d163d8",      'regular': "#dd8ce2",      'pale': "#e9b5ec"}
let s:palette.palepurple   = {'deep': "#c68bc9",      'regular': "#d7aed9",      'pale': "#e8d1e9"}
let s:palette.brightcyan   = {'deep': "#37f6cb",      'regular': "#68f8d8",      'pale': "#99fae5"}
let s:palette.palecyan     = {'deep': "#70cdc5",      'regular': "#96dad4",      'pale': "#bce7e3"}
let s:palette.brightred    = {'deep': "#ff1a4f",      'regular': "#ff4d76",      'pale': "#ff809d"}
let s:palette.palered      = {'deep': "#e05373",      'regular': "#e87e96",      'pale': "#f0a9b9"}

"}}}

" --------------------------------------------------------------------------------------------------
" Highlighting Primitives: "{{{
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
" Formatting Options: "{{{
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
" Vim Highlighting: "{{{
" --------------------------------------------------------------------------------------------------

exe "hi! Boolean"                       .s:fg_brightorange        .s:bg_none            .s:fmt_none
exe "hi! ColorColumn"                   .s:fg_none                .s:bg_dark2           .s:fmt_none
exe "hi! Comment"                       .s:fg_light2              .s:bg_none            .s:fmt_none
exe "hi! Conceal"                       .s:fg_light3              .s:bg_none            .s:fmt_none
exe "hi! Conditional"                   .s:fg_brightcyan          .s:bg_none            .s:fmt_none
exe "hi! Constant"                      .s:fg_paleorange          .s:bg_none            .s:fmt_none
exe "hi! CursorLineConceal"             .s:fg_light3              .s:bg_dark2           .s:fmt_none
exe "hi! CursorColumn"                  .s:fg_none                .s:bg_dark2           .s:fmt_none
exe "hi! CursorLine"                    .s:fg_none                .s:bg_dark2           .s:fmt_none
exe "hi! CursorLineNr"                  .s:fg_light4              .s:bg_dark2           .s:fmt_none
exe "hi! Delimiter"                     .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! DiffAdd"                       .s:fg_palegreen           .s:bg_dark3           .s:fmt_none
exe "hi! DiffChange"                    .s:fg_brightcyan          .s:bg_dark3           .s:fmt_none
exe "hi! DiffText"                      .s:fg_light4              .s:bg_dark3           .s:fmt_none
exe "hi! Directory"                     .s:fg_brightblue          .s:bg_none            .s:fmt_none
exe "hi! EndOfBuffer"                   .s:fg_dark1               .s:bg_dark1           .s:fmt_none
exe "hi! Folded"                        .s:fg_dark4               .s:bg_dark3           .s:fmt_none
exe "hi! FoldColumn"                    .s:fg_none                .s:bg_dark3           .s:fmt_none
exe "hi! Error"                         .s:fg_dark1               .s:bg_brightred       .s:fmt_none
exe "hi! ErrorMsg"                      .s:fg_light4              .s:bg_brightred       .s:fmt_stnd
exe "hi! Function"                      .s:fg_brightblue          .s:bg_none            .s:fmt_none
exe "hi! Identifier"                    .s:fg_brightcyan          .s:bg_none            .s:fmt_none
exe "hi! Ignore"                        .s:fg_none                .s:bg_none            .s:fmt_none
exe "hi! Include"                       .s:fg_brightpurple        .s:bg_none            .s:fmt_bold
exe "hi! LineNr"                        .s:fg_light2              .s:bg_none            .s:fmt_none
exe "hi! LongLineWarning"               .s:fg_brightred           .s:bg_none            .s:fmt_undr
exe "hi! MatchParen"                    .s:fg_dark2               .s:bg_brightcyan      .s:fmt_none
exe "hi! ModeMsg"                       .s:fg_palegreen           .s:bg_none            .s:fmt_none
exe "hi! MoreMsg"                       .s:fg_palegreen           .s:bg_none            .s:fmt_none
exe "hi! NonText"                       .s:fg_light3              .s:bg_none            .s:fmt_none
exe "hi! Normal"                        .s:fg_light4              .s:bg_dark1           .s:fmt_none
exe "hi! Operator"                      .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! Pmenu"                         .s:fg_light4              .s:bg_dark4           .s:fmt_none
exe "hi! PmenuSel"                      .s:fg_dark4               .s:bg_light4          .s:fmt_none
exe "hi! PreProc"                       .s:fg_paleorange          .s:bg_none            .s:fmt_none
exe "hi! qfLineNr"                      .s:fg_light2              .s:bg_none            .s:fmt_none
exe "hi! Question"                      .s:fg_palegreen           .s:bg_none            .s:fmt_none
exe "hi! Search"                        .s:fg_dark1               .s:bg_paleorange      .s:fmt_none
exe "hi! SignColumn"                    .s:fg_none                .s:bg_dark3           .s:fmt_none
exe "hi! Special"                       .s:fg_light3              .s:bg_none            .s:fmt_none
exe "hi! SpecialKey"                    .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! SpellCap"                      .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! SpellLocal"                    .s:fg_none                .s:bg_none            .s:fmt_none
exe "hi! SpellBad"                      .s:fg_palered             .s:bg_none            .s:fmt_none
exe "hi! SpellRare"                     .s:fg_brightorange        .s:bg_none            .s:fmt_none
exe "hi! Statement"                     .s:fg_brightcyan          .s:bg_none            .s:fmt_none
exe "hi! String"                        .s:fg_palegreen           .s:bg_none            .s:fmt_none
exe "hi! Structure"                     .s:fg_light3              .s:bg_none            .s:fmt_none
exe "hi! TabLine"                       .s:fg_light4              .s:bg_dark3           .s:fmt_revr
exe "hi! Title"                         .s:fg_light2              .s:bg_none            .s:fmt_none
exe "hi! Todo"                          .s:fg_brightred           .s:bg_none            .s:fmt_bold
exe "hi! Type"                          .s:fg_paleorange          .s:bg_none            .s:fmt_bold
exe "hi! Underlined"                    .s:fg_brightcyan          .s:bg_none            .s:fmt_undr
exe "hi! VertSplit"                     .s:fg_light1              .s:bg_none            .s:fmt_none
exe "hi! Visual"                        .s:fg_none                .s:bg_dark4           .s:fmt_none
exe "hi! WarningMsg"                    .s:fg_brightred           .s:bg_none            .s:fmt_none
exe "hi! WildMenu"                      .s:fg_dark1               .s:bg_brightred       .s:fmt_none

"}}}

" --------------------------------------------------------------------------------------------------
" Other Syntax Highlighting: "{{{
" --------------------------------------------------------------------------------------------------

" R
exe "hi! rAssign"                       .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! rDollar"                       .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! rLstElmt"                      .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! rDelimiter"                    .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! rNumber"                       .s:fg_paleyellow          .s:bg_none            .s:fmt_none
exe "hi! rFloat"                        .s:fg_paleyellow          .s:bg_none            .s:fmt_none
exe "hi! routNumber"                    .s:fg_paleyellow          .s:bg_none            .s:fmt_none
exe "hi! routFloat"                     .s:fg_paleyellow          .s:bg_none            .s:fmt_none

" R Markdown
exe "hi! rmdInLineDelim"                .s:fg_brightpurple        .s:bg_none            .s:fmt_bold
exe "hi! rmdrInline"                    .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! rmdCodeDelim"                  .s:fg_light4              .s:bg_dark4           .s:fmt_bold

" Pandoc
exe "hi! pandocDelimitedCodeBlockStart" .s:fg_light4              .s:bg_dark3           .s:fmt_bold
exe "hi! pandocDelimitedCodeBlockEnd"   .s:fg_light4              .s:bg_dark3           .s:fmt_bold
exe "hi! pandocDelimitedCodeBlockLanguage" .s:fg_light4           .s:bg_dark3           .s:fmt_bold
exe "hi! pandocDelimitedCodeBlock"      .s:fg_light3              .s:bg_none            .s:fmt_none
exe "hi! pandocAtxHeader"               .s:fg_palegreen           .s:bg_none            .s:fmt_bold
exe "hi! pandocAtxStart"                .s:fg_palegreen           .s:bg_none            .s:fmt_none
exe "hi! pandocSuperscript"             .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! pandocSuperscriptMark"         .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! pandocSubscript"               .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! pandocSubscriptMark"           .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! pandocReferenceURL"            .s:fg_light3              .s:bg_none            .s:fmt_undr
exe "hi! pandocReferenceLabel"          .s:fg_palepurple          .s:bg_none            .s:fmt_none
exe "hi! pandocUListItemBullet"         .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! pandocReferenceDefinition"     .s:fg_palepurple          .s:bg_none            .s:fmt_none
exe "hi! pandocCiteKey"                 .s:fg_palepurple          .s:bg_none            .s:fmt_none
exe "hi! pandocOperator"                .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! pandocCiteAnchor"              .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! pandocCiteLocator"             .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! pandocPCite"                   .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! pandocEllipses"                .s:fg_light4              .s:bg_none            .s:fmt_none

" YAML
exe "hi! yamlDocumentStart"             .s:fg_brightcyan          .s:bg_none            .s:fmt_none
exe "hi! yamlBlockMappingKey"           .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! yamlBlockCollectionItemStart"  .s:fg_palecyan            .s:bg_none            .s:fmt_none

" Tex
exe "hi! TexMathDelimZone"              .s:fg_brightorange        .s:bg_none            .s:fmt_none
exe "hi! TexMathSuperSub"               .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! TexMathSub"                    .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! texMathArg"                    .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! TexMathCmd"                    .s:fg_paleorange          .s:bg_none            .s:fmt_none
exe "hi! TexMathSymbol"                 .s:fg_paleorange          .s:bg_none            .s:fmt_none
exe "hi! texDelim"                      .s:fg_light4              .s:bg_none            .s:fmt_none

" HTML
exe "hi! htmlTag"                       .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! htmlEndTag"                    .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! htmlTagName"                   .s:fg_brightcyan          .s:bg_none            .s:fmt_none
exe "hi! htmlArg"                       .s:fg_brightblue          .s:bg_none            .s:fmt_none

" Vim
exe "hi! vimCommentTitle"               .s:fg_light2              .s:bg_none            .s:fmt_none
exe "hi! vimNotation"                   .s:fg_palepurple          .s:bg_none            .s:fmt_none
exe "hi! vimMapModKey"                  .s:fg_palepurple          .s:bg_none            .s:fmt_none
exe "hi! vimMapLhs"                     .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! vimMapRhs"                     .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! vimVar"                        .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! vimFuncVar"                    .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! vimFuncName"                   .s:fg_brightblue          .s:bg_none            .s:fmt_none
exe "hi! vimNotFunc"                    .s:fg_brightcyan          .s:bg_none            .s:fmt_none
exe "hi! vimLet"                        .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! vimBracket"                    .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! vimCommand"                    .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! vimHighlight"                  .s:fg_brightcyan          .s:bg_none            .s:fmt_none
exe "hi! vimHiClear"                    .s:fg_paleorange          .s:bg_none            .s:fmt_bold

" Shell
exe "hi! shVarAssign"                   .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! shTestOpr"                     .s:fg_brightpurple        .s:bg_none            .s:fmt_none
exe "hi! shLoop"                        .s:fg_brightcyan          .s:bg_none            .s:fmt_none
exe "hi! shFor"                         .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shTestPattern"                 .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shSet"                         .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shEcho"                        .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shNumber"                      .s:fg_paleyellow          .s:bg_none            .s:fmt_none
exe "hi! shSetList"                     .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shOption"                      .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shDerefVar"                    .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shDeref"                       .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! shRange"                       .s:fg_palecyan            .s:bg_none            .s:fmt_none
exe "hi! shVariable"                    .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shRepeat"                      .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! kshStatement"                  .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! kshSpecialVariables"           .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shSnglCase"                    .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shStatement"                   .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shQuote"                       .s:fg_palegreen           .s:bg_none            .s:fmt_none
exe "hi! shDerefSimple"                 .s:fg_paleblue            .s:bg_none            .s:fmt_none
exe "hi! shDerefSpecial"                .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shCmdSubRegion"                .s:fg_paleorange          .s:bg_none            .s:fmt_none
exe "hi! shCommandSub"                  .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! shCtrlSeq"                     .s:fg_light4              .s:bg_none            .s:fmt_none

" C
exe "hi! cNumber"                       .s:fg_paleyellow          .s:bg_none            .s:fmt_none
exe "hi! cStructure"                    .s:fg_paleorange          .s:bg_none            .s:fmt_bold
exe "hi! cStatement"                    .s:fg_brightblue          .s:bg_none            .s:fmt_bold
exe "hi! cOperator"                     .s:fg_brightpurple        .s:bg_none            .s:fmt_bold
exe "hi! cLabel"                        .s:fg_brightpurple        .s:bg_none            .s:fmt_bold

" Highlighted yank
exe "hi! HighlightedyankRegion"         .s:fg_dark4               .s:bg_paleorange      .s:fmt_none

" Hop
exe "hi! HopNextKey"                    .s:fg_brightgreen         .s:bg_none            .s:fmt_bold
exe "hi! HopNextKey1"                   .s:fg_brightyellow        .s:bg_none            .s:fmt_bold
exe "hi! HopNextKey2"                   .s:fg_brightred           .s:bg_none            .s:fmt_bold
exe "hi! HopUnmatched"                  .s:fg_light1               .s:bg_none            s:fmt_none

" Indent Blankline
exe "hi! IndentBlanklineIndent1"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent2"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent3"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent4"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent5"        .s:fg_dark4               .s:bg_none            .s:fmt_none
exe "hi! IndentBlanklineIndent6"        .s:fg_dark4               .s:bg_none            .s:fmt_none

" NERDTree
exe "hi! NERDTreeClosable"              .s:fg_brightblue          .s:bg_none            .s:fmt_none
exe "hi! NERDTreeOpenable"              .s:fg_light2              .s:bg_none            .s:fmt_none
exe "hi! NERDTreeFlags"                 .s:fg_light2              .s:bg_none            .s:fmt_none
exe "hi! NERDTreeDir"                   .s:fg_light3              .s:bg_none            .s:fmt_none
exe "hi! NERDTreeDirSlash"              .s:fg_light3              .s:bg_none            .s:fmt_none
exe "hi! NERDTreeFile"                  .s:fg_light4              .s:bg_none            .s:fmt_none
exe "hi! NERDTreeExecFile"              .s:fg_light4              .s:bg_none            .s:fmt_bold
exe "hi! NERDTreeLinkFile"              .s:fg_paleblue            .s:bg_none            .s:fmt_bold
exe "hi! NERDTreeLinkTarget"            .s:fg_light2              .s:bg_none            .s:fmt_none
exe "hi! NERDTreeCWD"                   .s:fg_paleorange          .s:bg_none            .s:fmt_none
exe "hi! NERDTreeUp"                    .s:fg_light2              .s:bg_none            .s:fmt_none
exe "hi! NERDTreeHelp"                  .s:fg_palegreen           .s:bg_none            .s:fmt_none

" Statusline
exe "hi! StatusLine"                    .s:fg_light4              .s:bg_dark3           .s:fmt_none
exe "hi! StatusLineNC"                  .s:fg_dark4               .s:bg_dark3           .s:fmt_none
exe "hi! User1"                         .s:fg_light3              .s:bg_dark3           .s:fmt_none
exe "hi! User2"                         .s:fg_light4              .s:bg_brightcyan      .s:fmt_none
exe "hi! User3"                         .s:fg_brightblue          .s:bg_dark1           .s:fmt_none
exe "hi! User4"                         .s:fg_light4              .s:bg_dark1           .s:fmt_none
exe "hi! NormalColor"                   .s:fg_dark1               .s:bg_palegreen       .s:fmt_none
exe "hi! InsertColor"                   .s:fg_dark1               .s:bg_brightblue      .s:fmt_none
exe "hi! ReplaceColor"                  .s:fg_dark1               .s:bg_brightcyan      .s:fmt_none
exe "hi! VisualColor"                   .s:fg_dark1               .s:bg_brightpurple    .s:fmt_none

"}}}
