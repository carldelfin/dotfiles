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

" afternoon backgound: #434c5e
" evening backgound: #3b4252

" -------------------------------------------------------------------------
" UI
" -------------------------------------------------------------------------

hi Normal                       guifg=#eceff4       guibg=#434c5e
hi LineNr	                    guifg=#747f94       guibg=#434c5e
hi CursorLineNr	                guifg=#b7c2d7       guibg=#4c566a       gui=bold
hi VertSplit	                guifg=#505050	    guibg=#4c566a       gui=none
hi ColorColumn                                      guibg=#4c566a
hi CursorLine	                                    guibg=#4c566a

" -------------------------------------------------------------------------
" Statusline
" -------------------------------------------------------------------------

hi StatusLine                   guifg=#eceff4       guibg=#434c5e       gui=none
hi StatusLineNC                 guifg=#e5e9f0       guibg=#434c5e       gui=none
hi User1                        guifg=#eceff4       guibg=#4c566a 
hi User2                        guifg=#e5e9f0       guibg=#4c566a           
hi User3                        guifg=#e5e9f0       guibg=#4c566a           
hi User4                        guifg=#e5e9f0       guibg=#3B4252           
hi NormalColor                  guifg=#434c5e       guibg=#a3be8c
hi InsertColor                  guifg=#434c5e       guibg=#88c0d0
hi ReplaceColor                 guifg=#434c5e       guibg=#bf616a
hi VisualColor                  guifg=#434c5e       guibg=#ebcb8b
hi CommandColor                 guifg=#434c5e       guibg=#d778dd

" -------------------------------------------------------------------------
" Indent Blankline 
" -------------------------------------------------------------------------

hi IndentBlanklineIndent1       guifg=#6d7a96       blend=nocombine
hi IndentBlanklineIndent2       guifg=#6d7a96       blend=nocombine
hi IndentBlanklineIndent3       guifg=#6d7a96       blend=nocombine
hi IndentBlanklineIndent4       guifg=#6d7a96       blend=nocombine
hi IndentBlanklineIndent5       guifg=#6d7a96       blend=nocombine
hi IndentBlanklineIndent6       guifg=#6d7a96       blend=nocombine

" -------------------------------------------------------------------------
" Hop 
" -------------------------------------------------------------------------

hi HopNextKey                   guifg=#ff007c                           gui=bold
hi HopNextKey1                  guifg=#00dfff                           gui=bold
hi HopNextKey2                  guifg=#2b8db3                           gui=bold
hi HopUnmatched                 guifg=#5d6678

" -------------------------------------------------------------------------
" Diffs             
" -------------------------------------------------------------------------

" not finished
hi DiffAdd	                    guifg=#ffff00	    guibg=#00ff00
hi DiffDelete	                guifg=#ffff00	    guibg=#00ff00
hi DiffChange	                guifg=#ffff00	    guibg=#00ff00
hi DiffText	                    guifg=#ffff00	    guibg=#00ff00       gui=none

" -------------------------------------------------------------------------
" Pandoc 
" -------------------------------------------------------------------------

hi pandocAtxHeader              guifg=#98c379                           gui=bold
hi pandocAtxStart               guifg=#98c379                           gui=bold

hi pandocCiteLocator            guifg=#ff8ea1
hi pandocCiteAnchor             guifg=#ff8ea1 
hi pandocCiteKey                guifg=#ff8ea1 

hi pandocSubscriptMark          guifg=#e5c07b                           gui=bold
hi pandocSubscript              guifg=#e5c07b                           gui=bold
hi pandocPCite                  guifg=#eceff4                           gui=italic

hi pandocReferenceLabel         guifg=#eceff4
hi pandocOperator               guifg=#eceff4

" -------------------------------------------------------------------------
" Code, generic
" -------------------------------------------------------------------------

hi MatchParen                   guifg=#434c5e       guibg=#8fbcbb
hi Boolean                      guifg=#ebcb8b
hi Constant	                    guifg=#ebcb8b
hi Comment	                    guifg=#6d7a96
hi Title	                    guifg=#6d7a96
hi Number                       guifg=#ebcb8b
hi String                       guifg=#a3be8c
hi Type		                    guifg=#ebcb8b                           gui=bold
hi PreProc	                    guifg=#ebcb8b                           gui=bold
hi Operator	                    guifg=#d778dd
hi Function                     guifg=#61afef
hi Delimiter                    guifg=#eceff4
hi Statement	                guifg=#d778dd                           gui=bold
hi Todo		                    guifg=#eceff4       guibg=#d08770       gui=bold

