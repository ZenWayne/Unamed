return {
  -- 主题
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night" },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          { "filename", path = 1 },
        },
        lualine_x = {
          "encoding",
          { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
          "filetype",
        },
      },
    },
  },

  -- 文件树
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>ft", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Tree" },
    },
    opts = {
      filters = { dotfiles = false },
      renderer = { group_empty = true },
    },
  },

  -- 模糊搜索
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>",  desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>",   desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",     desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>",   desc = "Help Tags" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
    },
    config = function()
      require("telescope").setup({
        extensions = { fzf = {} },
      })
      require("telescope").load_extension("fzf")
    end,
  },

  -- 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "rust", "toml", "lua", "bash", "markdown", "json" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- 括号自动配对
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },

  -- 注释快捷键
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Toggle Comment" },
      { "gb", mode = { "n", "v" }, desc = "Toggle Block Comment" },
    },
    opts = {},
  },

  -- Git 集成
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
      },
    },
  },

  -- 快捷键提示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
