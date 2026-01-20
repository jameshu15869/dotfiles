local map = vim.keymap.set

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- In ~/.config/nvim/lua/config/keymaps.lua or any other config file
vim.keymap.set("n", "<C-\\>", function()
  Snacks.terminal(nil, { win = { position = "float" } })
end, { desc = "Terminal (float)" })

-- If you want it to work in terminal mode too:
vim.keymap.set("t", "<C-\\>", function()
  Snacks.terminal(nil, { win = { position = "float" } })
end, { desc = "Terminal (float)" })

-- cmake stuff
map("n", "<leader>Cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
map("n", "<leader>Cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
map("n", "<leader>Cr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
map("n", "<leader>Cd", "<cmd>CMakeDebug<cr>", { desc = "CMake Debug" })
map("n", "<leader>Ct", "<cmd>CMakeRunTest<cr>", { desc = "CMake Run Tests" })
map("n", "<leader>Cc", "<cmd>CMakeClean<cr>", { desc = "CMake Clean" })
map("n", "<leader>Cs", "<cmd>CMakeStop<cr>", { desc = "CMake Stop" })
map("n", "<leader>Ck", "<cmd>CMakeSelectKit<cr>", { desc = "CMake Select Kit" })
map("n", "<leader>CT", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake Select Build Type" })
map("n", "<leader>CL", "<cmd>CMakeSelectLaunchTarget<cr>", { desc = "CMake Select Launch Target" })
map("n", "<leader>Ci", "<cmd>CMakeInstall<cr>", { desc = "CMake Install" })
