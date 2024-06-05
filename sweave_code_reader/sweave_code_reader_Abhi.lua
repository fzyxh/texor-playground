
-- For better performance we put these functions in local variables:
local P, S, R, Cf, Cc, Ct, V, Cs, Cg, Cb, B, C, Cmt, Cp =
  lpeg.P, lpeg.S, lpeg.R, lpeg.Cf, lpeg.Cc, lpeg.Ct, lpeg.V,
  lpeg.Cs, lpeg.Cg, lpeg.Cb, lpeg.B, lpeg.C, lpeg.Cmt, lpeg.Cp

local whitespacechar = S(" \t\r\n")
local wordchar = (1 - whitespacechar)
local spacechar = S(" \t")
local newline = P"\r"^-1 * P"\n"
local blankline = spacechar^0 * newline
local codeblockstart = P"<<"
                        * spacechar^0 -- Ignore spaces
                        * C((P(1) - P(spacechar^0 * P">>="))^0) -- Capture attributes between << and >>=
                        * spacechar^0 -- Ignore spaces
                        * ">>="
local enddocument = P"\\z"

-- Grammar
G = P{ "Pandoc",
    Pandoc = Ct(V"Block"^0) / pandoc.Pandoc;
    Block = blankline^0 * ( V"CodeBlock" + V"NonCodeBlock");
    CodeBlock = codeblockstart
                * blankline
                * C((1 - (newline * P"@"))^0) -- Capture codes between << >>= and @
                * newline
                * P"@"
                / function(attributes, code) -- Return a CodeBlock with the captured attributes and codes
                    return pandoc.CodeBlock(code, {"r", attributes})
                  end;
    NonCodeBlock = --P(1 - V"CodeBlock")^1 -- A faulty Expression to capture parts of doc other than codeblock (needs work) 
              P(1)^1   -- captures everything (currently works as a proof of concept) / CodeBlock is Ignored in this case.
              / function(text)
              -- debug steps to get the capture contents into a file
              file = io.open("Capture.txt", "w") 
              file:write(text)
              file:close()
              -- treat the captured text as normal LaTeX
              local doc = pandoc.read(text,"latex")
              return pandoc.Para(pandoc.utils.blocks_to_inlines(doc.blocks)) 
             end;
}


function Reader(input, reader_options)
    return lpeg.match(G, tostring(input))
end