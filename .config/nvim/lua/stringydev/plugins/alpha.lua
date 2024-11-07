return {

  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    -- local planets = require("util.ascii.planets")
    -- Set header
    -- dashboard.section.header.val = planets["saturn_plus"]

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
}
