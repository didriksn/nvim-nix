local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

-- other imports
local tex = require("luasnip_helpers.latex.tex")
local utils = require("luasnip_helpers.latex.utils")
local tsnip = tex.tsnip
local msnip = tex.msnip

M = {
  autosnippet({ trig = "(%s)(.-)/", name = "fraction", regTrig = true, wordTrig = false, hidden = true },
    fmta(
    [[
      <>\frac{<>}{<>}<>
    ]],
    {
      f(function(_, snip) return snip.captures[1] end),
      f(function(_, snip) return snip.captures[2] end),
      i(1),
      i(0)
    }),
  { condition = tex.in_math, show_condition = tex.in_math }),
  autosnippet({ trig = "ft", name = "fraction teller" },
    fmta(
    [[
      \frac{<>}{<>}<>
    ]],
    {
      d(2, utils.get_visual),
      i(1),
      i(0)
    }),
  { condition = tex.in_math, show_condition = tex.in_math }),
  autosnippet({ trig = "fn", name = "fraction nevner" },
    fmta(
    [[
      \frac{<>}{<>}<>
    ]],
    {
      i(1),
      d(2, utils.get_visual),
      i(0)
    }),
  { condition = tex.in_math, show_condition = tex.in_math }),
  msnip({ trig = "ff", name = "fraction" }, [[\frac{$1}{$2}]])
}

return M
