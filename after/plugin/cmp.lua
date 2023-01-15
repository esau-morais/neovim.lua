local status, cmp = pcall(require, 'cmp')
if (not status) then return end
local lspkind = require('lspkind')

require('luasnip/loaders/from_vscode').load()

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
    { name = 'luasnip' },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  hi! Pmenu guibg=#24273A guifg=#CAD3F5
]]
