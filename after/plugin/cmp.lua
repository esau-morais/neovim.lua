local status, cmp = pcall(require, "cmp")
if not status then return end
local lspkind = require "lspkind"
local luasnip = require "luasnip"

require("luasnip/loaders/from_vscode").load()

local function formatForTailwindCSS(entry, vim_item)
  if vim_item.kind == "Color" and entry.completion_item.documentation then
    local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
    if r then
      local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
      local group = "Tw_" .. color
      if vim.fn.hlID(group) < 1 then vim.api.nvim_set_hl(0, group, { fg = "#" .. color }) end
      vim_item.kind = "●"
      vim_item.kind_hl_group = group
      return vim_item
    end
  end
  vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
  return vim_item
end

cmp.setup {
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-d>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-b>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-c>"] = cmp.mapping.abort(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = cmp.config.sources {
    {
      name = "nvim_lsp",
      entry_filter = function(entry) return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text" end,
    },
    { name = "path" },
    { name = "buffer" },
    { name = "luasnip" },
  },
  formatting = {
    format = lspkind.cmp_format {
      maxwidth = 50,
      before = function(entry, vim_item) -- for tailwind css autocomplete
        vim_item = formatForTailwindCSS(entry, vim_item)
        return vim_item
      end,
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
]]
