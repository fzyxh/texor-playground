local P, S, R, Cf, Cc, Ct, V, Cs, Cg, Cb, B, C, Cmt =
  lpeg.P, lpeg.S, lpeg.R, lpeg.Cf, lpeg.Cc, lpeg.Ct, lpeg.V,
  lpeg.Cs, lpeg.Cg, lpeg.Cb, lpeg.B, lpeg.C, lpeg.Cmt

local whitespacechar = S(" \t\r\n")
local spacechar = S(" \t")
local newline = P"\r"^-1 * P"\n"
local blankline = spacechar^0 * newline
local codeblockstart = P"<<"
                        * spacechar^0
                        * C((P(1) - P(spacechar^0 * P">>="))^0)
                        * spacechar^0
                        * ">>="

-- Grammar
G = P{ "Pandoc",
    Pandoc = Ct(V"Block"^0) / pandoc.Pandoc;
    Block = blankline^0
          * ( V"CodeBlock"
            + V"Para");
    Para = P(P(1) - codeblockstart)^1
            * newline^0
            / function(text)
              return pandoc.RawBlock("latex", text)
            end;
    CodeBlock = codeblockstart
                * blankline
                * C((1 - (newline * P"@"))^0)
                * newline
                * P"@"
                / function(attributes, code)
                  return pandoc.RawBlock("latex", "\\Rcodeplaceholder{}")
                  -- local new_block = pandoc.Div({pandoc.Para("")}, {class = "RCodeChunk"})
                  -- return new_block
                end;
}


function Reader(input, reader_options)
    return lpeg.match(G, tostring(input))
end