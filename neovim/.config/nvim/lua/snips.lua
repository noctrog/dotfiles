local ls = require'luasnip'
local s = ls.s   -- snippet
local sn = ls.sn -- snippet node
local t = ls.t   -- text node
local i = ls.i   -- insert node
local f = ls.f   -- function node
local c = ls.c   -- choice node
local d = ls.d   -- dynamic node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda

-- Luasnip options
require'luasnip.config'.set_config({
        history = true,
        updateevents = 'TextChangedI',
        enable_autosnippets = true
})

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
        return args[1]
end

local function char_count_same(c1, c2)
        local line = vim.api.nvim_get_current_line()
        local _, ct1 = string.gsub(line, c1, '')
        local _, ct2 = string.gsub(line, c2, '')
        return ct1 == ct2
end

local function even_count(c)
        local line = vim.api.nvim_get_current_line()
        local _, ct = string.gsub(line, c, '')
        return ct % 2 == 0
end

local function neg(fn, ...)
        return not fn(...)
end

local function jdocsnip(args, old_state)
        local nodes = {
                t({"/**"," * "}),
                old_state and i(1, old_state.descr:get_text()) or i(1, {"A short Description"}),
                t({"", ""})
        }

        -- These will be merged with the snippet; that way, should the snippet be updated,
        -- some user input eg. text can be referred to in the new snippet.
        local param_nodes = {
                descr = nodes[2]
        }

        -- At least one param.
        if string.find(args[2][1], " ") then
                vim.list_extend(nodes, {t({" * ", ""})})
        end

        local insert = 2
        for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
                -- Get actual name parameter.
                arg = vim.split(arg, " ", true)[2]
                if arg then
                        arg = arg:gsub(",", "")
                        local inode
                        -- if there was some text in this parameter, use it as static_text for this new snippet.
                        if old_state and old_state["arg"..arg] then
                                inode = i(insert, old_state["arg"..arg]:get_text())
                        else
                                inode = i(insert)
                        end
                        vim.list_extend(nodes, {t({" * @param "..arg.." "}), inode, t({"", ""})})
                        param_nodes["arg"..arg] = inode

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

                vim.list_extend(nodes, {t({" * ", " * @return "}), inode, t({"", ""})})
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
                vim.list_extend(nodes, {t({" * ", " * @throws "..exc.." "}), ins, t({"", ""})})
                param_nodes.ex = ins
                insert = insert + 1
        end

        vim.list_extend(nodes, {t({" */"})})

        local snip = sn(nil, nodes)
        -- Error on attempting overwrite.
        snip.old_state = param_nodes
        return snip
end

local function capture_insert(args, _, capture_indx, pre_text, post_text)
        print(capture_indx)
        return sn(nil, {i(1, {(pre_text or "") .. args[1].captures[capture_indx] .. (post_text or "")})})
end

local function copy_insert(args, _, indx, pre_text, post_text)
        return sn(nil, {i(1, {(pre_text or "") .. args[indx][1] .. (post_text or "")})})
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, command)
        local file = io.popen(command, "r")
        local res = {}
        for line in file:lines() do
                table.insert(res, line)
        end
        return res
end

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
        local fmt = fmt or "%Y-%m-%d"
        return sn(nil, i(1, os.date(fmt)))
end

