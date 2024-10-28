return {
  "neovim/nvim-lspconfig", -- LSP configurations
  dependencies = {
    { "williamboman/mason.nvim" }, -- Installer for external tools
    { "williamboman/mason-lspconfig.nvim" }, -- mason extension for lspconfig
    { "hrsh7th/nvim-cmp" }, -- Autocomplete engine
    { "hrsh7th/cmp-nvim-lsp" }, -- Completion source for LSP
    { "hrsh7th/cmp-buffer" }, -- Completion source for text in buffer
    { "hrsh7th/cmp-path" }, -- Completion source for file system paths
    { "L3MON4D3/LuaSnip", version = "v2.*" }, -- Snippet engine
    { "saadparwaiz1/cmp_luasnip" }, -- Completion source for snippets
    { "rafamadriz/friendly-snippets" }, -- Useful snippets
    { "onsails/lspkind.nvim" }, -- VS-code like pictograms
  },

  config = function()
    -- Setup autocomplete and snippet engines
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      sources = {
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- window = {
      --   completion = cmp.config.window.bordered(),
      --   documentation = cmp.config.window.bordered(),
      -- },
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = {
            menu = function()
              return math.floor(0.45 * vim.o.columns)
            end,
            abbr = 50, -- actual suggestion item
          },
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        }),
      },
    })

    local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_cmds,
      desc = "LSP actions",
      callback = function()
        local bufmap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = true })
        end

        bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
        bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
        bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
        bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
        bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
        bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
        bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
        -- bufmap({'n', 'x'}, '<F4>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
        bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
        bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
        bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
        bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
      end,
    })

    local lspconfig = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff",
      },
      handlers = {
        function(server)
          lspconfig[server].setup({
            capabilities = lsp_capabilities,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = lsp_capabilities,
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
            capabilities = lsp_capabilities,
            settings = {
              pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
              },
              -- python = {
              --   analysis = {
              --     -- Ignore all files for analysis to exclusively use Ruff for linting
              --     ignore = { "*" },
            } --[[  ]],
            -- },
            -- },
          })
        end,
        ["ruff"] = function()
          lspconfig.ruff.setup({
            capabilities = lsp_capabilities,
            -- disable hover capabilities in favour of pyright
            on_attach = function(client, buffer)
              client.server_capabilities.hoverProvider = false
              client.server_capabilities.renameProvider = false
            end,
          })
        end,
      },
    })
  end,
}
