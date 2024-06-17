local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Don't error on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Install Plugins
return lazy.setup("plugins", {
  git = {
    url_format = "git@github.com:%s.git"
  },
  change_detection = {
    notify = false
  }
})
