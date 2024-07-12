# playground for R package [`texor`](https://github.com/Abhi-1U/texor)

## 1

Now `test_texor/test_codes.Rnw` and `matrix_comparisons/Comparisons.Rnw` can be converted to R Markdown.

```r
library(devtools)
setwd("path/to/fzyxh/texor")
load_all()
setwd("path/to/texor-playground/test_texor")
input_file <- "path/to/texor-playground/test_texor/test_codes.Rnw"
rnw_to_rmd(input_file)
```

## 2

To test autonumber, use `equation_number/Comparisons.Rnw` with commands:

```r
library(devtools)
setwd("path/to/fzyxh/texor")
load_all()
setwd("path/to/fzyxh/texor-playground/equation_number")
input_file <- "path/to/fzyxh/texor-playground/equation_number/Comparisons.Rnw"
rnw_to_rmd(input_file, clean_up = TRUE, autonumber_eq = TRUE)
```

To compare with HTML output, using:

```r
library(devtools)
setwd("path/to/fzyxh/texor")
load_all()
setwd("path/to/fzyxh/texor-playground/equation_number")
input_file <- "path/to/fzyxh/texor-playground/equation_number/Comparisons.Rnw"
rnw_to_rmd(input_file, clean_up = TRUE)
```