--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.colorscheme = "gruvbox-flat"
lvim.format_on_save = true
-- local onedarkpro = require("onedarkpro")
-- onedarkpro.setup({
--   dark_theme = "onedark_dark",
-- })

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.transparent_window = false
-- lvim.builtin.lualine.options.theme = "onedarkpro"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<esc>"] = actions.close
  }
}
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { "kristijanhusak/vim-hybrid-material" },
  { "PHSix/nvim-hybrid" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  { "junegunn/vim-easy-align" },
  { "aktersnurra/no-clown-fiesta.nvim" },
  { "sainnhe/gruvbox-material" },
  { 'rktjmp/lush.nvim' },
  { "metalelf0/jellybeans-nvim" },
  { "vinhnx/Ciapre.tmTheme" },
  { 'shaunsingh/nord.nvim' },
  { "luisiacc/gruvbox-baby" },
  { "kareefardi/gruvbox-flat.nvim",
  },

  { 'projekt0n/github-nvim-theme' },
  { 'yashguptaz/calvera-dark.nvim' },
  { 'marko-cerovac/material.nvim' },
  { 'RRethy/nvim-base16' },
  { 'srcery-colors/srcery-vim' },
  { "EdenEast/nightfox.nvim" },
  { 'sainnhe/everforest' },
  { 'sainnhe/sonokai' },
  { 'folke/tokyonight.nvim' },
  { 'mhartington/oceanic-next' },
  { 'rebelot/kanagawa.nvim' },
  { 'olimorris/onedarkpro.nvim' },
  { 'navarasu/onedark.nvim' },
  {
    "catppuccin/nvim",
    as = "catppuccin"
  },
  {
    "ggandor/lightspeed.nvim",
  },
  {
    'wfxr/minimap.vim',
    run = "cargo install --locked code-minimap",
  },
  --  {
  --    "kevinhwang91/nvim-bqf",
  --    event = { "BufRead", "BufNew" },
  --    config = function()
  --      require("bqf").setup({
  --        auto_enable = true,
  --        preview = {
  --          win_height = 12,
  --          win_vheight = 12,
  --          delay_syntax = 80,
  --          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
  --        },
  --        func_map = {
  --          vsplit = "",
  --          ptogglemode = "z,",
  --          stoggleup = "",
  --        },
  --        filter = {
  --          fzf = {
  --            action_for = { ["ctrl-s"] = "split" },
  --            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
  --          },
  --        },
  --      })
  --    end,
  --  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "kevinhwang91/rnvimr",
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    setup = function()
      vim.g.indent_blankline_char = "▏"
    end,
    config = function()
      require("indent_blankline").setup {
        enabled = true,
        bufname_exclude = { "README.md" },
        buftype_exclude = { "terminal", "nofile" },
        filetype_exclude = {
          "alpha",
          "log",
          "gitcommit",
          "dapui_scopes",
          "dapui_stacks",
          "dapui_watches",
          "dapui_breakpoints",
          "dapui_hover",
          "LuaTree",
          "dbui",
          "UltestSummary",
          "UltestOutput",
          "vimwiki",
          "markdown",
          "json",
          "txt",
          "vista",
          "NvimTree",
          "git",
          "TelescopePrompt",
          "undotree",
          "flutterToolsOutline",
          "org",
          "orgagenda",
          "help",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Outline",
          "Trouble",
          "lspinfo",
          "", -- for all buffers without a file type
        },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        space_char_blankline = " ",
        use_treesitter = true,
        show_foldtext = false,
        show_current_context = true,
        show_current_context_start = false,
        context_patterns = {
          "class",
          "return",
          "function",
          "method",
          "^if",
          "^do",
          "^switch",
          "^while",
          "jsx_element",
          "^for",
          "^object",
          "^table",
          "block",
          "arguments",
          "if_statement",
          "else_clause",
          "jsx_element",
          "jsx_self_closing_element",
          "try_statement",
          "catch_clause",
          "import_statement",
          "operation_type",
        },
      }
    end,
    event = "BufRead",
  },
  {
    "hrsh7th/cmp-cmdline"
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- show hidden files when running a find command in telescope
lvim.keys.normal_mode["<leader>ss"] = ":Telescope current_buffer_fuzzy_find previewer=false <CR>"
lvim.keys.normal_mode["<leader>bq"] = ":BufferLineCloseLeft <CR>:BufferLineCloseRight <CR>"
lvim.keys.normal_mode["<leader>sw"] = ":execute 'Telescope live_grep default_text=' . expand('<cword>')<CR>"
--vim.cmd([[
--  nnoremap <leader>sw :execute 'Telescope live_grep default_text=' . expand('<cword>')<cr>
--]])
--lvim.keys.normal_mode["<leader>sw"] = ":Telescope live_grep default_text=' . expand('<cword>')<CR>"
-- lvim.builtin.telescope.defaults.layout_config.width = 0.90
-- lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 30
-- lvim.builtin.telescope.defaults.layout_config.preview_height = 0.20
-- lvim.builtin.telescope.defaults.layout_strategy = "vertical"

vim.g.neovide_cursor_animation_length = 0
vim.g.gruvbox_material_background = 'hard'
vim.g.neovide_refresh_rate = 165
vim.g.rnvimr_draw_border = 1
vim.g.rnvimr_pick_enable = 1
vim.g.rnvimr_bw_enable = 1
vim.g.material_style = "darker"

vim.g.gruvbox_italic_variables = false
vim.g.gruvbox_flat_style = "hard"


vim.o.cmdheight = 1
--vim.o.guifont = "FuraCode Nerd Font Mono:h11"
vim.o.guifont = "FiraCode Nerd Font Mono:h11:w25"

vim.cmd([[
  vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gVzv:call setreg('"', old_reg, old_regtype)<CR>
  vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gVzv:call setreg('"', old_reg, old_regtype)<CR>
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
  nnoremap <silent> <M-o> :RnvimrToggle<CR>
]])
vim.cmd([[
  if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
  endif
  let g:easy_align_delimiters['('] = { 'pattern': '(', 'right_margin': 0 }
]])
vim.cmd("let g:minimap_width = 10")
vim.cmd("let g:minimap_auto_start = 0")
vim.cmd("let g:minimap_auto_start_win_enter = 1")
vim.cmd([[
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl Noneautocmd FileChangedShellPost *
]])

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.options.globalstatus = true
-- lvim.builtin.lualine.sections.lualine_c = {
-- { 'filename', file_status = false, full_path = true }
-- }

local cmp = require 'cmp'
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


lvim.builtin.cmp.window.completion.winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None"
lvim.builtin.cmp.window.documentation.winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None"
lvim.builtin.cmp.window.completion.border = "rounded"
lvim.builtin.cmp.window.documentation.border = "rounded"
lvim.builtin.treesitter.highlight.disable = function(lang, bufnr) -- Disable in large C++ buffers
  return lang == "verilog" and vim.api.nvim_buf_line_count(bufnr) > 5000
end
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("IndentBlanklineBigFile", {}),
  pattern = "*",
  callback = function()
    if vim.api.nvim_buf_line_count(0) > 5000 then
      require("indent_blankline.commands").disable()
    end
  end,
})
