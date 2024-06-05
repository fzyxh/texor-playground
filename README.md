# playground for R package [`texor`](https://github.com/Abhi-1U/texor)


Now `test_texor/test_codes.Rnw` and `matrix_comparisons/Comparisons_mod.Rnw` can be converted to R Markdown.

```r
library(devtools)
setwd("path/to/fzyxh/texor")
load_all()
setwd("path/to/texor-playground/test_texor")
input_file <- "path/to/texor-playground/test_texor/test_codes.Rnw"
rnw_to_rmd(input_file)
```

Note that metadata is incorrect now because it still use which for R-Journal, not vignettes.

And for matrix_comparisons, \bibliography is ignored (rnw convert workflow does not handle it until now), and some syntax is edited to avoid some mistake (it should be considered then).