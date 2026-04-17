return {
  -- Rust 开发核心插件：rustaceanvim
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        -- rust-analyzer 工具配置
        tools = {
          hover_actions = { auto_focus = true },
          inlay_hints = { auto = true },
        },
        -- LSP 服务器配置
        server = {
          on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
            end

            -- 标准 LSP 快捷键
            map("n", "gd",         vim.lsp.buf.definition,      "Go to Definition")
            map("n", "gD",         vim.lsp.buf.declaration,     "Go to Declaration")
            map("n", "gi",         vim.lsp.buf.implementation,  "Go to Implementation")
            map("n", "gr",         vim.lsp.buf.references,      "References")
            map("n", "K",          vim.lsp.buf.hover,           "Hover Docs")
            map("n", "<leader>rn", vim.lsp.buf.rename,          "Rename Symbol")
            map("n", "<leader>ca", vim.lsp.buf.code_action,     "Code Action")
            map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format File")

            -- rustaceanvim 专属命令
            map("n", "<leader>re", function() vim.cmd.RustLsp("expandMacro") end,    "Expand Macro")
            map("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end,   "Parent Module")
            map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end,      "Runnables")
            map("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end,      "Testables")
            map("n", "<leader>rd", function() vim.cmd.RustLsp("renderDiagnostic") end, "Render Diagnostic")
            map("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end,      "Open Cargo.toml")
            map("n", "<leader>rm", function() vim.cmd.RustLsp("rebuildProcMacros") end, "Rebuild Proc Macros")
            map("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end,      "Join Lines")

            -- 调试（需要 nvim-dap）
            map("n", "<leader>rdb", function() vim.cmd.RustLsp("debuggables") end, "Debuggables")
          end,

          -- rust-analyzer 设置
          default_settings = {
            ["rust-analyzer"] = {
              -- Clippy 检查（替代默认的 cargo check）
              checkOnSave = {
                command = "clippy",
                extraArgs = {
                  "--all-targets",
                  "--all-features",
                  "--",
                  "-W", "clippy::pedantic",
                  "-A", "clippy::must_use_candidate",
                },
              },

              -- 过程宏支持
              procMacro = {
                enable = true,
                attributes = { enable = true },
              },

              -- Cargo 配置
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
              },

              -- 诊断设置
              diagnostics = {
                enable = true,
                experimental = { enable = true },
              },

              -- 内联提示（inlay hints）
              inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true },
                closureReturnTypeHints = { enable = "always" },
                lifetimeElisionHints = {
                  enable = "skip_trivial",
                  useParameterNames = true,
                },
                parameterHints = { enable = true },
                typeHints = { enable = true },
              },

              -- 代码补全
              completion = {
                postfix = { enable = true },
                privateEditable = { enable = true },
              },

              -- 语义高亮
              semanticHighlighting = {
                strings = { enable = true },
              },
            },
          },
        },
      }
    end,
  },

  -- Cargo.toml 依赖管理辅助
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = { enabled = true },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
