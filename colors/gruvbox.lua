-- gruvbox.lua
-- Gruvbox color scheme for Neovim

local colors = {
    fg = "#ebdbb2",
    bg = "#282828",
    bg0 = "#1d2021",
    bg1 = "#3c3836",
    bg2 = "#504945",
    bg3 = "#665c54",
    bg4 = "#7c6f64",
    red = "#fb4934",
    green = "#b8bb26",
    yellow = "#fabd2f",
    blue = "#83a598",
    purple = "#d3869b",
    aqua = "#8ec07c",
    orange = "#fe8019",
    gray = "#928374",
    bright_red = "#fb4934",
    bright_green = "#b8bb26",
    bright_yellow = "#fabd2f",
    bright_blue = "#83a598",
    bright_purple = "#d3869b",
    bright_aqua = "#8ec07c",
    bright_orange = "#fe8019",
    bright_gray = "#a89984",
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "gruvbox"

local function highlight(group, opts)
    local style = opts.style and "gui=" .. opts.style or "gui=NONE"
    local fg = opts.fg and "guifg=" .. opts.fg or "guifg=NONE"
    local bg = opts.bg and "guibg=" .. opts.bg or "guibg=NONE"
    local sp = opts.sp and "guisp=" .. opts.sp or "guisp=NONE"
    vim.cmd(string.format("highlight %s %s %s %s %s", group, style, fg, bg, sp))
end

highlight("Normal", { fg = colors.fg, bg = colors.bg })
highlight("Comment", { fg = colors.gray, style = "italic" })
highlight("Constant", { fg = colors.purple })
highlight("String", { fg = colors.green })
highlight("Identifier", { fg = colors.blue })
highlight("Function", { fg = colors.green })
highlight("Statement", { fg = colors.red })
highlight("Keyword", { fg = colors.red })
highlight("PreProc", { fg = colors.orange })
highlight("Type", { fg = colors.yellow })
highlight("Special", { fg = colors.aqua })
highlight("Underlined", { fg = colors.blue, style = "underline" })
highlight("Ignore", { fg = colors.bg2 })
highlight("Error", { fg = colors.bright_red, bg = colors.bg0 })
highlight("Todo", { fg = colors.yellow, bg = colors.bg2 })

-- More highlight groups can be added here as needed
