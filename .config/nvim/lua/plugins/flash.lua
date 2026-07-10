return {
  {
    "folke/flash.nvim",
    keys = {
      { "s", false },
      {
        "gs",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash",
      },
      { "S", false },
      {
        "gS",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash",
      },
    },
  },
}
