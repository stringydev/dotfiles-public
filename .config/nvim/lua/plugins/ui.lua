return {
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "bwpge/lualine-pretty-path",
    },
    config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status") -- to configure lazy pending updates count

      lualine.setup({
        options = {
          icons_enabled = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "pretty_path",
              file_status = true, -- displays file status (readonly status, modified status)
            },
          },
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              -- symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
            {
              "diff",
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "pretty_path",
              file_status = true, -- displays file status (readonly status, modified status)
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
      })
    end,
  },

  -- Prettier UI with dressing
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local planets = require("util.ascii.planets")
      -- Set header
      dashboard.section.header.val = planets["saturn_plus"]

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("n", "  " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button("f", "  " .. " Find file", "<cmd>Telescope find_files<cr>"),
        dashboard.button("r", "  " .. " Recent Files", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("w", "  " .. " Find word", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("s", "  " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲  " .. " Lazy", "<cmd>Lazy<cr>"),
        dashboard.button("m", "  " .. " Mason", "<cmd>Mason<cr>"),
        dashboard.button("q", "  " .. " Quit", "<cmd>qa<cr>"),
      }

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = { lsp_doc_border = true },
      lsp = {
        override = {
          -- Override UI elements specifically for LSP
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- Disable all other features in Noice
      cmdline = { enabled = false },
      messages = { enabled = false },
      popupmenu = { enabled = false },
      notify = { enabled = false },
    },
    dependencies = { "MunifTanjim/nui.nvim" },
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  },
}
