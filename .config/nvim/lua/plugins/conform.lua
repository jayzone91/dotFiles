return {
  "stevearc/conform.nvim",
  dependencies = "mason.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
    formatters_by_ft = require("config.plugins.mason").formatter,
    formatters = {
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in
            ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false))
          do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
        end,
      },
      ["markdownlint-cli2"] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d)
            return d.source == "markdownlint"
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
      csharpier = {
        command = "dotnet-csharpier",
        args = { "--write-stdout" },
      },
      injected = { options = { ignore_errors = true } },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
  end,
}
