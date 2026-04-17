return {
  -- 代码补全引擎
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",       -- LSP 补全源
      "hrsh7th/cmp-buffer",         -- 缓冲区词汇
      "hrsh7th/cmp-path",           -- 文件路径
      "hrsh7th/cmp-cmdline",        -- 命令行补全
      "saadparwaiz1/cmp_luasnip",   -- Snippet 源
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- 补全图标
      local kind_icons = {
        Text          = "󰊄", Method        = "󰆧", Function      = "󰊕",
        Constructor   = "",  Field         = "󰇽", Variable      = "󰂡",
        Class         = "󰠱", Interface     = "",  Module        = "",
        Property      = "󰜢", Unit          = "",  Value         = "󰎠",
        Enum          = "",  Keyword       = "󰌋", Snippet       = "",
        Color         = "󰏘", File          = "󰈙", Reference     = "",
        Folder        = "󰉋", EnumMember    = "",  Constant      = "󰏿",
        Struct        = "",  Event         = "",  Operator      = "󰆕",
        TypeParameter = "󰅲",
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- 按键映射：回车确认补全
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),

          -- 回车确认：有选项时确认，无选项时正常换行
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Tab：在补全项和 snippet 跳转点之间切换
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- 补全来源优先级
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          { name = "crates",   priority = 700 },  -- Cargo.toml 依赖
        }, {
          { name = "buffer",   priority = 500 },
          { name = "path",     priority = 250 },
        }),

        -- 补全格式化
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "?", vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip  = "[Snip]",
              buffer   = "[Buf]",
              path     = "[Path]",
              crates   = "[Crates]",
            })[entry.source.name] or ""
            -- 截断过长的补全项
            local max_width = 50
            if #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width) .. "…"
            end
            return vim_item
          end,
        },

        -- 实验性功能
        experimental = {
          ghost_text = { hl_group = "CmpGhostText" },
        },
      })

      -- 命令行 / 搜索 补全
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        ),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
