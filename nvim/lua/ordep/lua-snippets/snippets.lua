local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority
    ext_prio_increase = 1
})

local function copy(args)
    return args[1]
end

-- complicated function for dynamicNode. This function was copied from
-- [https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L167]
local function jdocsnip(args, _, old_state)
    -- !!! old_state is used to preserve user-input here. DON'T DO IT THAT AWAY
    -- Using a restoreNode instead is much easier
    -- View this onlu as an example on how old_state functions.
    local nodes = {
        t({ "/**", " * " }),
        i(1, "A short Description"),
        t({ "", "" })
    }

    -- These will be merged with the snippet; that way, should the snippet be
    -- updated, some user input eg. text can be referred to in the new snippet
    local param_nodes = {}

    if old_state then
        nodes[2] = i(1, old_state.dscr:get_text())
    end
    param_nodes.dscr = nodes[2]

    -- At least one param.
    if string.find(args[2][1], ", ") then
        vim.list_extend(nodes, { t({ " * ", "" }) })
    end

    local insert = 2

    for _, arg in ipairs(vim.split(args[2][1], ", ", true)) do
        arg = vim.split(arg, " ", true)[2]
        if arg then
            local inode
            if old_state and old_state[arg] then
                inode = i(insert, old_state["arg" .. arg]:get_text())
            else
                inode = i(insert)
            end
            vim.list_extend(
                nodes,
                { t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) }
            )
            param_nodes["arg" .. arg] = inode

            insert = insert + 1
        end
    end

    if args[1][1] ~= "void" then
        local inode
        if old_state and old_state.ret then
            inode = i(insert, old_state.ret:get_text())
        else
            inode = i(insert)
        end

        vim.list_extend(
            nodes,
            { t({ " * ", " * @return " }), inode, t({ "", "" }) }
        )
        param_nodes.ret = inode
        insert = insert + 1
    end

    if vim.tbl_count(args[3]) ~= 1 then
        local exc = string.gsub(args[3][2], " throws ", "")
        local ins
        if old_state and old_state.ex then
            ins = i(insert, old_state.ex:get_text())
        else
            ins = i(insert)
        end
        vim.list_extend(
            nodes,
            { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) }
        )
        param_nodes.ex = ins
        insert = insert + 1
    end

    vim.list_extend(nodes, { t({ " */" }) })

    local snip = sn(nil, nodes)
    -- Error on attempting overwrite
    snip.old_state = param_nodes
    return snip
end

