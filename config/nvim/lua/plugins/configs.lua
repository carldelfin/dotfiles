require("hop").setup {}
require("nvim_comment").setup {}
require("neoscroll").setup {}
--require("fzf-lua").setup {}

require("bufferline").setup {
    options = {
        close_command = "Bdelete",
        separator_style = "slant",
        always_show_bufferline = true },
}

require("shade").setup {
  overlay_opacity = 50,
  opacity_step = 1,
  keys = { toggle = "<A-v>" }
}

require("indent_blankline").setup{
    char = "│",
    buftype_exclude = { "terminal" },
    space_char = ' ',
    show_first_indent_level = true,
    show_trailing_blankline_indent = false,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6" },
}

require("nvim-treesitter.configs").setup {
  ensure_installed = { "r", "bash", "c", "bibtex", "css", "cpp", "dockerfile", "go",
                       "julia", "latex", "lua", "make", "markdown", "python", "regex",
                       "vim", "yaml", "toml", "rasi" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require("lualine").setup {
  options = {
    theme = "onedark",
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

require("onedark").setup  {
    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    -- toggle theme style ---
    toggle_style_key = '<A-p>', -- Default keybinding to toggle
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between
    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },
    -- Custom Highlights --
    colors = {
      -- redefinition of existing colors
      yellow = "#f1e885",
      orange = "#ebcb8b",
      green = '#a5d7aa',
      purple = '#dd8ce2',
      blue = '#90ceff',
      fg = '#f0f0f0',
      -- add new colors
      bright_green = '#51f862',
      bright_yellow = '#faea41',
      bright_orange = '#ffa953',
    },

    highlights = {
      -- indent blankline
      IndentBlanklineIndent1 = {fg = '$bg2'},
      IndentBlanklineIndent2 = {fg = '$bg2'},
      IndentBlanklineIndent3 = {fg = '$bg2'},
      IndentBlanklineIndent4 = {fg = '$bg2'},
      IndentBlanklineIndent5 = {fg = '$bg2'},
      IndentBlanklineIndent6 = {fg = '$bg2'},
      -- hop
      HopNextKey = {fg = '$bright_green'},
      HopNextKey1 = {fg = '$bright_yellow'},
      HopNextKey2 = {fg = '$bright_orange'},
      -- pandoc, markdown
      pandocAtxStart = {fg = '$green'},
      pandocAtxHeader = {fg = '$green'},
      pandocAtxHeaderMark = {fg = '$green'},
      pandocCiteKey = {fg = '$cyan'},
      pandocCiteLocator = {fg = '$cyan'},
      pandocCiteAnchor = {fg = '$cyan'},
      pandocPCite = {fg = '$cyan'},
      yamlDocumentStart = {fg = '$dark_purple'},
      yamlBlockMappingKey = {fg = '$purple'},
      yamlPlainScalar = {fg = '$purple'},
      yamlKeyValueDelimiter = {fg = '$cyan'},
      yamlFlowIndicator = {fg = '$cyan'},
      -- r, rmarkdown
      rDollar = {fg = '$purple'},
      rOperator = {fg = '$purple'},
      rmdCodeDelim = {fg = '$fg', bg = '$grey', fmt = 'bold'},
      --treesitter
      TSOperator = {fg = '$purple'},
      TSParameter = {fg = '$fg'},
      TSPunctSpecial = {fg = '$orange'},
      TSPunctBracket = {fg = '$orange'},
      -- vim
      Title = {fg = '$green'},
      PreProc = {fg = '$orange'},
      Delimiter = {fg = '$cyan'},
      Number = {fg = '$yellow'},
    },
    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
require('onedark').load()
