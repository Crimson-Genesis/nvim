function ColorMe()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMe()
vim.cmd([[
  highlight StatusLine guibg=#000000 guifg=#D8DEE9
]])

