When the option OutDec is not `.`, put numbers in `\text`. See #348.\
\<\<\>\>= options(OutDec = ',') @\
This is the first test. abc def\
another test $a = \Sexpr{0.6}$.\
and the last one $a = \Sexpr{'0.6'}$.\
\<\<\>\>= options(OutDec = '.') @\
This is the first test. abc def\
another test $a = \Sexpr{0.6}$.\
and the last one $a = \Sexpr{'0.6'}$.
