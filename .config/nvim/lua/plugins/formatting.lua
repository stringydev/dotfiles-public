return {
  -- Formatters setup using Conform with Mason tool installer
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    dependencies = {
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          ensure_installed = {
            "prettier", -- Prettier formatter
            "stylua",   -- Lua formatter
          },
        },
      },
      "williamboman/mason.nvim", -- Mason itself as a dependency
    },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        python = {
          "ruff_fix",           -- Fix auto-fixable lint errors
          "ruff_format",        -- Run the Ruff formatter
          "ruff_organize_imports", -- Organize imports
        },
        lua = { "stylua" },    -- Lua formatter
      },
      -- Set default options
      default_format_opts = {
        lsp_format = "fallback",
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500 },
    },
  },
}

