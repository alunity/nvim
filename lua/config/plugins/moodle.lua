return {
  dir = "~/code/moodle.nvim/",
  name = "moodle.nvim",
  config = function()
    require("moodle").setup()

    vim.keymap.set("n", "<leader>nl", function()
      require("moodle").search_links()
    end, { desc = "Search links" })

    vim.keymap.set("n", "<leader>nc", function()
      require("moodle").search_courses()
    end, { desc = "Search links" })

  end,
}
