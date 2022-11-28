#' plot pca labelled by a specified parameter
#'
#' @import ggplot2
#' @param pc_dataframe the pca transformed dataframe
#' @param params a dataframe with 1 column indicating the param of interest, with colname being param, rownames should be compatible with those of pc_dataframe
#' @param cluster (optional), it is the output of make_cluster
#' @param x_pc, y_pc the principle components to be ploted on the x or y axis
#' @param point if True (default), geom_point will be used
#' @param label if True, geom_text will be used
#' @param used_cols, used_shapes colours and shapes of the observations
#' @return a ggplot of labelled pca
#' @export
plot_pca = function(pc_dataframe, params, cluster=NULL, x_pc=1, y_pc=2, point =T, label = F, used_cols=NULL, used_shapes=NULL) {

  toplot = merge(pc_dataframe, params, by = 'row.names')
  rownames(toplot) = toplot$Row.names; toplot = toplot[,-1]
  categories = unique(toplot$param)

  if (is.null(used_cols)) used_cols = graphicsPLr::get_cols(categories)
  names(used_cols) = categories
  if (is.null(used_shapes)) used_shapes = graphicsPLr::get_shapes(categories)
  names(used_shapes) = categories

  if ('cluster' %in% class(cluster)) {
    toplot = merge(toplot, cluster$clustered_dt, by = 'row.names')
    rownames(toplot) = toplot$Row.names; toplot = toplot[,-1]
  }

  x_axis = paste('dim ',x_pc, ' (',round((variance_proportion(pc_dataframe)[x_pc]),2),'% explained)',sep='')
  y_axis = paste('dim ', y_pc, ' (',round((variance_proportion(pc_dataframe)[y_pc]),2),'% explained)',sep='')
  x_pc = pc_name(x_pc); y_pc = pc_name(y_pc)
  p =ggplot(toplot, mapping = aes(x=toplot[,x_pc],y=toplot[,y_pc])) +
    labs(x=x_axis,
         y=y_axis) +
    ggpubr::theme_pubr()

  if (!is.numeric(toplot$param)) p = p + scale_color_manual(values = used_cols) +   scale_shape_manual(values = used_shapes)
  if (label==T) p = p + geom_text(mapping = aes(colour=param,label=rownames(toplot)), alpha = 0.4)
  if (point==T) {
    if (!is.numeric(toplot$param)) p = p + geom_point(mapping = aes(col = param, shape = param)) else
    {p = p + geom_point(mapping = aes(col = param))}
  }

  if ('cluster' %in% class(cluster)) p = p + stat_ellipse(mapping = aes(group = cluster), linewidth = 0.5)
  return(p)
}
