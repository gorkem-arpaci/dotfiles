-- ~/.config/nvim/lua/plugins/ai-assistants.lua
-- GitHub Copilot kurulumu (macOS uyumlu kısayollar)

return {
  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>", -- Option+Enter (macOS)
        },
        layout = {
          position = "bottom",
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>", -- Tab ile kabul et (en kolay)
          accept_word = "<C-Right>", -- Ctrl+→ kelime kelime kabul
          accept_line = "<C-l>", -- Ctrl+l satır kabul
          next = "<C-]>", -- Ctrl+] sonraki öneri
          prev = "<C-[>", -- Ctrl+[ önceki öneri
          dismiss = "<C-e>", -- Ctrl+e öneriyi kapat
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    },
  },

  -- Copilot Chat (Sohbet özelliği için)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      show_help = "yes",
      prompts = {
        Explain = "Seçili kodu açıkla",
        Review = "Seçili kodu gözden geçir",
        Tests = "Seçili kod için testler yaz",
        Refactor = "Seçili kodu refactor et",
        FixCode = "Seçili koddaki hataları düzelt",
        BetterNamings = "Daha iyi değişken isimleri öner",
        Documentation = "Seçili kod için dokümantasyon yaz",
      },
    },
    keys = {
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Copilot: Açıkla" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Copilot: Test Yaz" },
      { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "Copilot: Kod İncele" },
      { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "Copilot: Refactor" },
      { "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>", desc = "Copilot: İsimlendirme" },
      { "<leader>cco", "<cmd>CopilotChatOpen<cr>", desc = "Copilot: Chat Aç" },
      { "<leader>ccq", "<cmd>CopilotChatClose<cr>", desc = "Copilot: Chat Kapat" },
    },
  },

  -- blink.cmp ile Copilot entegrasyonu
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },

  -- Copilot için blink.cmp source
  {
    "giuxtaposition/blink-cmp-copilot",
    dependencies = { "zbirenbaum/copilot.lua" },
  },
}
