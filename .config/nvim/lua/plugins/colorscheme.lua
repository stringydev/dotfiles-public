return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    })
    -- load the colorscheme here
    vim.cmd([[colorscheme tokyonight-moon]])
  end,
}
