return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,   -- ghost text appears automatically as you type
        keymap = {
          accept = false,      -- disabled here; we map <Tab> ourselves below
          next = '<M-]>',      -- Option+] : next suggestion
          prev = '<M-[>',      -- Option+[ : previous suggestion
          dismiss = '<C-]>',   -- Ctrl+]  : dismiss
        },
      },
      panel = { enabled = false },
    },
    config = function(_, opts)
      require('copilot').setup(opts)

      -- <Tab>: accept a Copilot suggestion if one is visible,
      -- otherwise fall through to a normal Tab (respects expandtab/shiftwidth).
      local suggestion = require('copilot.suggestion')
      vim.keymap.set('i', '<Tab>', function()
        if suggestion.is_visible() then
          suggestion.accept()
          return ''
        end
        return '<Tab>'
      end, { expr = true, replace_keycodes = true, desc = 'Copilot accept or Tab' })
    end,
  },
}
