-- ================================================================================================ 
-- lazy.nvim plugin manager
-- ================================================================================================ 

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ================================================================================================ 
-- important; set leader keys here, before anything that depends on them
-- ================================================================================================ 

vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- ================================================================================================ 
-- options 
-- ================================================================================================ 

-- general

local o               = vim.opt
local g               = vim.g

g.loaded_netrw        = 1            -- disable netrw
g.loaded_netrwPlugin  = 1            -- disable netrw

o.showmatch           = true         -- show matching parentheses    
o.relativenumber      = true         -- relative line numbers
o.tabstop             = 2            -- tabsize
o.softtabstop         = 2            -- tabsize
o.expandtab           = true         -- use spaces instead of tabs
o.shiftwidth          = 2            -- set indentation width
o.smartindent         = true         -- smarter indentation
o.hidden              = true         -- keep hidden buffers
o.ignorecase          = true         -- case insensitive on search..
o.smartcase           = true         -- ..unless there's a capital
o.mouse               = "nv"         -- enable mouse support in normal and visual mode
o.cursorline          = true         -- enable cursor line
o.colorcolumn         = { "100" }    -- 100 chars color column
o.hlsearch            = true         -- highlight matching search
o.undofile            = true         -- persistent undo
o.backup              = false        -- disable backup
o.writebackup         = false        -- disable backup
o.backupcopy          = "yes"        -- fix weirdness for stuff that replaces the entire file when hot reloading
o.swapfile            = false        -- disable swapfile
o.autowrite           = true         -- auto write buffer when it's not focused
o.lazyredraw          = true         -- make macro faster
o.startofline         = false        -- don't go to the start of the line when moving to another file
o.termguicolors       = true         -- true colours for better experience
o.wrap                = false        -- don't wrap lines
o.encoding            = "UTF-8"      -- set encoding
o.inccommand          = "split"      -- incrementally show result of command
o.shortmess           = "csa"        -- disable some stuff on shortmess
o.pumheight           = 10           -- limit completion items
o.re                  = 0            -- set regexp engine to auto
o.scrolloff           = 2            -- make scrolling better
o.sidescroll          = 2            -- make scrolling better
o.sidescrolloff       = 15           -- make scrolling better
o.timeoutlen          = 400          -- faster timeout wait time
o.updatetime          = 1000         -- set faster update time

-- r specific

g.R_auto_start        = 1               -- autostart R 
g.R_objbr_auto_start  = 0               -- don't autostart the object browser
g.R_objbr_place       = "console,left"  -- always put object browser to the left of the console 
g.R_objbr_opendf      = 1               -- show data.frames elements
g.R_objbr_openlist    = 0               -- don't show lists elements
g.R_objbr_allnames    = 0               -- don't show hidden objects
g.R_hl_term           = 1               -- highlight R output
g.R_assign            = 0               -- never use custom R assignment
g.R_args              = { "--no-save" } -- don't save sessions 
g.Rout_more_colors    = 1               -- highlight r commands in the console
g.R_hi_fun_paren      = 0               -- turn off highlighting in functions not followed by parentheses
g.R_openpdf           = 1               -- open pdfs once, then update that window
g.R_openhtml          = 1               -- open htmls
g.R_nvim_wd           = -1              -- don't setwd() at all

-- open dfs and matrices using toggleterm
g.R_csv_app           = ':TermExec cmd="vd %s"'

-- always load these libraries
g.R_start_libs        = "base,stats,graphics,grDevices,utils,methods,dplyr"

-- ================================================================================================ 
-- plugins 
-- ================================================================================================ 

