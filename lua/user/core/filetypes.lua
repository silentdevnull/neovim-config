vim.filetype.add(
  extension = {
    mdx = "markdown",
    http = "http",
  },
  pattern = {
    [".env"] = "sh",
    [".conf"] = "sh",
  },
)
