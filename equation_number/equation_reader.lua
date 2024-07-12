local lpeg = require 'lpeg'
local P, R, S, C, Ct = lpeg.P, lpeg.R, lpeg.S, lpeg.C, lpeg.Ct

-- Patterns for LaTeX environments
local newline = P("\r")^-1 * P("\n")
local spacechar = S(" \t")
local math_environments = {
  "equation*",
  "align*",
  "gather*"
}

local begin_env = P("\\begin{") * C(R("az", "az")^1 * P("*")^-1) * P("}")
local end_env = P("\\end{") * C(R("az", "az")^1 * P("*")^-1) * P("}")
local math_env_content = (P(1) - end_env)^0
local math_env = Ct(begin_env * newline^0 * C(math_env_content) * newline^0 * end_env)

-- Add \nolabel to specified environments with *
local function add_nolabel(env_name, content)
  for _, math_env in ipairs(math_environments) do
    if env_name == math_env then
      return "\\begin{" .. env_name .. "}\n" .. content .. "\n\\nolabel\n\\end{" .. env_name .. "}"
    end
  end
  return "\\begin{" .. env_name .. "}\n" .. content .. "\n\\end{" .. env_name .. "}"
end

-- Grammar
G = Ct((math_env / function(env)
    return add_nolabel(env[1], env[2])
  end + (P(1) - math_env)^0))

-- Reader function
function Reader(input, reader_options)
  local input_str = pandoc.utils.stringify(input)  -- Convert input to string
  local result = lpeg.match(G, input_str)
  return pandoc.read(result, 'latex')
end
