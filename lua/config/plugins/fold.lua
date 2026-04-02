return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})

		-- h l to open close folds from chrisgrieser/nvim-origami

		-- helper
		local function normal(cmdStr)
			vim.cmd.normal({ cmdStr, bang = true })
		end

		-- `h` closes folds when at the beginning of a line.
		vim.keymap.set({ "n" }, "h", function()
			-- saved as `normal` affects it
			local count = vim.v.count1
			for _ = 1, count, 1 do
				local col = vim.api.nvim_win_get_cursor(0)[2]
				if col == 0 then
					local wasFolded = pcall(normal, "zc")
					if not wasFolded then
						normal("h")
					end
				else
					normal("h")
				end
			end
		end, { noremap = true, silent = true })

		-- `l` on a folded line opens the fold.
		vim.keymap.set({ "n" }, "l", function()
			-- saved as `normal` affects it
			local count = vim.v.count1
			for _ = 1, count, 1 do
				local isOnFold = vim.fn.foldclosed(".") > -1
				local action = isOnFold and "zo" or "l"
				pcall(normal, action)
			end
		end, { noremap = true, silent = true })

    vim.o.foldlevelstart = 99
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
	end,
}
