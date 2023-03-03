local status, lspconfig = pcall(require, "lspconfig")
if not status then return end

local on_attach = function(_, bufnr)
  -- format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function() vim.lsp.buf.format { timeout_ms = 4000 } end,
  })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_config = {
  capabilities = capabilities,
  group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
  on_attach = function(_, bufnr) on_attach(_, bufnr) end,
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

require("mason-lspconfig").setup_handlers {
  function(server_name) lspconfig[server_name].setup(lsp_config) end,
  lua_ls = function()
    lspconfig.lua_ls.setup(vim.tbl_extend("force", lsp_config, {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    }))
  end,
  tsserver = function()
    require("typescript").setup {
      commands = {
        OrganizeImports = {
          organize_imports,
          description = "Organize Imports",
        },
      },
      server = vim.tbl_extend("force", lsp_config, {
        on_attach = function(_, bufnr) on_attach(_, bufnr) end,
        init_options = {
          preferences = {
            jsxAttributeCompletionStyle = "none",
          },
        },
      }),
    }
  end,
}

vim.keymap.set("n", "<leader>o", "<cmd>TypescriptOrganizeImports<cr>")
vim.keymap.set("n", "<leader>a", "<cmd>TypescriptAddMissingImports<cr>")
vim.keymap.set("n", "<leader>r", "<cmd>TypescriptRemoveUnused<cr>")
