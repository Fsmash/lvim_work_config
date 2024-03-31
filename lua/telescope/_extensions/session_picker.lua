-- SESSIONS
--
-- This is my own implementation of a session manager.
-- Everything else is too bloated for my taste or just doesn't do what I want.

-- Define command to save a session
local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local Path = require("plenary.path")

local session_picker = function(opts)
  local get_sessions = function()
    local cur_dir = vim.fn.getcwd() .. "/.sessions"
    if vim.fn.isdirectory(cur_dir) == 1 then
      return vim.fn.glob(cur_dir .. "/*.vim", false, true)
    end
    local session_dir = "~/.local/state/lvim/sessions"
    return vim.fn.glob(session_dir .. "/*.vim", false, true)
  end

  opts = opts or {}
  pickers.new(opts, {

    prompt_title = "Sessions",
    finder = finders.new_table {
      results = get_sessions(),
      entry_maker = function(entry)
        local file_name = vim.fn.fnamemodify(entry, ":t:r")
        return {
          value = entry,
          display = file_name,
          ordinal = file_name,
        }
      end
    },
    sorter = conf.file_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      -- Deletes selected session
      local delete_session = function()
        local selection = action_state.get_selected_entry()
        if not selection then return end

        local confirm = vim.fn.confirm(
          "You're about to delete session" .. selection.value .. ". Proceed? [y/N]: ",
          "&Yes\n&No",
          "No"
        )

        local current_picker = action_state.get_current_picker(prompt_bufnr)
        if confirm == 1 then
          current_picker:delete_selection(function(entry)
            local p = Path:new(entry.value)
            p:rm()
          end)
          print("\nThe session has been deleted!")
        end
        actions.close(prompt_bufnr)
      end

      map("i", "<C-x>", delete_session)
      map("n", "<C-x>", delete_session)

      -- Default mapping for <CR>
      actions.select_default:replace(function()
        -- Source selected session
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if not selection then return end
        vim.cmd('confirm silent %bdelete')
        vim.cmd('silent source ' .. selection.value)
      end)
      return true
    end,
  }):find()
end

return telescope.register_extension({
  exports = {
    session_picker = session_picker
  }
})
