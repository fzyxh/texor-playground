-- A sample custom reader that just remove latex header and footer.


-- For better performance we put these functions in local variables:
local P, S, R, Cf, Cc, Ct, V, Cs, Cg, Cb, B, C, Cmt =
  lpeg.P, lpeg.S, lpeg.R, lpeg.Cf, lpeg.Cc, lpeg.Ct, lpeg.V,
  lpeg.Cs, lpeg.Cg, lpeg.Cb, lpeg.B, lpeg.C, lpeg.Cmt

local whitespacechar = S(" \t\r\n")
local spacechar = S(" \t")
local newline = P"\r"^-1 * P"\n"
local blankline = spacechar^0 * newline
local sexprbegin = P("\\Sexpr{")
local sexprend = P("}")

-- Grammar
G = P{ "Pandoc",
    Pandoc = Ct(V"Block"^0) / pandoc.Pandoc;
    Block = blankline^0
    * ( V"Sexpr"
      + V"Para");
    Para = P(P(1) - sexprbegin)^1
    * newline^0
    / function(text)
        return pandoc.RawBlock("latex", text)
      end;
    Sexpr = sexprbegin
            * C((P(1) - (sexprend))^0)
            * sexprend
            / function(inlinecode)
                return pandoc.RawInline("latex", "`r " .. inlinecode .. "`") -- does not work because it insert newline
              end;
}


function Reader(input, reader_options)
    return lpeg.match(G, tostring(input))
end