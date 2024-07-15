function Math(el)
    print("Math Element Type: " .. el.mathtype)
    print("Math Content: " .. el.text)
    print("-------------------------------------------------------------------")
    if el.mathtype == "DisplayMath" then
        print("This is a display math environment.")
        return el
    end
end