
local function open_with_system_app(state)
  local node = state.tree:get_node()
  local path = node and node.path or nil
  if not path then return end
  -- Adjust the command below according to your OS
  local open_cmd
  if vim.fn.has("mac") == 1 then
    open_cmd = "open"
  elseif vim.fn.has("win32") == 1 then
    open_cmd = "start"
  else
    open_cmd = "xdg-open"
  end
  -- Run the command asynchronously
  vim.fn.jobstart({open_cmd, path}, {detach = true})
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			enable_git_status = true,
			auto_expand_width = true,
			window = {
				mappings = {
					["o"] = open_with_system_app,
				},
			},
			git_status = {
				symbols = {
					added = "a",
					modified = "c",
					deleted = "d",
					renamed = "r",
					conflict = "c",
				},
			},
			default_component_configs = {},
		})
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
	end,
}
