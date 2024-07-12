equation_counter =1
function Math(el)
    if el.mathtype == "DisplayMath" then
        if el.text:match('\\#eq:')  then
            -- skip equation numbering for equations with dedicated labels,
            -- but also add them to the tally of equation
            equation_counter = equation_counter + 1
            return {pandoc.Str("\n"),el,pandoc.Str("\n")}
        elseif el.text:match('\\nonumber') then
              -- skip numbering equations with \nonumber
              return {pandoc.Str("\n"),el,pandoc.Str("\n")}
        else
            local text = pandoc.utils.stringify(el.text)
            -- insert a label to invoke numbering.
            html_label = "eq:".. tostring(equation_counter)
            --el.text = [[\label{eq:}]] .. tostring(equation_counter) .. [[}]] .. text
            el.text = text .. [[   (\#]] .. html_label .. [[)]]
            equation_counter = equation_counter + 1
        end
        return {pandoc.Str("\n"),el,pandoc.Str("\n")}
        --return el
    else
        return el
    end
end
