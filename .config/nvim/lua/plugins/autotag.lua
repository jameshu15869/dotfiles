return {
  {
    "windwp/nvim-ts-autotag",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    },
    keys = {
      {
        "<CR>",
        function()
          local line = vim.api.nvim_get_current_line()
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local before = line:sub(col, col)
          local after = line:sub(col + 1, col + 1)

          -- Check if cursor is between > and
          if before == ">" and after == "<" then
            return "<CR><CR><Up><Tab>"
          end
          return "<CR>"
        end,
        expr = true,
        mode = "i",
        ft = { "html", "heex", "eelixir", "elixir", "xml", "javascriptreact", "typescriptreact" },
      },
    },
  },
}
