local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
  return
end

project.setup({
  patterns = {
    ".git",
    "package.json",
    ".terraform",
    "go.mod",
    "requirements.yml",
    "pyrightconfig.json",
    "pyproject.toml",
  },
  -- detection_methods = { "lsp", "pattern" },
  detection_methods = { "pattern" },
})
