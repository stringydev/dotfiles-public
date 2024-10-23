return {
  -- -- Buffer line
  -- {
  --   "akinsho/bufferline.nvim",
  --   event = "VeryLazy",
  --   keys = {
  --     { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
  --     { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  --   },
  --   opts = {
  --     options = {
  --       mode = "tabs",
  --       -- separator_style = "slant",
  --       show_buffer_close_icons = false,
  --       show_close_icon = false,
  --     },
  --   },
  -- },
  --
  -- -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "bwpge/lualine-pretty-path",
    },
    config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status") -- to configure lazy pending updates count
      local icons = require("util.icons")

      lualine.setup({
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            { "pretty_path" },
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
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },

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
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },

        inactive_sections = {
          lualine_c = { "pretty_path" },
        },
      })
    end,
  },

  -- Prettier UI with dressing
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- notifications
  {
    "vigoux/notifier.nvim",
    opts = {},
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
}
