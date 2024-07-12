function is_math(elem)
    return elem.t == "Math" and elem.mathtype == "DisplayMath"
  end
  
  function filter_math_blocks(blocks)
    local math_blocks = {}
    for _, block in ipairs(blocks) do
      if is_math(block) then
        table.insert(math_blocks, block)
      elseif block.t == "Para" then
        for _, inline in ipairs(block.c) do
          if is_math(inline) then
            print(inline.text)
            table.insert(math_blocks, inline)
          end
        end
      end
    end
    return math_blocks
  end
  
  function Pandoc(doc)
    return pandoc.Pandoc(filter_math_blocks(doc.blocks), doc.meta)
  end
  