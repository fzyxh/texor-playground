``` {r setup,include=FALSE}
knitr::opts_chunk$set(warning = FALSE)
```

``` {r }
options(OutDec = ',')
```

``` {r }
options(OutDec = '.')
```

``` {r test}
# Define the cars vector with 5 values
cars <- c(1, 3, 6, 4, 9)
plot(cars, type="o", col="blue")
title(main="Autos", col.main="red", font.main=4)
```

``` {r image}
library(Matrix)
data(CAex, package = "Matrix")
print(image(CAex, main = "image(CAex)")) # print(.) needed for Sweave
```
