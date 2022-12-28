local present, obsidian = pcall(require, "obsidian")
if not present then
  return
end

obsidian.setup({
  dir = "~/Documents/notes",
  completion = {
    nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
  }
})
