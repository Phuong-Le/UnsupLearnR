
#' barplot of clusters that's been labelled
#'
#' @import ggplot2
#' @param cluster result from make_cluster
#' @param param a dataframe with 1 column indicating the categorical label of interest, with colname being 'param', rownames should be compatible with those of cluster
#' @param used_cols (optional) the colours of the clusters
#' @return a ggplot barplot with param labels on the x axis and coloured by the clusters
#' @export
plot_labelled_cluster_bars = function(cluster, param, used_cols=NULL, used_shapes=NULL) {

  toplot = merge(cluster$clustered_dt, param, by = 'row.names')
  toplot$cluster = as.factor(toplot$cluster)
  rownames(toplot) = toplot$Row.names; toplot = toplot[,-1]
  categories = unique(toplot$cluster)

  if (is.null(used_cols)) used_cols = graphicsPLr::get_cols(categories)
  names(used_cols) = categories

  p = ggplot(toplot) +
    geom_bar(mapping = aes(x = param, fill= cluster), position = 'fill') +
    scale_fill_manual(values = used_cols) +
    labs(x = '', y = 'proportion') +
    ggpubr::theme_pubr() +
    theme(axis.text.x=element_text(angle=70, hjust = 1))

  size = as.data.frame(table(toplot$param))
  colnames(size) = c('param','freq')
  p = p + geom_text(data=size, mapping = aes(x=param, y= Inf, label = freq), vjust =1, fontface = 'italic')

  return(p)
}

