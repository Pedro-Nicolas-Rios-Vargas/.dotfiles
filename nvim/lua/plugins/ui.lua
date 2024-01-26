-- option needed for colorizer
vim.opt.termguicolors = true

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        icons_enabled = true,
        -- theme = 'catpuccin', --'gruvbox_dark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff',
          { 'diagnostics', sources = { 'nvim_diagnostic', 'coc' } } },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      debounce = 100,
      indent = {
        char = "│",
      },
      whitespace = {
        highlight = { "Whitespace", "NonText" }
      },
      scope = {
        enabled = true,
        --exclude = { language = { "lua" } },
      }
    },
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    --[[
    opts = {
      progress = {
        poll_rate = 0,
        suppress_on_insert = false,
        ignore_done_already = false,
        ignore_empty_message = false,
        clear_on_detach = function (client_id)
          local client = vim.lsp.get_client_by_id(client_id)
          return client and client.name or nil
        end,
        notification_group = function (msg)
          return msg.lsp_client.name
        end,
        ignore = {},
        display = {
          render_limit = 16,
          done_ttl = 3,
          done_icon = "✔",
          done_style = "Constant",
          progress_ttl = math.huge,
          progress_icon = { pattern = "dots", period = 1 },
          progress_style = "WarningMsg",
          group_style = "Title",
          icon_style = "Question",
          priority = 30,
          skip_history = true,
          format_message = function (msg)
            local message = msg.message
            if not message then
              message = msg.done and "Completed" or "In progress..."
            end
            if msg.percentage ~= nil then
              message = string.format("%s (%.0f%%)", message, msg.percentage)
            end
            return message
          end,
          format_annote = function (msg)
            return msg.title
          end,
          format_group_name = function (group)
            return tostring(group)
          end,
          overrides = {},
        },
        lsp = {
          progress_ringbuf_size = 0,
        },
      },
      notification = {
        poll_rate = 10,
        filter = vim.log.levels.INFO,
        history_size = 128,
        override_vim_notify = false,
        configs = {
          default = {
            annote_style = "Question",
            debug_annote = "DEBUG",
            debug_style = "Comment",
            error_annote = "ERROR",
            error_style = "ErrorMsg",
            group_style = "Title",
            icon = "❰❰",
            icon_style = "Special",
            info_annote = "INFO",
            info_style = "Question",
            name = "Notifications",
            ttl = 5,
            update_hook = function (args)
              print(args)
            end,
            warn_annote = "WARN",
            warn_style = "WarningMsg"
          },
        },
        redirect = function (msg, level, opts)
          if opts and opts.on_open then
            return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
          end
        end,
        view = {
          stack_upwards = true,
          icon_separator = " ",
          group_separator = "---",
          group_separator_hl = "Comment",
          render_message = function (msg, cnt)
            return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
          end,
        },
        window = {
          normal_hl = "Comment",
          winblend = 100,
          border = "none",
          zindex = 45,
          max_width = 0,
          max_height = 0,
          x_padding = 1,
          y_padding = 0,
          align = "bottom",
          relative = "editor",
        },
      },

      integration = {
        ["nvim-tree"] = {
          enable = true,
        },
      },
      logger = {
        level = vim.log.levels.WARN,
        float_precision = 0.01,
        path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
      },
    }
    --]]
  },
  {
    "norcalli/nvim-colorizer.lua",
    opts = {
      '*',
      html = {
        mode = 'foreground',
      }
    }
  },
}
