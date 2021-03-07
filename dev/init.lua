package.loaded['dev'] = nil
package.loaded['toggleTest'] = nil
package.loaded['toggleTest.utils'] = nil
package.loaded['toggleTest.fileUtils'] = nil

ToggleTest = require("toggleTest")

vim.api.nvim_set_keymap('n', ',r', "<cmd>luafile dev/init.lua<cr>", {})
vim.api.nvim_set_keymap("n", ",w", ":lua print(vim.inspect(ToggleTest.toggleToFile('edit')))<cr>", {})
