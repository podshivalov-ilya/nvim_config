local M = {}

M.current = "dark"

function M.set(mode)
  if mode == "light" then
    vim.o.background = "light"
    vim.cmd("colorscheme dawnfox")
    M.current = "light"
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme tokyonight-moon")
    M.current = "dark"
  end
end

vim.api.nvim_create_user_command("LightMode", function() M.set("light") end, {})
vim.api.nvim_create_user_command("DarkMode",  function() M.set("dark")  end, {})

local hour = tonumber(os.date("%H"))
if hour >= 7 and hour < 19 then
  M.set("light")
else
  M.set("dark")
end

return M
