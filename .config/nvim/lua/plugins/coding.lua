return {
  -- Autocompletion
  -- {
  --   "hrsh7th/nvim-cmp", -- Autocomplete engines,
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp", -- Completion source for LSP
  --     "hrsh7th/cmp-buffer", -- Completion source for buffer text
  --     "hrsh7th/cmp-path", -- Completetion source for paths
  --     {
  --       "L3MON4D3/LuaSnip", -- Snippet engine
  --       version = "v2.*",
  --       build = "make install_jsregexp",
  --     },
  --     "saadparwaiz1/cmp_luasnip", -- Required to integrate luasnips with nvim-cmp
  --     "rafamadriz/friendly-snippets", -- Friendly snippets
  --     "onsails/lspkind.nvim", -- VScode like pictograms
  --   },
  --   config = function()
  --     local cmp = require("cmp")
  --     local lspkind = require("lspkind")
  --     local luasnip = require("luasnip")
  --
  --     -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --
  --     cmp.setup({
  --       completion = { completeopt = "menu,menuone,preview,noselect" },
  --
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --         { name = "path" },
  --         { name = "buffer" },
  --       }),
  --
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-k>"] = cmp.mapping.select_prev_item(),
  --         ["<C-j>"] = cmp.mapping.select_next_item(),
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-3),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(5),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<CR>"] = cmp.mapping.confirm({ select = false }),
  --       }),
  --
  --      formatting = {
  --         format = lspkind.cmp_format({
  --           maxwidth = 50,
  --           ellipsis_char = "...",
  --         }),
  --       },
  --
  --       window = {
  --         documentation = cmp.config.window.bordered(),
  --         completion = cmp.config.window.bordered(),
  --       },
  --     })
  --   end,
  -- },

  -- Autopairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },

  -- TS Comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {
      enable = true,
      languages = {
        python = {
          inline = "#",
        },
      },
    },
  },

  -- Comment blocks
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
    },
  },
}
