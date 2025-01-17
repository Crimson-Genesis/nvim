function ColorMe()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMe()
vim.cmd([[
  highlight StatusLine guibg=#000000 guifg=#d5d6db
]])
vim.cmd([[
  highlight StatusLineNC ctermfg=gray ctermbg=black guifg=#888888 guibg=#000000
]])
