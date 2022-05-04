local api = vim.api
local fn = vim.fn

local opts = {
  cmd = "phpcbf",
  standard = "PSR12",
  auto_format = false,
}

local M = {}

local executable = false

local function php_fmt()
  if vim.bo.filetype ~= "php" then
    return
  end
  local buf_nr = api.nvim_get_current_buf()
  local file_path = api.nvim_buf_get_name(buf_nr)
  local view = fn.winsaveview()
  local cmd = opts.cmd .. " --standard=" .. opts.standard .. " --encoding=utf8 " .. file_path
  vim.fn.jobstart(cmd, {
    on_exit = function(_, code, _)
      if code == 0 or code == 1 then
        vim.api.nvim_exec("edit", true)
        vim.fn.winrestview(view)
      end
    end,
    on_stderr = function(_, data, _)
      if #data == 0 or #data[1] == 0 then
        return
      end
      local results = "File is not formatted due to error.\n" .. table.concat(data, "\n")
      vim.notify("PHPFormat " .. results, vim.log.levels.WARN)
    end,
  })
end

function M.setup(config)
  opts = vim.tbl_deep_extend("keep", config, opts)

  executable = fn.executable(opts.cmd) > 0

  if not executable or not opts.auto_format then
    return
  end

  local augroup = "PHPFMT"
  api.nvim_create_augroup(augroup, {})
  api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = function()
      pcall(php_fmt)
    end,
  })
end

function M.formatting()
  if not executable then
    return
  end
  pcall(php_fmt)
end

return M