require("lazy").setup({

  -- ----------------------------------------------------------------------------------------------
  -- colorscheme
  -- ----------------------------------------------------------------------------------------------

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function ()
      require("catppuccin").setup({
        flavour = "mocha",
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.10
        },
      });
      vim.cmd.colorscheme("catppuccin");
    end
  },

  -- ----------------------------------------------------------------------------------------------
  -- nvim-lspconfig 
  -- ----------------------------------------------------------------------------------------------

  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("lspconfig").lua_ls.setup({
        autostart = false,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "describe", "it" },
            },
          },
        },
      })
      require('lspconfig').r_language_server.setup{}
    end,
  },

  -- ----------------------------------------------------------------------------------------------
  -- mason and mason-lspconfig.nvim
  -- ----------------------------------------------------------------------------------------------

  { "williamboman/mason.nvim", opts = {} },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "marksman",
        "r_language_server", -- note that r and devtools must be installed
      },
    },
  },

  -- ----------------------------------------------------------------------------------------------
  -- hop.nvim 
  -- ----------------------------------------------------------------------------------------------

  { "phaazon/hop.nvim", opts = {} },

  -- ----------------------------------------------------------------------------------------------
  -- fzf.lua 
  -- ----------------------------------------------------------------------------------------------

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
    end
  },

  -- ----------------------------------------------------------------------------------------------
  -- triptych.nvim
  -- ----------------------------------------------------------------------------------------------

  {
    "simonmclean/triptych.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("triptych").setup({
        mappings = {
          -- everything below is buffer-local, meaning it will only apply to Triptych windows
          show_help = 'g?',
          jump_to_cwd = '.',  -- pressing again will toggle back
          nav_left = { '<Left>' },
          nav_right = { '<Right>', '<CR>' },
          delete = 'd',
          add = 'a',
          copy = 'c',
          rename = 'r',
          cut = 'x',
          paste = 'p',
          quit = 'q',
          toggle_hidden = '<leader>.',
        },
        extension_mappings = {},
        options = {
          dirs_first = true,
          show_hidden = true,
          line_numbers = {
            enabled = true,
            relative = true,
          },
          file_icons = {
            enabled = true,
            directory_icon = '',
            fallback_file_icon = ''
          },
          highlights = {
            file_names = 'NONE',
            directory_names = 'NONE',
          },
          syntax_highlighting = {
            enabled = true,
            debounce_ms = 100,
          },
        },
        git_signs = {
          enabled = true,
          signs = {
            add = '+',
            modify = '~',
            rename = 'r',
            untracked = '?',
          },
        },
        diagnostic_signs = {
          enabled = true,
        }
      })
    end,
  },

  -- ----------------------------------------------------------------------------------------------
  -- vim-bbye 
  -- ----------------------------------------------------------------------------------------------

  { "moll/vim-bbye" },

  -- ----------------------------------------------------------------------------------------------
  -- nvim-comment 
  -- ----------------------------------------------------------------------------------------------

  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
  },

  -- ----------------------------------------------------------------------------------------------
  -- Nvim-R 
  -- ----------------------------------------------------------------------------------------------

  { "jalvesaq/Nvim-R", lazy = false },

  -- ----------------------------------------------------------------------------------------------
  -- quarto-nvim 
  -- ----------------------------------------------------------------------------------------------

  { "quarto-dev/quarto-nvim", lazy = false },

  -- ----------------------------------------------------------------------------------------------
  -- toggleterm-nvim 
  -- ----------------------------------------------------------------------------------------------

  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()
    end,
  },

  -- ----------------------------------------------------------------------------------------------
  -- cmp-nvim-r
  -- ----------------------------------------------------------------------------------------------

  { "jalvesaq/cmp-nvim-r", opts = { filetypes = {"r", "rmd", "quarto"} } },

  -- ----------------------------------------------------------------------------------------------
  -- lspkind.nvim
  -- ----------------------------------------------------------------------------------------------

  { "onsails/lspkind.nvim" },

  -- ----------------------------------------------------------------------------------------------
  -- nvim-cmp
  -- ----------------------------------------------------------------------------------------------

  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "jalvesaq/cmp-nvim-r",
      "onsails/lspkind.nvim",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, {"i", "s"}),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, {"i", "s"}),

        },
        window = {
          completion = {
            border = "rounded",
          },
          documentation = {
            border = "rounded",
          },
        },
        formatting = {
          fields = {"abbr", "kind", "menu"},
          format = lspkind.cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            ellipsis_char = "...", -- the truncated part when popup menu exceed maxwidth
            before = function(entry, item)
              local menu_icon = {
                nvim_lsp = "",
                cmp_nvim_r = "R",
                path = "",
                luasnip = "",
              }
              item.menu = menu_icon[entry.source.name]
              return item
            end,
          })
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "cmp_nvim_r" },
          { name = "path" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },

  -- ----------------------------------------------------------------------------------------------
  -- nvim-treesitter
  -- ----------------------------------------------------------------------------------------------

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        auto_install = true,
        sync_install = false,
        ensure_installed =
        {
          "lua",
          "vim",
          "r",
          "markdown",
          "markdown_inline",
          "css",
          "c",
          "cpp",
          "yaml",
          "toml",
          "comment"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "org", "latex", "markdown" },
        },
        indent = { enable = false },
      })
    end
  },

  -- ----------------------------------------------------------------------------------------------
  -- indent-blankline.nvim
  -- ----------------------------------------------------------------------------------------------

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      exclude = {
        filetypes = {
          "lspinfo",
          "packer",
          "checkhealth",
          "help",
          "man",
          "dashboard",
          "git",
          "markdown",
          "text",
          "terminal",
          "NvimTree",
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
      enabled = true,
      scope = { enabled = true },
      indent = { char = "▏" },
    },
  },

  -- ----------------------------------------------------------------------------------------------
  -- nvim-colorizer.lua
  -- ----------------------------------------------------------------------------------------------

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- ----------------------------------------------------------------------------------------------
  -- nvim-web-devicons
  -- ----------------------------------------------------------------------------------------------

  { "kyazdani42/nvim-web-devicons" },

  -- ----------------------------------------------------------------------------------------------
  -- vim-pencil 
  -- ----------------------------------------------------------------------------------------------

  { "preservim/vim-pencil" },

  -- ----------------------------------------------------------------------------------------------
  -- lualine.nvim
  -- ----------------------------------------------------------------------------------------------

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "|", right = "|"},
          section_separators = { left = "", right = ""},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff", "diagnostics"},
          lualine_c = {"filename"},
          lualine_x = {require("config.utils").encoding, require("config.utils").fileformat, "filetype"},
          lualine_y = {"location"},
          lualine_z = {require("config.utils").ctime}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {"filename"},
          lualine_x = {"location"},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
    end,
  },

  -- ----------------------------------------------------------------------------------------------
  -- neoscroll.nvim 
  -- ----------------------------------------------------------------------------------------------

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
  },

  -- ----------------------------------------------------------------------------------------------
  -- markview.nvim
  -- ----------------------------------------------------------------------------------------------

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    }
  }

})

