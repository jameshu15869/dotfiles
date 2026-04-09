-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo(
      { { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } },
      true,
      {}
    )
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = { -- add your plugins here
    {
      "kylechui/nvim-surround",
      version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
      end,
    },
    {
      "chrisgrieser/nvim-spider",
      lazy = true,
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {},
      keys = {
        {
          "gs",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash",
        },
        {
          "gS",
          mode = { "n", "x", "o" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter",
        },
        {
          "r",
          mode = "o",
          function()
            require("flash").remote()
          end,
          desc = "Remote Flash",
        },
        {
          "R",
          mode = { "o", "x" },
          function()
            require("flash").treesitter_search()
          end,
          desc = "Treesitter Search",
        },
        {
          "<c-s>",
          mode = { "c" },
          function()
            require("flash").toggle()
          end,
          desc = "Toggle Flash Search",
        },
      },
    },
    {
      "gbprod/substitute.nvim",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
    {
      "nvim-mini/mini.nvim",
      version = false,
    },
    {
      "ggandor/leap.nvim",
      config = function()
        vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
        vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {
    colorscheme = { "habamax" },
  },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
  },
})

-- nvim-spider keymaps
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")

-- substitute nvim
vim.keymap.set("n", "<leader>s", require("substitute").operator, {
  noremap = true,
})
vim.keymap.set("n", "<leader>ss", require("substitute").line, {
  noremap = true,
})

-- vscode-specific functionality
local vscode = require("vscode")

-- these go here because SPC breaks in the command palette
vim.keymap.set("n", "<leader>wd", function()
  vscode.call("workbench.action.closeEditorsAndGroup")
end)

vim.keymap.set("n", "<leader>wv", function()
  vscode.call("workbench.action.splitEditor")
end)

vim.keymap.set("n", "<leader>ws", function()
  vscode.call("workbench.action.splitEditorDown")
end)

vim.keymap.set("n", "<leader><space>", function()
  vscode.call("workbench.action.quickOpen")
end)

vim.keymap.set("n", "<leader>/", function()
  vscode.call("periscope.search")
end)

vim.keymap.set("n", "<leader>p", function()
  vscode.action("workbench.action.showCommands")
end)

vim.keymap.set("n", "<leader>e", function()
  vscode.action("workbench.action.toggleSidebarVisibility")
end)

vim.keymap.set("n", "[e", function()
  vscode.action("editor.action.marker.prev")
end)
vim.keymap.set("n", "]e", function()
  vscode.action("editor.action.marker.next")
end)

-- enable mini plugins
require("mini.ai").setup()

-- Decrease the time it takes to trigger CursorHold (default is 4000ms / 4 seconds)
-- 300ms is a good sweet spot so it doesn't flash constantly while you navigate
vim.o.updatetime = 300

-- Tell VS Code to show the hover tooltip when the cursor stops moving
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.fn.VSCodeNotify("editor.action.showHover")
  end,
})
