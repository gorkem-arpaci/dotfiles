return {
  -- Highlight colors (Renk vurgulamaları)
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },

  -- Telescope (Arama motoru)
  {
    "nvim-telescope/telescope.nvim",
    priority = 1000,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        ";f",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files({
            no_ignore = false,
            hidden = true,
          })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        ";r",
        function()
          local builtin = require("telescope.builtin")
          builtin.live_grep()
        end,
        desc = "Search for a string in your current working directory",
      },
      {
        "\\\\",
        function()
          local builtin = require("telescope.builtin")
          builtin.buffers()
        end,
        desc = "Lists open buffers",
      },
      {
        ";;",
        function()
          local builtin = require("telescope.builtin")
          builtin.resume()
        end,
        desc = "Resume the previous telescope picker",
      },
      {
        ";e",
        function()
          local builtin = require("telescope.builtin")
          builtin.diagnostics()
        end,
        desc = "Lists Diagnostics",
      },
      {
        ";s",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      {
        "sf",
        function()
          -- Telescope yüklenmemişse korumalı çağrı yap
          local status, telescope = pcall(require, "telescope")
          if not status then
            vim.notify("Telescope not found yet", vim.log.levels.WARN)
            return
          end

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },
    },
    -- Config fonksiyonunu "opts" ile birleştirip güvenli hale getirdik
    config = function(_, opts)
      -- 1. Güvenlik Kontrolü: Telescope var mı? Yoksa çökme, sessizce çık.
      local status, telescope = pcall(require, "telescope")
      if not status then
        return
      end

      local actions = require("telescope.actions")

      -- Extension action'larını güvenli al
      local fb_actions
      pcall(function()
        fb_actions = telescope.extensions.file_browser.actions
      end)

      -- 2. Opts boş gelirse diye koruma
      opts = opts or {}
      opts.defaults = opts.defaults or {}

      -- Ayarları birleştir (Merge)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })

      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }

      -- File Browser ayarları
      opts.extensions = opts.extensions or {}
      opts.extensions.file_browser = {
        theme = "dropdown",
        hijack_netrw = true,
        mappings = {
          ["n"] = {
            ["N"] = fb_actions and fb_actions.create,
            ["h"] = fb_actions and fb_actions.goto_parent_dir,
            ["<C-u>"] = function(prompt_bufnr)
              for i = 1, 10 do
                actions.move_selection_previous(prompt_bufnr)
              end
            end,
            ["<C-d>"] = function(prompt_bufnr)
              for i = 1, 10 do
                actions.move_selection_next(prompt_bufnr)
              end
            end,
          },
        },
      }

      -- 3. Setup ve Load işlemleri
      telescope.setup(opts)

      -- Hata vermesin diye pcall içine alıyoruz
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "file_browser")
    end,
  },
}
