vim.g.mapleader = " "

vim.api.nvim_set_keymap("t", "<Leader><ESC>", "<C-\\><C-n>", { noremap = true })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>gs", ":G add .<CR>") -- stages all files
vim.keymap.set("n", "<leader>gc", ":G commit<CR>")
vim.keymap.set("n", "<leader>gp", ":G push<CR>")
vim.keymap.set("n", "<leader>gg", ":G <CR>")

vim.keymap.set("n", "<leader>ly", function()
	local cur = vim.api.nvim_win_get_cursor(0)
	local ok = true

	if vim.fn.search([[\<class\s\+Solution\>]], "w") == 0 then
		vim.notify("class Solution not found", vim.log.levels.WARN)
		ok = false
	end
	if ok and vim.fn.search("{", "W") == 0 then
		vim.notify("{ after class Solution not found", vim.log.levels.WARN)
		ok = false
	end
	if ok then
		vim.cmd("normal! 0V%$")
		vim.cmd('normal! "+y')
		vim.notify("Yanked class Solution to clipboard")
	end

	vim.api.nvim_win_set_cursor(0, cur)
end, { desc = "Yank class Solution to clipboard" })

vim.keymap.set("n", "<leader>m", function()
	Snacks.picker.notifications()
end, { desc = "Notification History (Snacks)" })

vim.keymap.set("n", "<leader>r", ':lua package.loaded["moodle"] = nil; require("moodle").setup()<CR>')
vim.keymap.set("n", "<leader>n", ':Moodle<CR>')
-- :lua Snacks.picker.notifications()

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
