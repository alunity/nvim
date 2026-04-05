return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  opts = {
    ensure_installed = { "lua", "python", "javascript" }, -- etc
    highlight = { enable = true },
  },
}
