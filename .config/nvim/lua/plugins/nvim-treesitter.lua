return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync" },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    sync_install = true,
    auto_install = true,
    ensure_installed = {
      "bash",
      "bicep",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "html",
      "http",
      "json",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "powershell",
      "regex",
      "templ",
      "toml",
      "vimdoc",
      "yaml",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
