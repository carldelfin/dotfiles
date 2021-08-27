" Vim color scheme
"
" Name:        northernlights.vim
" Maintainer:  Carl Delfin
" Last Change: 2021-08-26
" License:     GNU/GPL
"
" Based on other color schemes. The starting point was 'southernlights'

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "northernlights"

" background and foreground
hi Normal       guifg=#dadada   guibg=#262626
hi CursorLine	guibg=#262626	

hi Special	ctermfg=221	guifg=#ffd75f

hi Character	    ctermfg=223	        guifg=#ffd7af

hi Conceal	ctermfg=221	ctermbg=16	guifg=#ffd75f	guibg=black
hi Cursor	ctermfg=16	ctermbg=28	cterm=bold	guifg=Black	guibg=Green	gui=bold
hi CursorColumn	ctermbg=235	cterm=none	guibg=#262626	gui=none
hi ColorColumn	ctermbg=235	cterm=none	guibg=#262626	gui=none
hi DiffAdd	ctermfg=227	ctermbg=22	guifg=#ffff5f	guibg=#005f00
hi DiffDelete	ctermfg=227	ctermbg=88	guifg=#ffff5f	guibg=#870000
hi DiffChange	ctermfg=227	ctermbg=58	guifg=#ffff5f	guibg=#5f5f00
hi DiffText	ctermfg=227	ctermbg=88	guifg=#ffff5f	guibg=#870000	cterm=none	gui=none
hi Error	ctermfg=231	cterm=none	ctermbg=196	gui=none	guifg=White	guibg=Red
hi Directory	ctermfg=33	guifg=#0087ff
hi Folded	ctermfg=86	ctermbg=240	guifg=#00ffff	guibg=#585858
hi FoldColumn	ctermfg=86	ctermbg=240	guifg=#00ffff	guibg=#585858
hi Identifier	ctermfg=86	cterm=none	guifg=#5fffd7	gui=none
hi Include	ctermfg=219	cterm=none	guifg=#ffafff	gui=none
hi LineNr	ctermfg=16	ctermbg=240	guifg=Black	guibg=#585858
hi CursorLineNr	ctermfg=16	ctermbg=243	guifg=Black	guibg=#585858
hi MatchParen	ctermfg=231	ctermbg=58	guifg=white	guibg=#5f5f00
hi NonText	ctermfg=21	guifg=#0000ff	term=none	gui=none
hi NormalFloat	ctermfg=253	ctermbg=237	guifg=#dadada	guibg=#3a3a3a
hi MoreMsg	ctermfg=36	guifg=#00af87
hi ModeMsg	ctermfg=253	guifg=#dadada
hi Pmenu	ctermfg=249	ctermbg=235	guifg=#b2b2b2	guibg=#262626
hi PmenuSel	ctermfg=255	ctermbg=237	guifg=#eeeeee	guibg=#3a3a3a
hi PmenuSbar	ctermbg=240	guibg=#585858
hi PmenuThumb	ctermbg=243	guibg=#767676
hi Question	ctermfg=115	guifg=#87d7af
hi QuickFixLine	ctermfg=231	ctermbg=23	guifg=white	guibg=#005f5f
hi Search	ctermfg=231	ctermbg=58	guifg=white	guibg=#5f5f00
hi IncSearch	ctermfg=231	ctermbg=58	guifg=white	guibg=#5f5f00
hi SignColumn	ctermfg=227	ctermbg=240	guifg=#ffff5f	guibg=#585858
hi SpecialKey	ctermfg=86	guifg=#00ffff
if has("gui_running")
    hi SpellBad		ctermfg=196	ctermbg=none	cterm=underline	guisp=#ff0000	gui=undercurl
    hi SpellLocal	ctermfg=28	ctermbg=none	cterm=underline	guisp=#00AA00	gui=undercurl
    hi SpellRare	ctermfg=201	ctermbg=none	cterm=underline	guisp=#ff00ff	gui=undercurl
    hi SpellCap		ctermfg=33	ctermbg=none	cterm=underline	guisp=#0087ff	gui=undercurl
else
    hi SpellBad		ctermfg=196	ctermbg=none	cterm=underline	guifg=#ff0000	gui=underline
    hi SpellLocal	ctermfg=28	ctermbg=none	cterm=underline	guifg=#00AA00	gui=underline
    hi SpellRare	ctermfg=201	ctermbg=none	cterm=underline	guifg=#ff00ff	gui=underline
    hi SpellCap		ctermfg=33	ctermbg=none	cterm=underline	guifg=#0087ff	gui=underline