" -------------------------------------------------------------------------
" Code, R 
" -------------------------------------------------------------------------

hi default link                 rBoolean            Boolean
hi default link                 rConstant           Constant
hi default link                 rComment            Comment 
hi default link                 rNumber             Number 
hi default link                 rString             String 
hi default link                 rType               Type 
hi default link                 rPreproc            Preproc
hi default link                 rOperator           Operator
hi default link                 rFunction           Function 
hi default link                 rDelimiter          Delimiter 

hi rRegion                      guifg=#eceff4
hi rDollar                      guifg=#ebcb8b
hi rAssign                      guifg=#d778dd 
hi rConditional                 guifg=#88c0d0

" not finished 
hi routIndex                    guifg=#ffff00
hi rOKeyword                    guifg=#ffff00                           gui=italic
hi rGlobEnvFun                  guifg=#ffff00                           gui=italic
hi rSection                     guifg=#ffff00                           gui=italic

" -------------------------------------------------------------------------
" Code, RMarkdown 
" -------------------------------------------------------------------------

hi default link                 rmdrInline         pandocCiteKey 
hi default link                 rmdInlineDelim     pandocCiteKey 

hi rmdCodeDelim	                guifg=#eceff4                           gui=bold 

hi rmdrChunkDelim	            guifg=#eceff4                           gui=bold 
hi rmdrChunk                    guifg=#eceff4 
hi rmdYamlBlockDelim            guifg=#00afff       gui=italic
hi rmdYamlFieldTtl              guifg=#00afff                           gui=italic

" -------------------------------------------------------------------------
" Code, YAML 
" -------------------------------------------------------------------------

hi yamlFlowStringDelimiter      guifg=#98c379 
hi yamlBlockMappingKey          guifg=#98c379 
hi yamlKeyValueDelimiter        guifg=#eceff4
hi yamlDocumentStart            guifg=#e5c07b

" -------------------------------------------------------------------------
" Code, TEX 
" -------------------------------------------------------------------------

hi texMathDelimZone guifg=#ebcb8b






" not finished
hi Error	        guifg=#ffff00       guibg=#ffff00
hi Special	        guifg=#ffff00
hi Character	    guifg=#ffff00
hi Conceal	        guifg=#ffff00       guibg=black
hi Identifier	    guifg=#ffff00                           gui=none
hi Directory	    guifg=#ffff00

hi Folded			guifg=#ffff00       guibg=#585858
hi FoldColumn		guifg=#ffff00	    guibg=#585858
hi Include	        guifg=#ffff00	                        gui=none
hi NonText          guifg=#ffff00	                        gui=none
hi NormalFloat	    guifg=#ffff00	    guibg=#3a3a3a
hi MoreMsg	        guifg=#00af87
hi ModeMsg	        guifg=#dadada
hi Pmenu	        guifg=#b2b2b2	    guibg=#262626
hi PmenuSel	        guifg=#eeeeee	    guibg=#3a3a3a
hi PmenuSbar		guibg=#585858
hi PmenuThumb       guibg=#767676
hi Question	        guifg=#87d7af
hi QuickFixLine	    guifg=white	        guibg=#005f5f
hi Search	        guifg=white	        guibg=#5f5f00
hi IncSearch	    guifg=white	        guibg=#5f5f00
hi SignColumn	    guifg=#ffff5f	    guibg=#585858
hi SpecialKey		guifg=#00ffff
hi SpellBad		    guisp=#ff0000	gui=undercurl
hi SpellLocal	    guisp=#00AA00	gui=undercurl
hi SpellRare	    guisp=#ff00ff	gui=undercurl
hi SpellCap		    guisp=#0087ff	gui=undercurl
hi TabLineSel	    guifg=black	guibg=#808080		gui=none
hi TabLine	        guifg=black	guibg=#585858		gui=none
hi TabLineFill	    guifg=black	guibg=#262626		gui=none
hi StorageClass	    guifg=#87d75f	gui=none
hi Structure	    guifg=#5fd7af	gui=none
hi Underlined	    guifg=#8787ff		gui=underline
hi Visual	        guifg=#a8a8a8	guibg=#3a3a3a
hi VisualNOS	    gui=bold,underline
hi WarningMsg       guifg=ffff00 guibg=00ffaa	
hi WildMenu	        guifg=#000000	guibg=#ffff00
hi ErrorMsg	        guifg=#ffffff	guibg=#ff0000







