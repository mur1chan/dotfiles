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
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file"
})
-- Override the default delete and change commands to use the black hole register
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'c', '"_c', { noremap = true, silent = true })
lvim.keys.normal_mode["<C-T>"] = ":1ToggleTerm<CR>"
-- Do not override the default x command in normal mode
-- vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true }) -- This line is commented out

-- Override the default delete command in visual mode to use the black hole register
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true, silent = true })

-- Do not override the default x command in visual mode
-- vim.api.nvim_set_keymap('v', 'x', '"_x', { noremap = true, silent = true }) -- This line is commented out
-- lvim.lsp.installer.setup.automatic_installation = true
vim.opt.relativenumber = true
-- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
lvim.transparent_window = true

-- set colorscheme
lvim.colorscheme = "catppuccin-latte"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "lua",
  "rust",
  "toml",
  "html",
  -- "htmldjango",
  "nix",
  "python"
}

-- django html setup
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer", "rust" })

local opts = {
  -- filetypes = { "html", "htmldjango" }

  -- HTML ONLY CONFIG
  filetypes = { "html" }
}
require("lvim.lsp.manager").setup("html", opts)
require("lvim.lsp.manager").setup("tailwindcss", opts)
require("lvim.lsp.manager").setup("marksman")
require("lspconfig").rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      inlayHints = {
        bindingModeHints = {
          enable = false,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        closureReturnTypeHints = {
          enable = "never",
        },
        lifetimeElisionHints = {
          enable = "never",
          useParameterNames = false,
        },
        maxLength = 25,
        parameterHints = {
          enable = true,
        },
        reborrowHints = {
          enable = "never",
        },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
    }
  }
})
lvim.plugins = {
  {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("inlay-hints").setup()
    end
  },
  {
    "nvim-pack/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
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
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}