endif
hi StatusLine	ctermfg=16	ctermbg=244	guifg=black	guibg=#808080	cterm=none	gui=none
hi StatusLineNC	ctermfg=16	ctermbg=240	guifg=black	guibg=#585858	cterm=none	gui=none
hi VertSplit	ctermfg=240	ctermbg=240	guifg=#585858	guibg=#585858	cterm=none	gui=none
hi TabLineSel	ctermfg=16	ctermbg=244	guifg=black	guibg=#808080	cterm=none	gui=none
hi TabLine	ctermfg=16	ctermbg=240	guifg=black	guibg=#585858	cterm=none	gui=none
hi TabLineFill	ctermfg=16	ctermbg=235	guifg=black	guibg=#262626	cterm=none	gui=none
hi Todo		ctermfg=16	ctermbg=226	guifg=black	guibg=#ffff00	cterm=none	gui=none
hi StorageClass	ctermfg=113	guifg=#87d75f	gui=none
hi Structure	ctermfg=79	guifg=#5fd7af	gui=none
hi Underlined	ctermfg=105	guifg=#8787ff	cterm=underline	gui=underline
hi Visual	ctermfg=248	guifg=#a8a8a8	ctermbg=237 	guibg=#3a3a3a
hi VisualNOS	term=bold,underline		cterm=bold,underline		gui=bold,underline
hi WarningMsg	ctermfg=196
hi WildMenu	ctermfg=16	ctermbg=226	guifg=#000000	guibg=#ffff00
hi ErrorMsg	ctermfg=231	ctermbg=196	guifg=#ffffff	guibg=#ff0000

" Nvim lsp
hi LspDiagnosticsDefaultHint		ctermfg=blue   guifg=#15aacc guibg=#3a3a3a
hi LspDiagnosticsDefaultError		ctermfg=red    guifg=#ff0000 guibg=#3a3a3a
hi LspDiagnosticsDefaultWarning		ctermfg=brown  guifg=#ff922b guibg=#3a3a3a
hi LspDiagnosticsDefaultInformation	ctermfg=yellow guifg=#fab005 guibg=#3a3a3a

hi default link LspDiagnosticsFloatingHint         LspDiagnosticsDefaultHint
hi default link LspDiagnosticsFloatingError        LspDiagnosticsDefaultError
hi default link LspDiagnosticsFloatingWarning      LspDiagnosticsDefaultWarning
hi default link LspDiagnosticsFloatingInformation  LspDiagnosticsDefaultInformation

hi default link LspDiagnosticsSignHint         LspDiagnosticsDefaultHint
hi default link LspDiagnosticsSignError        LspDiagnosticsDefaultError
hi default link LspDiagnosticsSignWarning      LspDiagnosticsDefaultWarning
hi default link LspDiagnosticsSignInformation  LspDiagnosticsDefaultInformation

hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline

hi LspReferenceRead gui=bold ctermbg=237 guibg=#004444
hi LspReferenceText gui=bold ctermbg=237 guibg=#444400
hi LspReferenceWrite gui=bold ctermbg=237 guibg=#440000

" html
hi htmlLink			cterm=underline	ctermfg=105	gui=underline	guifg=#8787ff
hi htmlBold			cterm=bold			gui=bold
hi htmlBoldItalic		cterm=bold,italic		gui=bold,italic
hi htmlBoldUnderline		cterm=bold,underline		gui=bold,underline
hi htmlBoldUnderlineItalic	cterm=bold,underline,italic	gui=bold,underline,italic
hi htmlItalic			cterm=italic			gui=italic
hi htmlUnderline		cterm=underline			gui=underline
hi htmlUnderlineItalic		cterm=underline,italic		gui=underline,italic

" mail
hi mailHeader	ctermfg=229	guifg=#ffffaf
hi mailSubject	ctermfg=226	guifg=yellow
hi mailQuoted1	ctermfg=48	guifg=#00ff87
hi mailQuoted2	ctermfg=51	guifg=#00ffff
hi mailQuoted3	ctermfg=39	guifg=#00afff
hi mailQuoted4	ctermfg=33	guifg=#0087ff
hi mailQuoted5	ctermfg=27	guifg=#005fff
hi mailQuoted6	ctermfg=21	guifg=#0000ff
hi mailSignature ctermfg=209	guifg=#ff875f

" diff
hi diffAdded	ctermfg=40	guifg=#00d700
hi diffRemoved	ctermfg=210	guifg=#ff8787
hi diffFile	ctermfg=117	guifg=#87d7ff
hi diffOldFile	ctermfg=117	guifg=#87d7ff
hi diffNewFile	ctermfg=117	guifg=#87d7ff
hi diffLine	ctermfg=226	guifg=yellow

" wdiff
hi link	wdiffOld	diffRemoved
hi link	wdiffNew	diffAdded

" Vim help
hi helpHyperTextEntry	ctermfg=39	guifg=#00afff

