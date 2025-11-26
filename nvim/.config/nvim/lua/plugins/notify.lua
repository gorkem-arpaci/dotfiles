return {
  -- 1. Snacks.nvim: Bildirim özelliğini tamamen devre dışı bırak
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        enabled = false,
      },
    },
  },
  -- 2. Noice.nvim: Bildirim özelliğini tamamen devre dışı bırak
  {
    "folke/noice.nvim",
    opts = {
      notify = {
        enabled = false,
      },
    },
  },
  -- 3. nvim-notify: Sahne senin!
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      -- Burası kritik: Neovim'in bildirim fonksiyonunu ele geçir
      vim.notify = require("notify")
    end,
  },
}
