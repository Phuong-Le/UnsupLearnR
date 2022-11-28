
#' make a cluster class that has the attribute raw and clustered_dt
#'
#' @param data data to be clustered
#' @param clusterFUN cluster function like stats::kmeans
#' @param ... arguments to be passed into clusterFUN
#' @return a cluster class with a raw dataframe and a clustered dataframe
#' @export
#'
#' @examples
#' library(stats)
#'
#' data = data.frame(1:4, c(3,6,8,2), c(4,8,10,2))
#' result = make_cluster(data, kmeans, centers = 3, nstart = 5, iter.max = 10)
#' print(result$raw)
#' print(result$clustered_dt)
make_cluster = function(data, clusterFUN, ...) {
  result = clusterFUN(data, ...)
  current_class = class(result)
  class(result) = c('cluster', current_class)
  result$raw = as.data.frame(data)

  clustered_dt = data.frame(cluster = result$cluster)
  rownames(clustered_dt) = rownames(result$raw)
  result$clustered_dt = clustered_dt
  return(result)
}
