return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master', -- classic API (configs.setup); `main` is the WIP rewrite
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      -- parsers to keep installed
      ensure_installed = {
        'python',
        'terraform', -- .tf files
        'hcl',       -- .hcl / terraform blocks
        'lua',
        'json',
        'yaml',
        'bash',
      },
      highlight = { enable = true },   -- treesitter-based syntax highlighting
      indent = { enable = true },      -- language-aware indentation (Python, HCL, ...)
    },
  },
}
