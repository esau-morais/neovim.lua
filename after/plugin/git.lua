local status, git = pcall(require, "gitsigns")
if not status then return end

git.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    untracked = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
  },
  signcolumn = true, -- toggle with `:Gitsigns toggle_signs`
  numhl = false, -- toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- use default
  max_file_length = 40000, -- disable if file is longer than this (in lines)
  preview_config = {
    -- options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map({ "n", "v" }, "gs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "gr", ":Gitsigns reset_hunk<CR>")
    map("n", "gS", gs.stage_buffer)
    map("n", "gu", gs.undo_stage_hunk)
    map("n", "gR", gs.reset_buffer)
    map("n", "gp", gs.preview_hunk)
    map("n", "gb", function() gs.blame_line { full = true } end)
    map("n", "tb", gs.toggle_current_line_blame)
    map("n", "gd", gs.diffthis)
    map("n", "td", gs.toggle_deleted)
  end,
}
