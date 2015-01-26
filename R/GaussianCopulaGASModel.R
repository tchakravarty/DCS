fnRestrictedParams = function(vParams) {
  vRestrictedParams = vParams
  vRestrictedParams[2] = exp(vParams[2])
  vRestrictedParams[3] = exp(vParams[3])/(1 + exp(vParams[3]))
  return(vRestrictedParams)
}

fnGASGaussianCopulaLikelihood = function(vParams, iT, mData) {
  dLL = 0  # initialize the likelihood at zero
  vRestrictedParams = fnRestrictedParams(vParams)
  dOmega = vRestrictedParams[1]
  dA = vRestrictedParams[2]
  dB = vRestrictedParams[3]
  
  dFactor = dOmega
  dOmega = dOmega*(1 - dB)
  vFactor = rep(0, iT)
  for(t in seq.int(iT)) {
    # compute the copula parameters based on the factors
    rho = (1 - exp(-dFactor))/(1 + exp(-dFactor))
    rho2 = rho * rho
    vFactor[t] = rho
    
    # quantile functions
    qu = sapply(mData[t, ], qnorm)
    x = sum(qu^2)
    y = prod(qu)
    
    # get the log pdf of the copula, and its gradient with respect to the copula parameters
    dLL = dLL -0.5*log(1 - rho2) - 0.5*(rho2*x - 2*rho*y)/(1 - rho2)
    print(dLL)
    # scaled score function
    dSt = (2/(1 - rho2))*(y - rho - rho*(x - 2)/(1 + rho2))
    
    # GAS recursion
    dFactor = dOmega + dA*dSt + dB*dFactor
  }
  return(-dLL/iT)
}

# function to accept the inputs and provide all the outputs
GaussianCopulaGAS = function(mData, vParam, ...) {
  optimGaussCopGAS = optim(par = c(0.005, -5, 5.0), 
                           fn = fnGASGaussianCopulaLikelihoodCpp, mData = mData, iT = nrow(mData), 
                           ...)
  return(optimGaussCopGAS)
}