ls.snippets = {
    all = {},
    lua = {
        s(
            {
                trig = "function ()",
                dscr = "Lua function snippet.",
                docstring = {
                    "[''|local] function [''|foo]([''|args])",
                    "\t[code]",
                    "end"
                }
            },
            {
                c(1, {
                    t(""),
                    t("local ")
                }),
                t("function "),
                i(2),
                t("("),
                i(3),
                t({ ")", "\t" }),
                i(0),
                t({ "", "end" })
            }
        ),
        s(
            {
                trig = "if",
                dscr = "Lua if statement."
            },
            {
                t("if "),
                i(1),
                t({ " then", "\t" }),
                i(0),
                t({ "", "end" })
            }
        ),
        s(
            {
                trig = "elif",
                dscr = "Lua elseif statement."
            },
            {
                t("elseif "),
                i(1),
                t({ " then", "\t" }),
                i(0)
            }
        ),
        s(
            {
                trig = "local",
                dscr = "Lua variable definition."
            },
            {
                t("local "),
                i(1),
                t(" = "),
                i(0)
            }
        ),
        s(
            {
                trig = "while",
                dscr = "Lua while loop."
            },
            {
                t("while "),
                i(1),
                t(" "),
                i(2, "<="),
                t(" "),
                i(3, "x"),
                t({ " do", "\t" }),
                i(0, "--code"),
                t({ "", "\t" }),
                f(copy, 1),
                t(" = "),
                f(copy, 1),
                t(" + 1"),
                t({ "", "end" })
            }
        ),
        s(
            {
                trig = "do",
                dscr = "Lua do block scope."
            },
            {
                t({ "do", "\t" }),
                i(0, "--code"),
                t({ "", "end" })
            }
        ),
        s(
            {
                trig = "--[[",
                dscr = "Lua comment block."
            },
            {
                t({ "--[[", "\t" }),
                i(0, "Comment lines"),
                t({ "", "--]]" })
            }
        ),
        s(
            {
                trig = "repeat",
                dscr = "Lua repeat statement."
            },
            {
                t({ "repeat", "\t" }),
                i(1, "--to repeat"),
                t({ "", "until " }),
                i(2, "to_eval"),
                t(" "),
                i(3, "~="),
                t(" "),
                i(0, "limiter")
            }
        ),
        s(
            {
                trig = "forn",
                dscr = "Lua numeric for loop."
            },
            {
                t("for "),
                i(1, "iter"),
                t(" = "),
                i(2, "from"),
                t(", "),
                i(3, "to"),
                t(", "),
                i(4, "step"),
                t({ " do", "\t" }),
                i(0, "--code"),
                t({ "", "end" })
            }
        ),
        s(
            {
                trig = "foreachp",
                dscr = "Lua generic pairs for loop"
            },
            {
                t("for "),
                i(1, "key"),
                t(" in pairs("),
                i(2, "array"),
                t({ ") do", "\t" }),
                i(0, "--code"),
                t({ "", "end" })
            }
        ),
        s(
            {
                trig = "foreachi",
                dscr = "Lua generic iparis for loop"
            },
            {
                t("for "),
                i(1, "i"),
                t(", "),
                i(2, "v"),
                t(" in ipairs("),
                i(3, "array"),
                t({ ") do", "\t" }),
                i(0, "--code"),
                t({ "", "end" })
            }
        ),
        s(
            {
                trig = "require",
                dscr = "Lua require function."
            },
            {
                t("require"),
                c(1, {
                    sn(nil, {
                        t(' "'),
                        i(1),
                        t('"')
                    }),
                    sn(nil, {
                        t('("'),
                        i(1),
                        t('")')
                    })
                }),
                i(0)
            }
        )
    },
    js = { },
    html = {
        s(
            { trig = "html5" },
            {
                t({ '<!DOCTYPE html>', '<html lang="' }),
                i(1),
                t({
                    '">',
                    "<head>",
                    '\t<meta charset="UTF-8" />',
                    "\t<title>"
                }),
                i(2),
                t({
                    "</title>",
                    '\t<meta name="viewport" content="width=device-width,' ..
                    ' initia-scale=1.0" />',
                    '\t<link rel="stylesheet" href="'
                }),
                i(3, "./style.css"),
                t({
                    '" />',
                    "</head>",
                    "<body>",
                    "\t"
                }),
                i(0),
                t({
                    "",
                    "</body>",
                    "</html>"
                })
            }
        ),
        s(
            { trig = "hn" },
            {
                t("<h"),
                c(1,
                    {
                        t("1"),
                        t("2"),
                        t("3"),
                        t("4"),
                        t("5"),
                        t("6"),
                        t("7"),
                    }
                ),
                t(">"),
                i(0),
                t( "</h" ),
                f(copy, 1),
                t(">")
            }
        ),
        s(
            {
                trig = "<>",
                dscr = "General tag"
            },
            {
                t("<"),
                i(1),
                t("></"),
                f(copy, 1),
                t(">")
            }
        ),
        s(
            {
                trig = "id"
            },
            {
                t('id="'),
                i(0),
                t('" ')
            }
        ),
        s(
            {
                trig = "class"
            },
            {
                t('class="'),
                i(0),
                t('" ')
            }
        )
    },
    java = {
        s(
            {
                trig = "func",
                dscr = "Java function."
            },
            {
                d(6, jdocsnip, { 2, 4, 5 }),
                t({ "", "" }),
                c(1, {
                    t("public "),
                    t("private "),
                }),
                c(2, {
                    t("void"),
                    t("String"),
                    t("char"),
                    t("int"),
                    t("double"),
                    t("boolean"),
                    i(nil, ""),
                }),
                t(" "),
                i(3, "funcName"),
                t("("),
                i(4),
                t(")"),
                c(5, {
                    t(""),
                    sn(nil, {
                        t({ "", " throws " }),
                        i(1)
                    })
                }),
                t({ " {", "\t" }),
                i(0, "//Code"),
                t({ "", "}" }),
            }
        )
    },
    python = { }
}
