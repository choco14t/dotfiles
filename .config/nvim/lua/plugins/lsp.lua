return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "graphql-language-service-cli",
        "json-lsp",
        "lua-language-server",
        "prettier",
        "rust-analyzer",
        "stylua",
        "terraform-ls",
        "typescript-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
}