" Vimscript
hi vimCommentTitle	ctermfg=135	guifg=#af5fff	gui=italic
hi vimCommentString	ctermfg=109	guifg=#87afaf	gui=italic

" R
hi rOKeyword    guifg=#af5fff gui=italic
hi rGlobEnvFun  guifg=#00afff gui=italic
hi rAssign      guifg=#94bc94
hi rSection     guifg=#00afff gui=italic
hi rRegion      guifg=#f4f4f4

hi Boolean      guifg=#cd955c
hi rBoolean     guifg=#cd955c
hi rConstant    guifg=#cd955c
hi Constant	    guifg=#cd955c

hi rComment     guifg=#727272
hi Comment	    guifg=#727272
hi Title	    guifg=#727272

hi rPreProc     guifg=#d299d2
hi PreProc	    guifg=#d299d2

hi rNumber      guifg=#facf71
hi Number       guifg=#facf71

hi rString      guifg=#6b8095
hi String       guifg=#6b8095

hi rType        guifg=#fff59a
hi Type		    guifg=#fff59a
hi rConditional guifg=#9a9aff gui=italic

hi rOperator    guifg=#c0ffef
hi Operator	    guifg=#c0ffef
hi Statement	guifg=#c0ffef

hi rFunction    guifg=#659f65 gui=bold
hi Function     guifg=#659f65

hi rDelimiter   guifg=#fde8bb
hi Delimiter    guifg=#94bcbc

" Rmd
hi rmdCodeDelim	ctermfg=135	guifg=#00afff gui=italic
hi rmdrChunk    ctermfg=135	guifg=#00afff gui=italic
hi rmdChunkDelim	ctermfg=135	guifg=#00afff gui=italic
hi rmdYamlBlockDelim	ctermfg=135	guifg=#00afff gui=italic
hi rmdYamlFieldTtl ctermfg=135	guifg=#00afff gui=italic
hi yamlFlowStringDelimiter ctermfg=135	guifg=#00afff gui=italic


" markdown
hi markdownH1Delimiter  ctermfg=135	guifg=#00afff gui=italic
hi markdownH2Delimiter  ctermfg=135	guifg=#00afff gui=italic
hi markdownH3Delimiter  ctermfg=135	guifg=#00afff gui=italic
hi markdownH4Delimiter  ctermfg=135	guifg=#00afff gui=italic
hi markdownH5Delimiter  ctermfg=135	guifg=#00afff gui=italic

hi markdownH1           ctermfg=135	guifg=#00afff gui=italic
hi markdownH2  ctermfg=135	guifg=#00afff gui=italic
hi markdownH3  ctermfg=135	guifg=#00afff gui=italic
hi markdownH4  ctermfg=135	guifg=#00afff gui=italic
hi markdownH5  ctermfg=135	guifg=#00afff gui=italic

" pandoc
hi pandocCiteLocator    ctermfg=135	guifg=#00afff gui=italic
hi pandocCiteAnchor    ctermfg=135	guifg=#00afff gui=italic
hi pandocCiteKey    ctermfg=135	guifg=#00afff gui=italic

" hop
hi HopNextKey   guifg=#ff007c gui=bold
hi HopNextKey1  guifg=#00dfff gui=bold
hi HopNextKey2  guifg=#2b8db3 gui=bold
hi HopUnmatched guifg=#666666

" indent blankline
hi IndentBlanklineIndent1 guifg=#727272 blend=nocombine
hi IndentBlanklineIndent2 guifg=#727272 blend=nocombine
hi IndentBlanklineIndent3 guifg=#727272 blend=nocombine
hi IndentBlanklineIndent4 guifg=#727272 blend=nocombine
hi IndentBlanklineIndent5 guifg=#727272 blend=nocombine
hi IndentBlanklineIndent6 guifg=#727272 blend=nocombine

" ShowMarks plugin
hi ShowMarksHLl		ctermfg=227	ctermbg=28	guifg=#ffff5f	guibg=#008700
hi ShowMarksHLu		ctermfg=227	ctermbg=28	guifg=#ffff5f	guibg=#008700
hi ShowMarksHLo		ctermfg=227	ctermbg=28	guifg=#ffff5f	guibg=#008700
hi ShowMarksHLm		ctermfg=227	ctermbg=196	guifg=#ffff5f	guibg=#ff005f

" csv.vim plugin
hi CSVColumnHeaderOdd	ctermfg=46	ctermbg=236	guifg=#00ff00	guibg=#303030
hi CSVColumnHeaderEven	ctermfg=45	ctermbg=236	guifg=#00d7ff	guibg=#303030
hi CSVColumnOdd		ctermfg=40	guifg=#00d700
hi CSVColumnEven	ctermfg=39	guifg=#00afff

