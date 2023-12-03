return {
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
    -- example of importing a plugin, comment out to use it or add your own
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
    -- { import = "astrocommunity.colorscheme.catppuccin" },
    -- { import = "astrocommunity.colorscheme.tokyonight-nvim",
      -- enabled = true
    -- },
    -- {
      -- import = "astrocommunity.programming-language-support.csv-vim",
      -- enabled = true
    -- },
    -- { import = "astrocommunity.pack.python",
      -- enabled = true
    -- },
    -- {
      -- import = "astrocommunity.workflow.hardtime-nvim",
      -- enabled = false 
    -- }
    {
      import = "astrocommunity.workflow.completion.copilot-lua",
      enabled = false
    },
  }
