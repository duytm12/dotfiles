local o = vim.opt
vim.g.mapleader = ' '          -- space is the leader key
o.expandtab = true             -- spaces, not tabs
o.shiftwidth = 2               -- 2 spaces per indent level
o.tabstop = 2                  -- a tab renders as 2 spaces
o.softtabstop = 2              -- <Tab>/<BS> operate on 2 spaces
o.autoindent = true            -- keep the previous line's indent on a new line
-- note: no `smartindent` — it misbehaves in Python (comments jump to col 0).
-- treesitter's `indent` handles Python/Terraform correctly instead.
o.number = true                -- absolute number on the cursor line, relative elsewhere
o.relativenumber = true        -- relative line numbers for fast jumps
o.ignorecase = true            -- search is case-insensitive by default
o.smartcase = true             -- case-sensitive only if i type a capital
o.clipboard = 'unnamedplus'    -- share the system clipboard
o.scrolloff = 16               -- keep cursor away from the screen edge
o.undofile = true              -- persistent undo across sessions

