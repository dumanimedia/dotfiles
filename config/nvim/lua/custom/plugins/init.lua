-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      -- Configuration options
      size = 20,
      open_mapping = [[<C-/>]], -- Ctrl + /
      shade_terminals = true,
      shading_factor = 2,
      direction = 'float', -- or 'horizontal', 'vertical', 'tab'
      float_opts = {
        border = 'curved',
        winblend = 3,
      },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      -- Optional: make a function to toggle easily
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }

      function _lazygit_toggle()
        lazygit:toggle()
      end

      -- Example keymap for lazygit toggle
      vim.keymap.set('n', '<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', { desc = 'Toggle LazyGit' })
    end,
  },

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<leader>bd', '<cmd>bdelete<cr>', desc = 'Delete Current Buffer' },
    },
    opts = {
      options = {
        mode = 'buffers',
        themable = true,
        numbers = 'none',
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        indicator = {
          icon = '▎',
          style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        separator_style = 'thin',
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)

      -- 🪄 Update bufferline automatically after buffer add/delete
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.defer_fn(function()
            local ok, bufferline = pcall(require, 'bufferline')
            if ok then
              bufferline.setup(opts)
            end
          end, 20)
        end,
      })
    end,
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    -- stylua: ignore
    -- keys = {
    --     { "<leader>sn", "", desc = "+noice"},
    --     { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    --     { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    --     { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    --     { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    --     { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    --     { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    --     { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    --     { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    -- },
    config = function(_, opts)
        -- HACK: noice shows messages from before it was enabled,
        -- but this is not ideal when Lazy is installing plugins,
        -- so clear the messages in this case.
        if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
        end
        require("noice").setup(opts)
    end,
  },

  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for icons
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      -- Header (ASCII art or text)
      dashboard.section.header.val = {
        '██████╗ ██╗   ██╗███╗   ███╗ █████╗ ███╗   ██╗██╗',
        '██╔══██╗██║   ██║████╗ ████║██╔══██╗████╗  ██║██║',
        '██║  ██║██║   ██║██╔████╔██║███████║██╔██╗ ██║██║',
        '██║  ██║██║   ██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║',
        '██████╔╝╚██████╔╝██║ ╚═╝ ██║██║  ██║██║ ╚████║██║',
        '╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝',
        '                                                 ',
        '     ███╗   ███╗███████╗██████╗ ██╗ █████╗       ',
        '     ████╗ ████║██╔════╝██╔══██╗██║██╔══██╗      ',
        '     ██╔████╔██║█████╗  ██║  ██║██║███████║      ',
        '     ██║╚██╔╝██║██╔══╝  ██║  ██║██║██╔══██║      ',
        '     ██║ ╚═╝ ██║███████╗██████╔╝██║██║  ██║      ',
        '     ╚═╝     ╚═╝╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝      ',
      }

      -- Menu buttons
      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('r', '  Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button("s", "  Restore session", ":Telescope session-lens search_session<CR>"),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      -- Footer
      dashboard.section.footer.val = {
        '🚀 DUMANI MEDIA — powered by Neovim ✨',
      }

      -- Layout setup
      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)
    end,
  },

{
    "rmagatti/auto-session",
    version = "*", -- latest stable (or use commit = "<hash>" if needed)
    lazy = false,
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
      })
    end,
  },
  {
    "rmagatti/session-lens",
    commit = "main", -- optionally specify a known good commit hash if errors persist
    dependencies = {
      "rmagatti/auto-session",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      -- Safe setup call
      local ok, session_lens = pcall(require, "session-lens")
      if ok then
        session_lens.setup({
          path_display = { "shorten" },
          theme_conf = { border = true },
          previewer = false,
        })
        require("telescope").load_extension("session-lens")
        vim.keymap.set(
          "n",
          "<leader>ss",
          "<cmd>Telescope session-lens search_session<CR>",
          { desc = "Search sessions" }
        )
      else
        vim.notify("Session-lens failed to load", vim.log.levels.WARN)
      end
    end,
  },

}