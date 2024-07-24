local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "literal",
        incluteInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
})

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  rootdir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUninported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      }
    }
  }
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" }
})

local servers = { "html", "cssls", "tailwindcss", "eslint" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
