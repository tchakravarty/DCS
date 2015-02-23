# Fit a Gaussian GAS copula model
#' @export
GaussianCopulaGAS = function(mData, vParam, ...) {
  optimGaussCopGAS = optim(par = c(0.005, -5, 5.0), 
                           fn = gas_gc_llCpp, mData = mData, iT = nrow(mData), 
                           ...)
  return(optimGaussCopGAS)
}

