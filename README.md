
<!-- README.md is generated from README.Rmd. Please edit that file -->

# clust431

<!-- badges: start -->

<!-- badges: end -->

The goal of clust431 is to do k-means clustering and hierarchical
clustering.

## Installation

You can install the released version of clust431 from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("clust431")
```

## Example for k\_means()

This is a basic example which compares the original kmeans function to
the one made for lab 7

``` r
library(clust431)
library(tidyverse)
#> -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
#> v ggplot2 3.3.3     v purrr   0.3.4
#> v tibble  3.1.1     v dplyr   1.0.6
#> v tidyr   1.1.2     v stringr 1.4.0
#> v readr   1.4.0     v forcats 0.5.0
#> Warning: package 'tibble' was built under R version 4.0.5
#> Warning: package 'dplyr' was built under R version 4.0.5
#> -- Conflicts ------------------------------------------ tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()

iris2 <- iris %>%
    select(Sepal.Length, Sepal.Width)
k_means(iris2, 3, PCA = F)
#> $`Clustering vector`
#>   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#>  [38] 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 3 2 3 2 3 2 3 3 3 3 3 3 2 3 3 3 3 3 3 3 3
#>  [75] 2 2 2 2 3 3 3 3 3 3 3 3 2 3 3 3 3 3 3 3 3 3 3 3 3 3 2 3 2 2 2 2 3 2 2 2 2
#> [112] 2 2 3 3 2 2 2 2 3 2 3 2 3 2 2 3 3 2 2 2 2 2 3 3 2 2 2 3 2 2 2 3 2 2 2 3 2
#> [149] 2 3
#> 
#> $`Cluster Means`
#>   Sepal.Length Sepal.Width
#> 1     5.006000    3.428000
#> 2     6.812766    3.074468
#> 3     5.773585    2.692453
#> 
#> $SSE
#> [1] 37.0507
#> 
#> $`Total SS`
#> [1] 130.4753
```

The chunk below is comparing the results of my function from above to
the built-in function.

``` r
actual <- kmeans(iris2, 3)
actual
#> K-means clustering with 3 clusters of sizes 53, 50, 47
#> 
#> Cluster means:
#>   Sepal.Length Sepal.Width
#> 1     5.773585    2.692453
#> 2     5.006000    3.428000
#> 3     6.812766    3.074468
#> 
#> Clustering vector:
#>   [1] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
#>  [38] 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 1 3 1 3 1 3 1 1 1 1 1 1 3 1 1 1 1 1 1 1 1
#>  [75] 3 3 3 3 1 1 1 1 1 1 1 1 3 1 1 1 1 1 1 1 1 1 1 1 1 1 3 1 3 3 3 3 1 3 3 3 3
#> [112] 3 3 1 1 3 3 3 3 1 3 1 3 1 3 3 1 1 3 3 3 3 3 1 1 3 3 3 1 3 3 3 1 3 3 3 1 3
#> [149] 3 1
#> 
#> Within cluster sum of squares by cluster:
#> [1] 11.3000 13.1290 12.6217
#>  (between_SS / total_SS =  71.6 %)
#> 
#> Available components:
#> 
#> [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss"
#> [6] "betweenss"    "size"         "iter"         "ifault"
actual$totss - actual$betweenss
#> [1] 37.0507
actual$totss
#> [1] 130.4753
```

As we can see, we get the same SSE, clustering vectors, and cluster
means. Our function gives SSE straight up, but there is more
calculations needed. That being said, the built-in function has much
more information.

## Example for hier\_clust()

This is a basic example which compares the actual hier\_clust function
to the one made for lab 7

``` r
iris3 <- iris %>%
  select(-c(Species))
b = hier_clust(iris3, k=150, method = 'euclidean')
head(b, 6)
#> cluster 1 cluster 2 cluster 3 cluster 4 cluster 5 cluster 6 
#> "102,143"    "8,40"    "1,18"   "10,35" "133,129"   "11,49"
a = hclust(dist(iris3))
head(a$merge, 6)
#>      [,1] [,2]
#> [1,] -102 -143
#> [2,]   -8  -40
#> [3,]   -1  -18
#> [4,]  -10  -35
#> [5,] -129 -133
#> [6,]  -11  -49
```

``` r
hier_clust(iris3, k=3, method = "manhattan")
#>                                                                                                                                                                                                                                                                  cluster 1 
#>                                                 "150,71,139,128,115,122,114,143,102,134,84,73,124,127,112,147,135,52,57,86,98,75,74,79,64,92,55,59,77,76,66,51,53,87,78,120,69,88,145,141,144,121,125,137,149,101,133,129,105,104,117,138,109,148,111,116,146,142,113,140" 
#>                                                                                                                                                                                                                                                                  cluster 2 
#>                                                                                                                             "7,43,4,48,3,14,39,9,23,26,10,35,2,46,13,36,38,5,29,28,18,1,41,50,8,40,25,31,30,12,42,17,34,33,15,16,21,32,37,11,49,6,19,45,47,22,20,24,27,44" 
#>                                                                                                                                                                                                                                                                  cluster 3 
#> "150,71,139,128,115,122,114,143,102,134,84,73,124,127,112,147,135,52,57,86,98,75,74,79,64,92,55,59,77,76,66,51,53,87,78,120,69,88,145,141,144,121,125,137,149,101,133,129,105,104,117,138,109,148,111,116,146,142,113,140,110,136,132,118,119,123,106,103,130,126,108,131"
```

``` r
hier_clust(iris3, k=4, method = "euclidean")
#>                                                                                                                             cluster 1 
#>                  "37,21,32,49,11,22,20,47,45,44,27,24,8,40,28,29,38,5,1,18,41,31,30,12,25,2,13,46,26,10,35,36,50,15,19,16,33,34,17,6" 
#>                                                                                                                             cluster 2 
#>                         "101,149,137,141,121,144,145,125,148,111,116,140,113,142,146,131,108,130,126,103,129,133,105,104,138,117,109" 
#>                                                                                                                             cluster 3 
#> "78,76,66,59,55,77,51,87,53,86,52,57,64,92,79,74,98,75,72,88,69,124,127,134,73,147,112,120,84,135,71,150,128,139,115,122,114,143,102" 
#>                                                                                                                             cluster 4 
#>                                                  "60,65,56,100,95,91,62,96,97,89,67,85,70,82,81,90,54,63,68,83,93,80,61,99,94,58,107"
```
