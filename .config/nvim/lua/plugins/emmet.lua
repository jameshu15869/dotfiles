return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_language_server = {
          filetypes = {
            "css",
            "html",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "heex",
            "eelixir",
            "elixir",
          },
        },
      },
    },
  },
}
