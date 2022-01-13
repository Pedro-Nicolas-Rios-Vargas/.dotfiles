local nnoremap = vim.keymap.nnoremap

local saga = require 'lspsaga'

saga.init_lsp_saga {
    use_saga_diagnostic_sign = true,
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '';
    dianostic_header_icon  = '   ',
    code_action_icon = ' ',
    code_action_prompt = {
        enable = true,
        sign = true,
        sign_priority = 20,
        virtual_text = true,
    },
    finder_definition_icon = '  ',
    finder_reference_icon = '  ',
    max_preview_lines = 10,
    finder_action_keys = {
        open = 'o',
        vsplit = 's',
        split = 'i',
        quit = 'q',
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
    },
    code_action_keys = {
        quit = 'q',
        exec = '<CR>',
    },
    rename_action_keys = {
        quit = '<C-c>',
        exefc = '<CR>',
    },
    definition_preview_icon = '',
    -- "single" "double" "round" "plus"
    border_style = "single",
    rename_prompt_prefix = '➤',
}

-- Async Lsp Finder
nnoremap {
    "gh",
    "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>"
}

-- Actions
nnoremap {
    "<leaden>ca",
    "<cmd>lua require('lspsaga.codeaction').code_action()<CR>"
}
nnoremap {
    "<leaden>ca",
    ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>"
}

-- Hover Doc
nnoremap {
    "<leader>rh",
    "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>"
}
nnoremap {
    "<C-f>",
    "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"
}
nnoremap {
    "<C-b>",
    "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"
}

-- Signature
nnoremap {
    "gs",
    "<cmd>lua require('lspsaga.signaturehelp').signaturehelp()<CR>"
}

-- Rename/Refactor
nnoremap {
    "gr",
    "<cmd>lua require('lspsaga.rename').rename()<CR>"
}

-- Preview Def
nnoremap {
    "gd",
    "<cmd>lua require('lspsaga.provider').preview_definition()<CR>"
}

-- Jump Diagnostic
nnoremap {
    "<leader>cd",
    "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>"
}
nnoremap {
    "[e",
    "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>"
}
nnoremap {
    "]e",
    "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>"
}