-- ================================================================================================ 
-- autocmds 
-- ================================================================================================ 

-- automatically switch to insert mode when entering a term buffer
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
  group = vim.api.nvim_create_augroup("openTermInsert", {}),
  callback = function(args)
    -- we don't use vim.startswith() and look for test:// because of vim-test
    -- vim-test starts tests in a terminal, which we want to keep in normal mode
    if vim.endswith(vim.api.nvim_buf_get_name(args.buf), "fish") then
      vim.cmd("startinsert")
    end
  end,
})

-- highlight when searching
vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    local cmd = vim.v.event.cmdtype
    if cmd == "/" or cmd == "?" then
      vim.opt.hlsearch = true
    end
  end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    local cmd = vim.v.event.cmdtype
    if cmd == "/" or cmd == "?" then
      vim.opt.hlsearch = false
    end
  end,
})

-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions = { c = false, r = false, o = false }
  end,
})

-- turn on spell check for markdown, quarto and text files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md", "*.Rmd", "*.qmd", "*.txt" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- quit r automatically when closing nvim
vim.cmd[[autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif]]

-- set filetype for zmk fields 
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.keymap", "*.dtsi" },
  command = "set filetype=dts",
})

-- ================================================================================================ 
-- keymap 
-- ================================================================================================ 

local map = vim.keymap.set

-- save buffer
map("n", "<C-s>", ":write<CR>", { noremap = false, silent = true })

-- window movement
map("n", "<A-m>", "<C-w>h", { noremap = false, silent = true }) -- left
map("n", "<A-n>", "<C-w>j", { noremap = false, silent = true }) -- down 
map("n", "<A-e>", "<C-w>k", { noremap = false, silent = true }) -- up 
map("n", "<A-i>", "<C-w>l", { noremap = false, silent = true }) -- right 

-- window resize
map("n", "<S-A-m>", ":vertical resize -2<CR>", { noremap = false, silent = true }) -- left
map("n", "<S-A-n>", ":resize +2<CR>", { noremap = false, silent = true })          -- down 
map("n", "<S-A-e>", ":resize -2<CR>", { noremap = false, silent = true })          -- up 
map("n", "<S-A-i>", ":vertical resize +2<CR>", { noremap = false, silent = true }) -- right 

-- hop
map("n", "ss", ":HopChar1<CR>", { noremap = false, silent = true })
map("n", "sp", ":HopPattern<CR>", { noremap = false, silent = true })

-- toggle terminal in current directory
map("n", "<C-t>", ":ToggleTerm size=30 direction=float<CR>", { noremap = false, silent = true })

-- file navigation
map("n", "<C-g>", ":FzfLua live_grep_native<CR>", { silent = true })
map("n", "<C-f>", ":FzfLua files<CR>", { silent = true })
map("n", "<C-p>", ":Triptych<CR>", { silent = true })

-- buffers
map("n", "tt", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
map("n", "<A-t>", ":bnext<CR>", { noremap = false, silent = true })
map("n", "<A-s>", ":bprev<CR>", { noremap = false, silent = true })

-- r
vim.cmd[[nmap <Return> <Plug>RDSendLine]]
vim.cmd[[vmap <Return> <Plug>RDSendSelection]]
vim.cmd[[nmap <A-l> <Plug>RClearConsole]]
vim.cmd[[nmap <silent> <LocalLeader>hh :call RAction("head", ", n = 20")<CR>]]
vim.cmd[[nmap <silent> <LocalLeader>tt :call RAction("tail", ", n = 20")<CR>]]
vim.cmd[[nmap <silent> <LocalLeader>ss :call RAction("summary")<CR>]]

-- ================================================================================================ 
-- color overrides 
-- ================================================================================================ 

vim.cmd[[highlight HopNextKey guifg='#82fa8e' guibg='#1e1e2e']]
vim.cmd[[highlight HopNextKey1 guifg='#faea41' guibg='#1e1e2e']]
vim.cmd[[highlight HopNextKey2 guifg='#ff4d76' guibg='#1e1e2e']]
vim.cmd[[highlight HopUnmatched guifg='#585b70' guibg='#1e1e2e']]
