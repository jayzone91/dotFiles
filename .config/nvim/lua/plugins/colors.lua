return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      italic_comments = true,
      hide_fillchars = false,
      borderless_telescope = false,
      terminal_colors = true,
      chache = true,
      theme = {
        variant = "default",
      },
    },
    config = function(_, opts)
      require("cyberdream").setup(opts)

      vim.cmd("colorscheme cyberdream")
    end,
  },
}
