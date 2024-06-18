``` {r include=FALSE}
library(knitr)
opts_chunk$set(
engine='R',dev='pdf',fig.width=5,fig.height=3,strip.white=TRUE,tidy=FALSE
)
```

``` {r preliminaries, echo=FALSE}
options(width=75)
library(stats) # for R_DEFAULT_PACKAGES=NULL
library(utils) # ditto
```

``` {r modelMatrix}
data(Formaldehyde, package = "datasets")
str(Formaldehyde)
(m <- cbind(1, Formaldehyde$carb))
(yo <- Formaldehyde$optden)
```

``` {r naiveCalc}
solve(t(m) %*% m) %*% t(m) %*% yo
```

``` {r timedNaive}
system.time(solve(t(m) %*% m) %*% t(m) %*% yo)
```

``` {r catNaive}
dput(c(solve(t(m) %*% m) %*% t(m) %*% yo))
dput(unname(lm.fit(m, yo)$coefficients))
```

``` {r KoenNg}
library(Matrix)
data(KNex, package = "Matrix")
 y <- KNex$y
mm <- as(KNex$mm, "matrix") # full traditional matrix
dim(mm)
system.time(naive.sol <- solve(t(mm) %*% mm) %*% t(mm) %*% y)
```

``` {r crossKoenNg}
system.time(cpod.sol <- solve(crossprod(mm), crossprod(mm,y)))
all.equal(naive.sol, cpod.sol)
```

``` {r xpxKoenNg}
system.time(t(mm) %*% mm)
```

``` {r fullMatrix_crossprod}
fm <- mm
set.seed(11)
fm[] <- rnorm(length(fm))
system.time(c1 <- t(fm) %*% fm)
system.time(c2 <- crossprod(fm))
stopifnot(all.equal(c1, c2, tol = 1e-12))
```

``` {r naiveChol}
system.time(ch <- chol(crossprod(mm)))
system.time(chol.sol <-
            backsolve(ch, forwardsolve(ch, crossprod(mm, y),
                                       upper = TRUE, trans = TRUE)))
stopifnot(all.equal(chol.sol, naive.sol))
```

``` {r MatrixKoenNg}
mm <- as(KNex$mm, "denseMatrix")
class(crossprod(mm))
system.time(Mat.sol <- solve(crossprod(mm), crossprod(mm, y)))
stopifnot(all.equal(naive.sol, unname(as(Mat.sol,"matrix"))))
```

``` {r saveFactor}
xpx <- crossprod(mm)
xpy <- crossprod(mm, y)
system.time(solve(xpx, xpy))
system.time(solve(xpx, xpy)) # reusing factorization
```

``` {r SparseKoenNg}
mm <- KNex$mm
class(mm)
system.time(sparse.sol <- solve(crossprod(mm), crossprod(mm, y)))
stopifnot(all.equal(naive.sol, unname(as(sparse.sol, "matrix"))))
```

``` {r SparseSaveFactor}
xpx <- crossprod(mm)
xpy <- crossprod(mm, y)
system.time(solve(xpx, xpy))
system.time(solve(xpx, xpy))
```

``` {r sessionInfo, results='asis'}
toLatex(sessionInfo())
```

``` {r from_pkg_sfsmisc, echo=FALSE}

if(identical(1L, grep("linux", R.version[["os"]]))) { ##----- Linux - only ----

Sys.procinfo <- function(procfile)
{
  l2 <- strsplit(readLines(procfile),"[ \t]*:[ \t]*")
  r <- sapply(l2[sapply(l2, length) == 2],
              function(c2)structure(c2[2], names= c2[1]))
  attr(r,"Name") <- procfile
  class(r) <- "simple.list"
  r
}

Scpu <- Sys.procinfo("/proc/cpuinfo")
Smem <- Sys.procinfo("/proc/meminfo")
} # Linux only
```

``` {r Sys_proc_fake, eval=FALSE}
if(identical(1L, grep("linux", R.version[["os"]]))) { ## Linux - only ---
 Scpu <- sfsmisc::Sys.procinfo("/proc/cpuinfo")
 Smem <- sfsmisc::Sys.procinfo("/proc/meminfo")
 print(Scpu[c("model name", "cpu MHz", "cache size", "bogomips")])
 print(Smem[c("MemTotal", "SwapTotal")])
}
```

``` {r Sys_proc_out, echo=FALSE}
if(identical(1L, grep("linux", R.version[["os"]]))) { ## Linux - only ---
 print(Scpu[c("model name", "cpu MHz", "cache size", "bogomips")])
 print(Smem[c("MemTotal", "SwapTotal")])
}
```
