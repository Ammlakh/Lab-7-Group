#'
#' Preform hierarchical clustering on a dataset.
#'
#'
#'
#' @param x data for clustering
#' (such as a numeric vector or a data frame with all numeric columns).
#' @param method the distance measure to be used. This must be one of euclidean or manhattan.
#'
#' @return A vector with what was merged and in what order.
#' @examples
#' iris2 <- iris %>% select(-Species)
#' hier_clust(iris2, method = "euclidean")
#' hier_clust(iris2, method = "manhattan")
#'
#' @import tidyverse
#' @import sna
#'
#' @export

hier_clust = function(x, method = 'euclidean'){

    dists = diag.remove(as.matrix(
        dist(x, method = ifelse(method == 'euclidean', 'manhattan'))))

    merges = NULL
    i = 1

    while(length(merges) < nrow(x)){

        index = which(dists == min(dists, na.rm = T), arr.ind = T)
        index = as.matrix(sample_n(data.frame(index),1))
        merges = c(merges, paste(row.names(dists[index,]), sep = '', collapse = ','))
        new_dists = dists[-index,-index]
        comparison = dists[-as.numeric(index),as.numeric(index)]

        if(length(new_dists) > 1){

            comparison = apply(comparison, 1, max)
            dists = cbind(comparison, new_dists)
            dists = rbind(c(NA, comparison), dists)
            row.names(dists)[1] = merges[i]

        } else {

            merges = c(merges, paste(row.names(dists), sep = '', collapse = ','))
            break

        }

        i = i + 1

    }

    return(merges)

}
