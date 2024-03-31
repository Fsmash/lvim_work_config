-- Laravel Artisan Support
table.insert(lvim.plugins,
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    event = { "VeryLazy" },
    -- config = function()
    --   -- Laravel LSP
    --   require("laravel").setup({ lsp_server = "intelephense" })
    --   -- Laravel Telescope
    --   require("telescope").load_extension("laravel")
    --   lvim.builtin.which_key.mappings["["] = {
    --     name = "Laravel",
    --     a = { "<cmd>Laravel artisan<cr>", "Artisan" },
    --     r = { "<cmd>Laravel routes<cr>", "Routes" },
    --     m = { "<cmd>Laravel related<cr>", "Related" },
    --     T = { "<cmd>TermExec cmd='php artisan test'<cr>", "Test" },
    --     t = {
    --       function()
    --         local file_name = vim.fn.expand("%:t:r")
    --         vim.api.nvim_command("TermExec cmd='php artisan test --filter " .. file_name .. "'")
    --       end,
    --       "Test current file"
    --     },
    --     p = {
    --       function() require("laravel.tinker").send_to_tinker() end,
    --       "Tinker",
    --     },
    --   }
    -- end,
  }
)
