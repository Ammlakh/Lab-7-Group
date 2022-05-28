#' Preform hierarchical clustering on a dataset.
#'
#'
#' @param dat data for clustering (dataframe or matrix)
#' @param method the distance measure to be used. This must be one of euclidean or manhattan.
#' @param k The number of clusters to stop clustering at
#'
#' @return A vector with what was merged and in what order.
#'
#' @examples
#' iris2 <- iris %>% select(-Species)
#' hier_clust(iris2, method = "euclidean")
#' hier_clust(iris2, method = "manhattan")
#'
#' @import tidyverse
#' @import sna
#'
#' @export

hier_clust = function(dat, k, method = 'euclidean'){

    distances = diag.remove(as.matrix(dist(dat, method = ifelse(method == 'euclidean', 'manhattan', no = "euclidean"))))

    assignments = NULL
    step = 1

    while(length(assignments) < nrow(dat)){

        min_dist = which(distances == min(distances, na.rm = T), arr.ind = T)
        min_dist = as.matrix(sample_n(data.frame(min_dist),1))
        assignments = c(assignments, paste(row.names(distances[min_dist,]), sep = '', collapse = ','))
        new_distances = distances[-min_dist,-min_dist]
        comparison = distances[-as.numeric(min_dist),as.numeric(min_dist)]

        if(length(new_distances) > 1){

            comparison = apply(comparison, 1, max)
            distances = cbind(comparison, new_distances)
            distances = rbind(c(NA, comparison), distances)
            row.names(distances)[1] = assignments[step]

        } else {

            assignments = c(assignments, paste(row.names(distances), sep = '', collapse = ','))
            break

        }

        step = step + 1

    }
    pascals = k*(k+1)/2
    index = nrow(dat) - pascals
    clusterlist = c()
    for(i in 1:k){
        clust = assignments[index+i]
        clusterlist = c(clusterlist,clust)
    }
    n=c()
    for(i in 1:k){
        name = paste("cluster", i)
        n = c(n,name)
    }
    names(clusterlist) <- n
    return(clusterlist)

}


