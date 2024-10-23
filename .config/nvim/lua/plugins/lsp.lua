return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local handlers = {
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,
      -- Next, you can provide targeted overrides for specific servers.
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
      end,
      ["pyright"] = function()
        lspconfig.pyright.setup({
          capabilities = capabilities,
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
              },
            },
          },
        })
      end,
      ["ruff"] = function()
        lspconfig.ruff.setup({
          -- disable hover capabilities in favour of pyright
          on_attach = function(client, buffer)
            client.server_capabilities.hoverProvider = false
            client.server_capabilities.renameProvider = false
          end,
          capabilities = capabilities,
          trace = "messages",
          init_options = {
            settings = {
              logLevel = "debug",
            },
          },
        })
      end,
    }

    require("mason-lspconfig").setup({ handlers = handlers })

    -- Autocommand for LSP actions
    local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_cmds,
      desc = "LSP: Actions",
      callback = function(args)
        local bufmap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = true })
        end
        -- TODO: turn to keymap
        bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
        bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
        bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
        bufmap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
        bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
        bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
        bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
        -- Using conform to format
        -- bufmap({ 'n', 'x' }, '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
        bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
        bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
        bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
        bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
        -- Toggle inlay hints
        bufmap("n", "<leader>i", function()
          print("Inlay me...!")
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr = 0 })
        end)
      end,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local icons = require("config.icons").diagnostics
    local signs = { Error = icons.Error, Warn = icons.Warn, Hint = icons.Hint, Info = icons.Info }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}
