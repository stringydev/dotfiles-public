return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    presets = { lsp_doc_border = true },
    lsp = {
      override = {
        -- Override UI elements specifically for LSP
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      documentation = {
        view = "hover",
        opts = { -- lsp_docs settings
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          position = { row = 2, col = 2 },
          size = {
            max_width = 0.8 * vim.api.nvim_win_get_width(0),
            max_height = 15,
          },
          border = {
            style = "rounded",
          },
          win_options = {
            concealcursor = "n",
            conceallevel = 3,
            winhighlight = {
              Normal = "CmpPmenu",
              FloatBorder = "DiagnosticSignInfo",
            },
          },
        },
      },
    },
    -- Disable all other features in Noice
    cmdline = { enabled = false },
    messages = { enabled = false },
    popupmenu = { enabled = false },
    notify = { enabled = false },
  },
}