" Nvim lsp
hi LspDiagnosticsDefaultHint		guifg=#ffff00 guibg=#3a3a3a
hi LspDiagnosticsDefaultError		guifg=#ffff00 guibg=#3a3a3a
hi LspDiagnosticsDefaultWarning		guifg=#ffff00 guibg=#3a3a3a
hi LspDiagnosticsDefaultInformation	guifg=#ffff00 guibg=#3a3a3a

hi default link LspDiagnosticsFloatingHint         LspDiagnosticsDefaultHint
hi default link LspDiagnosticsFloatingError        LspDiagnosticsDefaultError
hi default link LspDiagnosticsFloatingWarning      LspDiagnosticsDefaultWarning
hi default link LspDiagnosticsFloatingInformation  LspDiagnosticsDefaultInformation

hi default link LspDiagnosticsSignHint         LspDiagnosticsDefaultHint
hi default link LspDiagnosticsSignError        LspDiagnosticsDefaultError
hi default link LspDiagnosticsSignWarning      LspDiagnosticsDefaultWarning
hi default link LspDiagnosticsSignInformation  LspDiagnosticsDefaultInformation

hi LspDiagnosticsUnderlineError guifg=NONE NONE  gui=underline
hi LspDiagnosticsUnderlineWarning guifg=NONE NONE  gui=underline
hi LspDiagnosticsUnderlineInformation guifg=NONE NONE  gui=underline
hi LspDiagnosticsUnderlineHint guifg=NONE NONE  gui=underline

hi LspReferenceRead gui=bold guibg=#004444
hi LspReferenceText gui=bold guibg=#444400
hi LspReferenceWrite gui=bold guibg=#440000

" html
hi htmlLink				gui=underline	guifg=#8787ff
hi htmlBold			cterm=bold			gui=bold
hi htmlBoldItalic		cterm=bold,italic		gui=bold,italic
hi htmlBoldUnderline		cterm=bold,underline		gui=bold,underline
hi htmlBoldUnderlineItalic	cterm=bold,underline,italic	gui=bold,underline,italic
hi htmlItalic			cterm=italic			gui=italic
hi htmlUnderline					gui=underline
hi htmlUnderlineItalic		gui=underline,italic


" diff
hi diffAdded	guifg=#00d700
hi diffRemoved	guifg=#ff8787
hi diffFile	guifg=#87d7ff
hi diffOldFile	guifg=#87d7ff
hi diffNewFile	guifg=#87d7ff
hi diffLine	guifg=yellow

" wdiff
hi link	wdiffOld	diffRemoved
hi link	wdiffNew	diffAdded

" Vim help
hi helpHyperTextEntry	guifg=#00afff

" Vimscript
hi vimCommentTitle	guifg=#af5fff	gui=italic
hi vimCommentString	guifg=#87afaf	gui=italic

hi vimIsCommand	    guifg=#e5c07b
hi vimOption	    guifg=#e5c07b
hi vimOper          guifg=#d778dd
"hi vimSetEqual          guifg=#d778dd


" markdown
hi markdownH1Delimiter  guifg=#00afff gui=italic
hi markdownH2Delimiter  guifg=#00afff gui=italic
hi markdownH3Delimiter  guifg=#00afff gui=italic
hi markdownH4Delimiter  guifg=#00afff gui=italic
hi markdownH5Delimiter  guifg=#00afff gui=italic

hi markdownH1           guifg=#00afff gui=italic
hi markdownH2  guifg=#00afff gui=italic
hi markdownH3  guifg=#00afff gui=italic
hi markdownH4  guifg=#00afff gui=italic
hi markdownH5  guifg=#00afff gui=italic



