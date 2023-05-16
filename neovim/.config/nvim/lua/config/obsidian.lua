require('obsidian').setup({
  dir = '~/Sync/obsidian/vault',
  completion = {
    nvim_cmp = true,
  },
  note_frontmatter_func = function(note)
    local out = { id = note.id, tags = note.tags }
    -- `note.metadata` contains any manually added fields in the frontmatter.
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end
    return out
  end,
})
