local ok, bufferline = pcall(require, "bufferline")

if not ok then return end

bufferline.setup({
  options = {
    mode = "buffers",
    separator_style = "slope",
    buffer_close_icon = "",
    close_icon = "",
    modified_icon = "●",
    color_icons = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" }
    },
  }
})

