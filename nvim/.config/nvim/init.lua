-- init saturn
saturn = vim.deepcopy(require("saturn.config.settings"))
package.loaded["lazyvim.config.options"] = true
require("saturn.config.lazy")
