return {
  --
  -- -- Tokyonight
  -- {
  --   "folke/tokyonight.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("tokyonight").setup({
  --       transparent = true,
  --       styles = {
  --         sidebars = "transparent",
  --         floats = "transparent",
  --       },
  --     })
  --     vim.cmd([[colorscheme tokyonight-moon]])
  --   end,
  -- },

  -- Rose-pine
  -- {
  --   "rose-pine/neovim",
  --   priority = 1000,
  --   config = function()
  --     require("rose-pine").setup({
  --       styles = {
  --         transparency = true,
  --         sidebars = "transparent",
  --         floats = "transparent",
  --       },
  --     })
  --     vim.cmd([[colorscheme rose-pine]])
  --   end,
  -- },
  -- Solarized Osaka
  {
    "craftzdog/solarized-osaka.nvim",
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        transparent = true,
        -- styles = {
        --   sidebars = "transparent",
        --   floats = "transparent",
        -- },
      })
      vim.cmd([[colorscheme solarized-osaka]])
    end,
  },
}
