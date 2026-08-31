return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- `main` is the only branch that supports Neovim 0.11+ / 0.12.
    -- The old `master` branch is frozen at "Neovim 0.10 or 0.11" and crashes
    -- on 0.12 (e.g. the heredoc injection in .tf files -> `range` nil error).
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')

      -- Parsers to keep installed (async install/update on startup).
      ts.install({
        'python',
        'terraform', -- .tf files
        'hcl',       -- .hcl / terraform blocks
        'lua',
        'json',
        'yaml',
        'bash',
      })

      -- Shell files use the `sh` filetype but the `bash` parser.
      vim.treesitter.language.register('bash', { 'sh' })

      -- Enable treesitter highlighting + indentation for any buffer whose
      -- filetype has an available parser. Starting only when the parser is
      -- present avoids the nil-language-tree crash on missing injections.
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end
          local ok, added = pcall(vim.treesitter.language.add, lang)
          if ok and added then
            vim.treesitter.start(args.buf, lang)           -- syntax highlighting
            vim.bo[args.buf].indentexpr =                  -- language-aware indent
              "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
