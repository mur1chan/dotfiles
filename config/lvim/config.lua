-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.builtin.telescope.defaults.initial_mode = "insert"
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120
lvim.builtin.telescope.defaults.layout_config.prompt_position = "bottom"
lvim.builtin.telescope.defaults.layout_config.width = 0.75
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
-- lvim.lsp.installer.setup.automatic_installation = true
vim.opt.relativenumber = true
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "lua",
  -- "rust",
  "toml",
  "html",
  "htmldjango",
  "nix",
  "python"
}

-- django html setup
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer", "rust" })

local opts = {
  -- filetypes = { "html", "htmldjango" }

  -- HTML ONLY CONFIG
  filetypes = { "html" }
}
require("lvim.lsp.manager").setup("html", opts)
require("lvim.lsp.manager").setup("tailwindcss", opts)

-- rust setup


lvim.plugins = {
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require('mini.ai').setup()
    end
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*"
  },
  {
    "brooth/far.vim"
  }
}
