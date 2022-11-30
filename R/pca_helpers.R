
#' get the name of the PC given the PC number
#' @param pc_number the number for the PC
pc_name = function(pc_number) paste('PC',pc_number,sep = '',collapse='')


#' Generates a vector of principal component names given the number of desired principle components
#' @param pc_number numeric, the desired number of principal components
#' @return a vector from PC1 to PCX where X is the number of desired PCs
pc_names = function(pc_number) {
  pc_names = c()
  for (i in 1:pc_number) {
    pc_names = append(pc_names,pc_name(i))
  }
  return(pc_names)}


#' returns the variance for each principal component in pc_dataframe
#' @param pc_dataframe the dataframe of principal components
#' @param pc_number numeric, the desired number of principal components
#' @return a vector of variance for each principal component
#' @export
variance_proportion = function(pc_dataframe,pc_number=NULL) {
  pc_variance = c()
  if (is.null(pc_number)) pc_number = ncol(pc_dataframe)
  for (i in 1:pc_number) {
    pc_variance = append(pc_variance,stats::var(pc_dataframe[names(pc_dataframe) == pc_names(pc_number)[i]]))
  }
  return(pc_variance*100/sum(pc_variance))}

#' returns the variance for each principal component in pc_dataframe
#' @param pc_dataframe the dataframe of principal components
#' @param pc_number numeric, the desired number of principal components
#' @return a vector of cumulative variance for each principal component
#' @export
cum_variance_proportion = function(pc_dataframe,pc_number=NULL) {
  var_prop = variance_proportion(pc_dataframe,pc_number=NULL)
  return(cumsum(var_prop))}