ls.snippets = {
        all = {
                -- Date and time snippets
                s("date", d(1, date_input, {}, nil)),
                s("time", d(1, date_input, {}, "%H:%M")),
                s("datetime", d(1, date_input, {}, "%Y-%m-%d %H:%M")),
                -- Use a function to execute any shell command and print it as text.
                s("bashls", f(bash, {}, "ls")),
                s("part", p(os.date, "%Y")),
        },
        java = {
                s({trig="fn"}, {
                        d(6, jdocsnip, {user_args = {2, 4, 5}}), t({"", ""}),
                        c(1, {
                                t({"public "}),
                                t({"private "})
                        }),
                        c(2, {
                                t({"void"}),
                                i(nil, {""}),
                                t({"String"}),
                                t({"char"}),
                                t({"int"}),
                                t({"double"}),
                                t({"boolean"}),
                        }),
                        t({" "}),
                        i(3, {"myFunc"}),
                        t({"("}), i(4), t({")"}),
                        c(5, {
                                t({""}),
                                sn(nil, {
                                        t({""," throws "}),
                                        i(1)
                                })
                        }),
                        t({" {", "\t"}),
                        i(0),
                        t({"", "}"})
                })
        },
        lua = {
                s({trig="if", wordTrig=true}, {
                        t({"if "}),
                        i(1),
                        t({" then", "\t"}),
                        i(0),
                        t({"", "end"})
                }),
                s({trig="ee", wordTrig=true}, {
                        t({"else", "\t"}),
                        i(0),
                })
        },
        tex = {
                ls.parser.parse_snippet({trig = ";"}, "\\$$1\\$$0"),
                s({trig = "(s*)sec", wordTrig = true, regTrig = true}, {
                        f(function(args) return {"\\"..string.rep("sub", string.len(args[1].captures[1]))} end, {}),
                        t({"section{"}), i(1), t({"}", ""}), i(0)
                }),
                ls.parser.parse_snippet({trig = "beg", wordTrig = true}, "\\begin{$1}\n\t$2\n\\end{$1}"),
                ls.parser.parse_snippet({trig = "beq", wordTrig = true}, "\\begin{equation*}\n\t$1\n\\end{equation*}"),
                ls.parser.parse_snippet({trig = "bal", wordTrig = true}, "\\begin{aligned}\n\t$1\n\\end{aligned}"),
                ls.parser.parse_snippet({trig = "ab", wordTrig = true}, "\\langle $1 \\rangle"),
                ls.parser.parse_snippet({trig = "lra", wordTrig = true}, "\\leftrightarrow"),
                ls.parser.parse_snippet({trig = "Lra", wordTrig = true}, "\\Leftrightarrow"),
                ls.parser.parse_snippet({trig = "fr", wordTrig = true}, "\\frac{$1}{$2}"),
                ls.parser.parse_snippet({trig = "tr", wordTrig = true}, "\\item $1"),
                ls.parser.parse_snippet({trig = "abs", wordTrig = true}, "\\|$1\\|"),
                s({trig = "ls"}, {
                        t({"\\begin{itemize}",
                        "\t\\item "}), i(1), d(2, rec_ls, {}),
                        t({"", "\\end{itemize}"}), i(0)
                })
        },
        c = {
                -- include snippets
                s("inc", {
                        t("#include \""),
                        i(1, "stdio.h"),
                        t("\""), i(0)
                }),
                s("incs", {
                        t("#include <"),
                        i(1, "stdio.h"),
                        t(">"), i(0)
                }),
                -- if, if else
                s("if", {
                        c(1, {
                                sn(nil, { -- without brackets
                                t("if ("),
                                i(1, "condition"),
                                t({ ")", "\t" }),
                                i(2, "consequent"),
                                t({"", ""}) }),
                                sn(nil, { -- with brackets
                                t("if ("),
                                i(1, "condition"),
                                t({ ") {", "\t" }),
                                i(2, "consequent"),
                                t({"", "}", ""})})
                        }),
                        i(0)
                }),
                s("ifel", {
                        t("if ("),
                        i(1, "condition"),
                        t({ ") {", "\t" }),
                        i(2, "consequent"),
                        t({"", "} else {", "\t"}),
                        i(3, "alternative"),
                        t({ "", "}", "" }),
                        i(0),
                }),
                -- functions
                s("main", {
                        t({ "int main (" }),
                        i(1, "int argc, char* arcv[]"),
                        t({")", "{", "\t"}),
                        i(0),
                        t({"", "}"})
                }),
        },
        cpp = {
                -- include snippets
                s("inc", {
                        t("#include \""),
                        i(1, "stdio.h"),
                        t("\""), i(0)
                }),
                s("incs", {
                        t("#include <"),
                        i(1, "stdio.h"),
                        t(">"), i(0)
                }),
                -- if, if else
                s("if", {
                        c(1, {
                                sn(nil, { -- without brackets
                                t("if ("),
                                i(1, "condition"),
                                t({ ")", "\t" }),
                                i(2, "consequent"),
                                t({"", ""}) }),
                                sn(nil, { -- with brackets
                                t("if ("),
                                i(1, "condition"),
                                t({ ") {", "\t" }),
                                i(2, "consequent"),
                                t({"", "}", ""})})
                        }),
                        i(0)
                }),
                s("ifel", {
                        t("if ("),
                        i(1, "condition"),
                        t({ ") {", "\t" }),
                        i(2, "consequent"),
                        t({"", "} else {", "\t"}),
                        i(3, "alternative"),
                        t({ "", "}", "" }),
                        i(0),
                }),
                -- functions
                s("main", {
                        t({ "int main (" }),
                        i(1, "int argc, char* arcv[]"),
                        t({")", "{", "\t"}),
                        i(0),
                        t({"", "}"})
                }),
                ls.parser.parse_snippet({trig = "if", wordTrig = true}, "if ($1)\n\t$2\n$0"),
                ls.parser.parse_snippet({trig = "for", wordTrig = true}, "for ($1 : $2)\n\t$3\n$0"),
                -- s({trig = "for(%w+)", wordTrig = true, regTrig = true}, {
                --         t({"for ("}), d(1, capture_insert, {}, 1, "int ", " = 0"), t({"; "}),
                --         f(function(args) return {args[1].captures[1]} end, {}), c(2, {sn(nil, {t({" != "}), i(1)}), i(nil)}), t({"; "}),
                --         d(3, capture_insert, {}, 1, "++"), t({")", "\t"}), i(4), t({"", ""}), i(0)
                -- })
        }
}
-- 
-- -- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
-- ls.autosnippets = {
	-- all = {
		-- s("autotrigger", {
			-- t("autosnippet"),
		-- }),
	-- },
-- }

-- Load VSCode-like snippets
require("luasnip/loaders/from_vscode").load({ paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" } })                                                                                                                   
