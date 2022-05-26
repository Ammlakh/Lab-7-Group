#' Preform  a very basic k-means clustering on a dataset.
#'
#' @usage k_means(dat, numclusters, PCA = F)
#'
#'
#' @param dat numeric matrix to do kmeans to
#' @param numclusters number of clusters
#' @param PCA option to preform PCA on the data.
#'
#' @return A list containing cluster means, clustering vector, and total SSE.
#'
#' @import tidyverse
#'
#' @export

k_means = function(dat, numclusters, PCA = F){

    if(PCA == T){
        dat = princomp(dat) #allowed to use by instructions
        dat = dat$scores %>%
            as_tibble() %>%
            select(Comp.1, Comp.2)
    }

    cluster_means = sample_n(dat, numclusters)
    icluster_means = 0

    while(sum((cluster_means - icluster_means)^2) != 0){

        icluster_means = cluster_means
        clustvect = as.matrix(dat)
        clust = rep(NA, nrow(clustvect))
        variability = rep(NA, nrow(clustvect))

        for(i in 1:nrow(clustvect)){

            distance = as.matrix(dist(rbind(cluster_means, clustvect[i,])))
            distance = distance[nrow(distance), 1:nrow(distance)-1]
            clust[i] = which.min(distance)
            variability[i] = min(distance)

        }

        clustvect = cbind(clustvect, clust, variability)
        SSE = sum(variability^2)

        for(j in 1:(ncol(clustvect)-2)){
            cluster_means[,j] = tapply(clustvect[,j], clustvect[,ncol(clustvect)-1], mean)
        }

    }

    return(list('Clustering vector' = clustvect[,ncol(clustvect)-1], 'Cluster Means' = cluster_means, 'Total SSE' = SSE))

}
