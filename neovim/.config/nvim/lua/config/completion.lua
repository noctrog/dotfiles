local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  completion = {
    get_trigger_characters = function(trigger_characters)
      return vim.tbl_filter(function(char)
        return char ~= ' '
      end, trigger_characters)
    end
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
            elseif cmp.visible() then
                    cmp.select_next_item()
            elseif has_words_before() then
                    cmp.complete()
            else
                    fallback()
            end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
            elseif cmp.visible() then
                    cmp.select_prev_item()
            else
                    fallback()
            end
    end, { "i", "s" }),
    -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'orgmode' },
    { name = 'neorg' },
    { name = 'path' },
  },
}
