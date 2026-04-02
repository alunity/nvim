vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2

vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.o.wrap = true

vim.api.nvim_set_option("clipboard", "unnamedplus")

-- line wrapping
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = string.rep(" ", 0) -- Make it so that long lines wrap smartly
vim.opt.linebreak = true

-- vim.opt.showtabline = 2

if (vim.loop.os_uname().sysname == "Windows_NT")
then
  vim.opt.undodir = os.getenv("homepath") .. "/.vim/undodir"

  vim.o.shell = "pwsh.exe"
  vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
  vim.opt.shellxquote = ''
else
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

-- enable virtual text
vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR },
    format = function(diagnostic)
      local first_line = diagnostic.message:gmatch("[^\n]*")()
      local first_sentence = string.match(first_line, "(.-%. )") or first_line
      local first_lhs = string.match(first_sentence, "(.-): ") or first_sentence
      return first_lhs
    end
  },
})
