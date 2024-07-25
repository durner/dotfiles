local opt = vim.opt
local g = vim.g

-- syntax
opt.termguicolors = true

-- leader
g.mapleader = ','

-- encoding
opt.encoding = "utf8"
opt.enc = "utf-8"
opt.fileencoding = "utf-8"

-- Reload files modified outside of Vim
opt.autoread = true

-- Stop vim from creating automatic backups
opt.backup = false
opt.wb = false
opt.directory = "/tmp/.vim/"

-- Replace tabs with spaces
opt.expandtab = true

-- Make tabs 4 spaces wide
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- Auto Load Localvimrc
g.localvimrc_ask = 0

-- indent
opt.display = "lastline"
opt.autoindent = true
opt.smartindent = true

-- wrap
opt.wrap = true
opt.linebreak = true

-- wrap indention
opt.breakindent = true
opt.breakindentopt = "shift:2"

-- Show line numbers
opt.number = true

-- Highlight all occurrences of a search
opt.hlsearch = true

-- search case insensitive if term is all lowercase
opt.ignorecase = true
opt.smartcase = true
opt.colorcolumn = "0"

-- misc settings
opt.compatible = false
opt.equalalways = false
opt.showmatch = true
opt.wildmode = "longest:full"
opt.wildmenu = true
opt.hidden = true
opt.backspace = "2"
opt.backspace = "indent,eol,start"
opt.signcolumn = "yes"
opt.timeoutlen = 400
opt.updatetime = 250

-- Enable .vimrc files per project
opt.exrc = true
opt.secure = true

-- Easier Clipboard integration
opt.clipboard = "unnamed"
if vim.fn.has("unnamedplus") == 1 then
    opt.clipboard:append("unnamedplus")
end
opt.mouse = "a"
opt.mousemoveevent = true

-- Diagnostics
opt.shortmess:append("c")
opt.laststatus = 3
opt.showmode = false
opt.cursorline = true

-- Ignore
opt.wildignore:append("*/tmp/*,*.so,*.swp,*.zip")
opt.ma = true

-- persistent undo
local undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true
opt.undodir = undodir
opt.undolevels = 1000
opt.undoreload = 10000


-- Disable some tools
local disabled_built_ins = { "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw", "netrwPlugin",
    "netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin", "rrhelper",
    "spellfile_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin",
    "synmenu", "optwin", "compiler", "bugreport", "ftplugin" }

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
