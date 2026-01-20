-- Add this to ~/.config/nvim/lua/plugins/neo-tree.lua

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- This makes hidden files visible by default
        hide_dotfiles = false, -- Show dotfiles (files starting with .)
        hide_gitignored = false, -- Show files ignored by git
        hide_hidden = false, -- Show hidden files (Windows)
        hide_by_name = {
          -- Add specific files/folders to always hide
          -- "node_modules",
          -- ".git",
          -- ".DS_Store",
          -- "thumbs.db",
        },
        hide_by_pattern = {
          -- Add patterns to hide
          -- "*.meta",
          -- "*/src/*/tsconfig.json",
        },
        always_show = {
          -- Add specific files/folders to always show
          ".gitignored",
          ".env",
        },
        never_show = {
          -- Files to never show regardless of other settings
          -- ".DS_Store",
          -- "thumbs.db",
        },
      },
    },
    window = {
      mappings = {
        ["H"] = "toggle_hidden", -- Keep the H key for toggling
        ["."] = "toggle_hidden", -- Alternative mapping with period key
      },
    },
  },
}

-- Alternative minimal configuration if you just want hidden files visible:
-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   opts = {
--     filesystem = {
--       filtered_items = {
--         visible = true,
--         hide_dotfiles = false,
--       },
--     },
--   },
-- }
