-- PLUGINS
lvim.plugins = {
  { "sainnhe/gruvbox-material", },
  { "jeffkreeftmeijer/vim-numbertoggle" },
  { "easymotion/vim-easymotion" },
  { "mbbill/undotree" },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    version = "^1.0.0"
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
        require("copilot_cmp").setup()
      end, 100)
    end,
  },
}
