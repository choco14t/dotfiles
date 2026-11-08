local M = {}

function M.setup()
  if #vim.api.nvim_list_uis() == 0 then
    return
  end
  local devicons = require("nvim-web-devicons")

  local active_group = "Normal"
  local inactive_group = "NonText"
  local icons = { error = "󰅚 ", warn = "󰀪 ", hint = "󰌶 ", info = " " }
  local modes = {
    n = "NORMAL",
    i = "INSERT",
    R = "REPLACE",
    v = "VISUAL",
    V = "VISUAL LINE",
    ["\22"] = "VISUAL BLOCK",
    s = "SELECT",
    S = "SELECT LINE",
    ["\19"] = "SELECT BLOCK",
    c = "COMMAND",
    t = "TERMINAL",
    r = "PROMPT",
    ["!"] = "SHELL",
  }

  --- @param props { buf: number, win: number, focused: boolean }
  local function get_diagnostic_label(props)
    local label = {}

    for severity, icon in pairs(icons) do
      local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
      if n > 0 then
        table.insert(label, {
          icon .. n .. " ",
          group = props.focused and ("DiagnosticSign" .. severity) or "NonText",
        })
      end
    end
    if #label > 0 then
      table.insert(label, { "┊ ", group = inactive_group })
    end
    return label
  end

  -- based on https://github.com/b0o/incline.nvim/discussions/32
  --- @param props { buf: number, win: number, focused: boolean }
  local function render(props)
    props.focused = props.win == vim.api.nvim_get_current_win()
    local filename = vim.fs.basename(vim.api.nvim_buf_get_name(props.buf))

    local ft_icon = devicons.get_icon_color(filename)

    local hasError = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity["ERROR"] }) > 0
    local isReadonly = vim.bo[props.buf].readonly

    local filename_group = hasError and "DiagnosticError" or (isReadonly and inactive_group or active_group)
    filename_group = props.focused and filename_group or inactive_group
    local mode = vim.api.nvim_get_mode().mode
    local mode_label = modes[mode:sub(1, 1)] or mode:upper()

    return {
      {
        props.focused and (mode_label:sub(1, 1) .. " ┊ ") or "",
        group = active_group,
        gui = "bold",
      },
      { get_diagnostic_label(props) },
      {
        (ft_icon and ft_icon .. " " or ""),
        group = props.focused and active_group or inactive_group,
      },
      {
        (isReadonly and " " or ""),
        group = filename_group,
      },
      {
        filename,
        group = filename_group,
        gui = props.focused and "bold" or "",
      },
      {
        vim.bo[props.buf].modified and " ●" or "",
        group = props.focused and "Constant" or inactive_group,
      },
    }
  end

  require("incline").setup({
    highlight = {
      groups = {
        InclineNormal = { guibg = "none" },
        InclineNormalNC = { guibg = "none" },
      },
    },
    window = {
      options = {
        winblend = 0,
      },
      placement = {
        horizontal = "right",
        vertical = "bottom",
      },
      margin = { horizontal = 0, vertical = 0 },
      padding = 2,
    },
    render = render,
  })
end

return M
