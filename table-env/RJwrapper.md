---
abstract: |
  This is a small sample article to demonstrate usage of
  [**texor**](https://CRAN.R-project.org/package=texor) to convert table
  environments.
address: |
  Abhishek Ulayil\
  Student, Institute of Actuaries of India\
  Mumbai, India\
  ORCiD: 0009-0000-6935-8690\
author:
- by Abhishek Ulayil
title: Working with table environments in texor
---

::: article
# Introduction

Tables are commonly used in R Journal articles to display data in a
tabular format. However, there are differences in the way tables are
handled by LaTeX and HTML. LaTeX tables have more customization and are
usually optimized for printing, whereas the web articles need tables
optimized for varying sizes of media. Pandoc converts most of the tables
somewhat easily, but is unable to do well with table customization
packages and complex tables. The
[**texor**](https://CRAN.R-project.org/package=texor) packages uses the
pandoc extensions `simple_tables` and `pipe_tables` to tackle these
difficult cases.

# Simple tables

A simple table has $n$ rows and $p$ columns leading to $np$ cells.
Simple LaTeX tables will be converted just fine, even if they include a
some math and other elements. However, note that the conversion will be
done to traditional or pandoc-style markdown rather than R Markdown with
the `knitr::kable(..)` function. Also any graphic commands or specific
font characters will not be supported.

::: {#table:1}
```{r table-1, echo = FALSE, results = 'asis'}
table_1_data <- read.csv("table_data_1.csv")
knitr::kable(table_1_data, caption=" Image format support in various markup/typesetting languages.")
```
:::

# Multicolumn and Multirow tables

::: center
::: {#table:2}
  -------------------------------------
  EXAMPLE   $X$           $Y$    
  --------- ------ ------ ------ ------
            1      2      1      2

  EX1       X11    X12    Y11    Y12

  EX2       X21    X22    Y21    Y22

  EX3       X31    X32    Y31    Y32

            X311   X322   Y311   Y322

  EX4       X41    X42    Y41    Y42

            X411   X422   Y411   Y422

  EX5       X51    X52    Y51    Y52
  -------------------------------------

  : Table 2: An example table using `multicolumn` and `multirow`
:::
:::

Table [2](#table:2) illustrates a table that uses the `multicolumn` and
`multirow` command, which the
[**texor**](https://CRAN.R-project.org/package=texor) package can handle
through subroutines and pre-processing steps to transform the LaTeX
code.

Also note that the stream editor is used to rename `table*` environment
to `table` environment because the HTML format is single column, so the
asterisk indicating that the table should be drawn over the full width
of the page is redundant in this case.

# Complex tables

A complex table with various other elements like figures, math, code and
so on, are also supported by
[**texor**](https://CRAN.R-project.org/package=texor).

::: {#table:3}
+---------------+---------------+-------------+---------------------+
| Inline Format | LaTeX Support | Web Support | Rendering           |
+:==============+:==============+:============+:====================+
| Text          | Yes           | Yes         | *Hello*             |
+---------------+---------------+-------------+---------------------+
| Image         | Yes           | Yes         | ![image](Rlogo-     |
|               |               |             | 5.png){width="100%" |
|               |               |             | alt="graphic        |
|               |               |             |  without alt text"} |
+---------------+---------------+-------------+---------------------+
| CodeBlock     | Yes           | Yes         | ``` r               |
|               |               |             | x <- 1:100          |
|               |               |             | y <- dbino          |
|               |               |             | m(x,100,prob = 0.5) |
|               |               |             | plot(x,y)           |
|               |               |             | ```                 |
+---------------+---------------+-------------+---------------------+
| Math          | Yes           | Yes         | $e = m c^2$         |
+---------------+---------------+-------------+---------------------+
| Link          | Yes           | Yes         | [Google](htt        |
|               |               |             | p://www.google.com) |
+---------------+---------------+-------------+---------------------+
| Nested Table  | Yes           | No          | NaN                 |
+---------------+---------------+-------------+---------------------+

: Table 3: Image format support in various markup/typesetting languages
:::

# Wide tables

As for the inclusion of wide tables, they are represented as multiple
tables with the first table housing the caption at the top. The
numbering and references will be the same as LaTeX.

Here is a reference to Table [4](#table:4) and Table [5](#table:5).

::: {#table:4}
  -----------------------------------------------------------------------
  index   A        B        C         D      E       F      G      H
  ------- -------- -------- --------- ------ ------- ------ ------ ------
  1       359.00   NaN      5796.00   0.00   16.14   1.00   NaN    0.00

  2       25.73    0.00     1029.20   NaN    40.00   0.68   0.00   0.00

  2.1     26.26    0.00     13.40     0.00   2.14    0.68   0.00   NaN

  2.2     32.06    20.06    47.64     0.04   1.80    0.68   0.01   NaN

  2.3     51.94    420.27   21.17     0.20   1.77    0.74   0.05   NaN

  2.4     40.62    30.44    0.90      0.57   1.44    1.31   0.24   NaN

          ...      ...      ...       ...    ...     ...    ...    ...
  -----------------------------------------------------------------------

  : Table 4: `A dummy research data`
:::

::: {#table:4}
  ---------------------------------------------------------------------------------------------------
  index   I      J                           K      L      M      N      O
  ------- ------ --------------------------- ------ ------ ------ ------ ----------------------------
  1       0.00   $-$`<!-- -->`{=html}1.73    0.00   0.00   0.00   0.00   NaN

  2       0.21   $-$`<!-- -->`{=html}33.41   0.00   0.11   0.00   NaN    $-$`<!-- -->`{=html}197.85

  2.1     0.24   $-$`<!-- -->`{=html}24.00   0.00   0.15   NaN    0.06   $-$`<!-- -->`{=html}70.46

  2.2     0.6    $-$`<!-- -->`{=html}19.42   0.00   0.15   0.00   0.11   $-$`<!-- -->`{=html}16.48

  2.3     0.75   $-$ 31.77                   0.00   0.18   0.01   0.37   $-$`<!-- -->`{=html}0.82

  2.4     0.26   $-$`<!-- -->`{=html}1.89    0.1    0.55   0.70   0.22   $-$`<!-- -->`{=html}6.55

          ...    ...                         ...    ...    ...    ...    ...
  ---------------------------------------------------------------------------------------------------

  : 
:::

::: {#table:5}
  --------------------------------------------------------------------------------------------------
  Package                                                         Commits     Version   Last Updated
  --------------------------------------------------------------- --------- --------- --------------
  [**texor**](https://CRAN.R-project.org/package=texor)           260           1.1.0    28-Jul-2023

  [**rebib**](https://CRAN.R-project.org/package=rebib)           76            0.2.4    29-Jul-2023

  [**rjtools**](https://CRAN.R-project.org/package=rjtools)       314          1.0.11    30-Jul-2023

  [**rmarkdown**](https://CRAN.R-project.org/package=rmarkdown)   3189           2.23    31-Jul-2023
  --------------------------------------------------------------------------------------------------

  : Table 5: A dummy summary of a few CRAN packages
:::

# Long Tables

Pandoc supports long tables from **longtable** CTAN package as well,
here is an example as table [6](#table:6).

::: {#table:6}
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Manafacturer**   **Model and Make**   **MPG**   **Engine Cylinders**   **Engine Displacement (cu.in.)**   **Weight (1000 lbs)**   **Number of forward gears**
  ------------------ -------------------- --------- ---------------------- ---------------------------------- ----------------------- -----------------------------
  Mazda              RX4                  21.0      6                      160.0                              2.620                   4

  Mazda              RX4 Wag              21.0      6                      160.0                              2.875                   4

  Datsun             710                  22.8      4                      108.0                              2.320                   4

  Hornet             4 Drive              21.4      6                      258.0                              3.215                   3

  Hornet             Sportabout           18.7      8                      360.0                              3.440                   3

  Plymouth           Valiant              18.1      6                      225.0                              3.460                   3

  Duster             360                  14.3      8                      360.0                              3.570                   3

  Merc               240D                 24.4      4                      146.7                              3.190                   4

  Merc               230                  22.8      4                      140.8                              3.150                   4

  Merc               280                  19.2      6                      167.6                              3.440                   4

  Merc               280C                 17.8      6                      167.6                              3.440                   4

  Merc               450SE                16.4      8                      275.8                              4.070                   3

  Merc               450SL                17.3      8                      275.8                              3.730                   3

  Merc               450SLC               15.2      8                      275.8                              3.780                   3

  Cadillac           Fleetwood            10.4      8                      472.0                              5.250                   3

  Lincoln            Continental          10.4      8                      460.0                              5.424                   3

  Chrysler           Imperial             14.7      8                      440.0                              5.345                   3

  Fiat               128                  32.4      4                      78.7                               2.200                   4

  Honda              Civic                30.4      4                      75.7                               1.615                   4

  Toyota             Corolla              33.9      4                      71.1                               1.835                   4

  Toyota             Corona               21.5      4                      120.1                              2.465                   3

  Dodge              Challenger           15.5      8                      318.0                              3.520                   3

  AMC                Javelin              15.2      8                      304.0                              3.435                   3

  Cheverolet         Camaro Z28           13.3      8                      350.0                              3.840                   3

  Pontiac            Firebird             19.2      8                      400.0                              3.845                   3

  Fiat               X1-9                 27.3      4                      79.0                               1.935                   4

  Porsche            914-2                26.0      4                      120.3                              2.140                   5

  Lotus              Europa               30.4      4                      95.1                               1.513                   5

  Ford               Pantera L            15.8      8                      351.0                              73.170                  5

  Ferrari            Dino                 19.7      6                      145.0                              2.770                   5

  Maserati           Bora                 15.0      8                      301.0                              3.570                   5

  Volvo              142E                 21.4      4                      121.0                              2.780                   4
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------

  : Table 6: Table of Car data from mtcars dataset
:::

# Limitations

Limitations of the [**texor**](https://CRAN.R-project.org/package=texor)
package in table handling includes:

-   Usage of custom graphics/ characters like `\circ` will not render in
    HTML properly,(using it in inline math might work).

-   Inclusion of code blocks might not always work and it is best
    avoided.

-   Currently only `\\` is supported as the row end command/marker.

-   Some table commands/environments might not work as expected.

-   Nested tabular environments will not work as expected.

-   Colored backgrounds in tables are not supported yet.

# Summary

In summary the [**texor**](https://CRAN.R-project.org/package=texor)
package supports:

-   Some common table environments.

-   Long and Wide Tables.

-   Some tables with `multicolumn` and `multirow` commands.

-   Environments such as `figure`/`code` in tables.

# Acknowledgements

Special thanks to Albert Krewinkel for his contributions towards earlier
versions of Lua filters to add table numbering.
:::
