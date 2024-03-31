-- WHICHKEY

-- Clean up of whichkey menu
lvim.builtin.which_key.mappings["D"] = lvim.builtin.which_key.mappings["d"]
lvim.builtin.which_key.mappings["d"] = {}

lvim.builtin.which_key.mappings["P"] = lvim.builtin.which_key.mappings["p"]
lvim.builtin.which_key.mappings["p"] = {}

lvim.builtin.which_key.mappings["w"] = {}
lvim.builtin.which_key.mappings["q"] = {}
lvim.builtin.which_key.mappings["c"] = {}
lvim.builtin.which_key.mappings["h"] = {}
lvim.builtin.which_key.mappings["e"] = {}
lvim.builtin.which_key.mappings[";"] = {}
lvim.builtin.which_key.mappings["f"] = {}
lvim.builtin.which_key.mappings["/"] = {}
lvim.builtin.which_key.vmappings["/"] = {}

-- Undotree
lvim.builtin.which_key.mappings["U"] = { "<cmd>UndotreeToggle<cr>", "Undotree" }

-- Telescope
lvim.builtin.which_key.mappings["s"] = {
  name = "Search",
  b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
  H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
  M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  R = { "<cmd>Telescope registers<cr>", "Registers" },
  k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  l = { "<cmd>Telescope resume<cr>", "Resume last search" },
  a = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "Live Grep Args" },
  c = { "<cmd>Telescope commands<cr>", "Commands" }
}

-- Telescope Recent files
lvim.builtin.which_key.mappings["sr"] = {
  function()
    require('telescope.builtin').oldfiles({
      find_command = { "fd", "-t=f", "-a" },
      path_display = { "absolute" },
      wrap_results = true,
      previewer = false,
    })
  end, "Recent Files"
}

-- Telescope Find all files
lvim.builtin.which_key.mappings["sf"] = {
  function()
    require('telescope.builtin').find_files({
      find_command = { "fd", "-t=f", "-a" },
      path_display = { "absolute" },
      wrap_results = true,
      previewer = false,
    })
  end, "Find All File"
}

-- Telescope Grep string
lvim.builtin.which_key.mappings["st"] = {
  function()
    require('telescope.builtin').live_grep({
      preview = {
        filesize_limit = 10,
        timeout = 100,
        path_display = { "absolute" },
        wrap_results = true,
      }
    })
  end, "Grep String"
}

-- Telescope Grep string under cursor
lvim.builtin.which_key.mappings["sg"] = {
  function()
    require('telescope.builtin').grep_string({
      preview = {
        filesize_limit = 10,
        timeout = 100,
        path_display = { "absolute" },
        wrap_results = true,
      }
    })
  end, "Grep String Under Cursor"
}

-- Telescope Find files with preview
lvim.builtin.which_key.mappings["sp"] = {
  function()
    require('telescope.builtin').find_files({
      find_command = { "fd", "-t=f", "-a" },
      path_display = { "absolute" },
      wrap_results = true,
      previewer = true,
    })
  end, "Find File with Preview"
}

-- Move current buffer to absolute ordinal position
lvim.builtin.which_key.mappings["bm"] = {
  function()
    local buf_pos = tonumber(vim.fn.input("Buffer position: "))
    if buf_pos ~= nil then
      require("bufferline").move_to(buf_pos)
    else
      print("Invalid buffer position.")
      return
    end
    print("Buffer moved to position " .. buf_pos)
  end, "Move Buffer to Ordinal Position"
}

-- SESSION MANAGEMENT: See ~/.config/lvim/lua/telescope/_extensions/
lvim.builtin.telescope.on_config_done = function(telescope)
  telescope.load_extension("session_picker") -- Have to tell lvim to explicitly load extensions.
end

lvim.builtin.which_key.mappings["S"] = {
  name = "Sessions",
  c = {
    function()
      local session_name = vim.fn.input("Session name: ")
      local cur_session_dir = vim.fn.getcwd() .. "/.sessions/"
      if vim.fn.isdirectory(cur_session_dir) ~= 1 then
        cur_session_dir = "~/.local/state/lvim/sessions/"
      end
      local cur_session = cur_session_dir .. session_name .. ".vim"
      vim.api.nvim_command("mksession " .. cur_session)
      print("Session " .. session_name .. " created!")
    end,
    "Create New Session"
  },
  p = { "<cmd>Telescope session_picker<cr>", "Available Sessions" },
  s = {
    function()
      local cur_session = vim.api.nvim_exec2("echo v:this_session", { output = true })
      cur_session = cur_session.output
      if cur_session == "" then
        print("No session.")
      else
        vim.api.nvim_command("mksession! " .. cur_session)
        print("Session saved!")
      end
    end,
    "Save Current Session"
  },
}
