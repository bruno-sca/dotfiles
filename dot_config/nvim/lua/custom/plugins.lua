local overrides = require("custom.configs.overrides")

local plugins = {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = overrides.copilot,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "copilot",  group_index = 2 },
        { name = "luasnip",  group_index = 2 },
        { name = "buffer",   group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path",     group_index = 2 },
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },

  {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
      end
      dap.listeners.before.even_terminated["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function ()
      require("custom.configs.dap")
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui"
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  -- GOLANG
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function (_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function ()
      vim.cmd([[silent! GoInstallDeps]])
    end
  },
  -- END GOLANG
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    opts = function ()
        return require("custom.configs.null-ls")
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- ts
        "eslint-lsp",
        "eslint_d",
        "js-debug-adapter",
        "prettier",
        "tailwindcss-language-server",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        -- end ts
        -- lua
        "lua-language-server",
        "stylua",
        -- end lua
        -- go
        "gopls",
        "goimports",
        "gofumpt",
        "golines",
        "delve",
        -- end go
        -- python
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright"
        -- end python
      }
      }
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
      "html",
    },
    config = function ()
      require("nvim-ts-autotag").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function ()
      opts = require "plugins.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "json",
        "jsonc",
        "tsx",
        "vim",
        "vimdoc",
        "css",
        "html",
        "go",
      }
      return opts
    end
  }
}
return plugins
