local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local augroup_format = vim.api.nvim_create_augroup('Format', { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

-- use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if client.server_capabilities.colorProvider then
    require('document-color').buf_attach(bufnr)
  end

  enable_format_on_save(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- mappings.
  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

protocol.CompletionItemKind = {
  '', -- text
  '', -- method
  '', -- function
  '', -- constructor
  '', -- field
  '', -- variable
  '', -- class
  'ﰮ', -- interface
  '', -- module
  '', -- property
  '', -- unit
  '', -- value
  '', -- enum
  '', -- keyword
  '﬌', -- snippet
  '', -- color
  '', -- file
  '', -- reference
  '', -- folder
  '', -- enummember
  '', -- constant
  '', -- struct
  '', -- event
  'ﬦ', -- operator
  '', -- typeparameter
}

-- set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.colorProvider = {
  dynamicRegistration = true
}

nvim_lsp.flow.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'css', 'typescript', 'typescriptreact', 'typescript.tsx' }
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  cmd = { 'typescript-language-server', '--stdio' },
  capabilities = capabilities
}

nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false
      },
    },
  },
}

nvim_lsp.prismals.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.ltex.setup {
  on_attach = on_attach,
  cmd = { 'ltex-ls' },
  filetypes = { 'markdown', 'text' }
}

nvim_lsp.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = 'all'
    },
  }
}

nvim_lsp.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = '■' },
  severity_sort = true,
}
)

-- diagnostic symbols in the sign column (gutter)
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '■'
  },
  update_in_insert = true,
  float = {
    source = 'always',
  },
})
