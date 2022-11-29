
#' scree plot
#' @import ggplot2
#' @param pc_dataframe the dataframe of principal components
#' @param pc_number numeric, the desired number of principal components
#' @param cumulative whether to plot a normal scree plot or a cumulative scree plot
#' @return a ggplot for scree plot
#' @export
scree_plot = function(pc_dataframe, pc_number=NULL, cumulative = T) {
  if (cumulative == T) {
    y = c(0,cum_variance_proportion(pc_dataframe, pc_number=NULL))
    x = 0:(length(y) - 1)} else
    {
      y = variance_proportion(pc_dataframe, pc_number=NULL)
      x = 1:length(y)}
  p = ggplot() +
    aes(x=x,y=y,group=1) +
    geom_line(colour = 'black') +
    geom_point(colour = 'salmon') +
    labs(x='principal component',y='percentage of variability explained') +
    ggpubr::theme_pubr()
  return(p)
}
