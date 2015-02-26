#====================================================================
# purpose: Simualte and estimate marked point process
# author: tirthankar chakravarty
# created: 26th febraury 2015
# revised:
# comments:
#====================================================================

#==========================================================
# 1. Simulation of the marked point process
#==========================================================
SimulateMarkedPointProcess = function(vEta, mAlpha, vOmega, mA, mB, iN, iMaxT) {
  vR = c(iN, iN)
  vFactors = 0
  vTau = numeric(0) 
  mY = matrix(numeric(0), nrow = 0, ncol = 2)
  mR = matrix(numeric(0), nrow = 0, ncol = 2)
  
  dSpellTotal = 0; t = 1
  while(dSpellTotal <= iMaxT) {
    if(t >= length(vTau)) {
      vTau = c(vTau, rep(0, 1000))
      mY = rbind(mY, matrix(rep(0, 2*1000), ncol = 2, nrow = 1000))
      mR = rbind(mR, matrix(rep(0, 2*1000), ncol = 2, nrow = 1000))
    }
    
    vLambda = vEta + mAlpha * vFactors;
    vExpLambda = exp(vLambda)
    
    # set exposures
    mR[t, ] = vR
    
    # generate the spell length
    vTau[t] = -log(1 - runif(1))/(mR[t, ] %*% vExpLambda)
    dSpellTotal = dSpellTotal + vTau[t]
    
    # generate the mark
    i2 = sum(runif(1) > cumsum(mR[t, ]*vExpLambda)/mR[t, ]%*%vExpLambda)
    if(i2 < 0 | i2 > 1) print("::Error in simulation of mark.::")
    mY[t, i2 + 1] = 1
    
    # adjust exposures
    vR[1] = vR[1] + 2*i2 - 1
    vR[2] = vR[2] + 1- 2*i2
    
    # compute the GAS step
    vLmax = max(vLambda)
    vScore = mAlpha %*% (mY[t, ] - vTau[t] * mR[t, ] * vExpLambda)
    mInfoMatrix = mAlpha %*% (mR[t, ] *exp(vLambda - vLmax)/(mR[t, ] %*% exp(vLambda - vLmax)) * mAlpha)
    vSt = solve(mInfoMatrix) %*% vScore
    
    # GAS recursion
    vFactors = vOmega + mA * vSt + mB*vFactors
    
    # print the signal of life
    if(10 %% 1000 == 0) print(i0/1000)
    t = t + 1
  }
  vTau = vTau[1:t]
  mY = mY[1:t, ]
  mR = mR[1:t, ]
  return(list(tau = vTau, y = mY, r = mR))
}

# test the function
simMarkPoint = SimulateMarkedPointProcess(vEta = c(-3.5, -4), mAlpha = c(1, -1), 
                                          vOmega = 0, mA = 0.025, 
                                          mB = 0.95, iN = 2500, iMaxT = 100)
plot(simMarkPoint$tau, type = "l")

#==========================================================
# function: restricted parameter space
#==========================================================
restrictedParams = function(vParams) {
  vRestrictedParams = vParams
  vRestrictedParams[4] = exp(vParams[4])
  vRestrictedParams[5] = exp(vParams[5])/(1 + exp(vParams[5]))
  return(vRestrictedParams)
}

#==========================================================
# function: marked point process GAS model LL
#==========================================================
llMarkedPointProcessGASModel = function(vParams, vTau, mY, mR) {
  iT = length(vTau)
  dLL = 0
  vFactor = 0
  
  # get the parameters of the model
  vOmega = 0
  vRestrictedParams = restrictedParams(vParams)
  vEta = vRestrictedParams[1:2]
  vAlpha = c(1, vRestrictedParams[3])
  mA = vRestrictedParams[4]
  mB = vRestrictedParams[5]
  
  for(t in 1:iT) {
    vLambda = vEta + vAlpha*vFactor
    vExpLambda = exp(vLambda)
    dLL = dLL + mY[t, ] %*% vLambda - vTau[t]*mR[t, ] %*% vExpLambda
    vScore = vAlpha %*% (mY[t, ]-vTau[t] * mR[t, ]* vExpLambda)
    mInfoMatrix = vAlpha %*% ((mR[t, ]  * vExpLambda /(mR[t, ] %*% vExpLambda)) * vAlpha)
    vSt = solve(mInfoMatrix) %*% vScore
    
    vFactor = vOmega + mA * vSt + mB * vFactor
  }
  return(-dLL)
}

# test the function
vEta = c(-3.5, -4)
mAlpha = c(1, -1)
mA = 0.025
mB = 0.95
vParams = c(vEta, mAlpha[2], log(mA), log(mB/(1-mB)))
# debugonce(llMarkedPointProcessGASModel)

# check that we are producing the right LL
llMarkedPointProcessGASModel(vParams = vParams, 
                             vTau = simMarkPoint$tau, 
                             mY = simMarkPoint$y, 
                             mR = simMarkPoint$r)

# compute the optimum parameters
paramMP = optim(vParams, 
      llMarkedPointProcessGASModel, 
      vTau = simMarkPoint$tau, 
      mY = simMarkPoint$y, 
      mR = simMarkPoint$r)
paramMP$par

#==========================================================
# function: compute the gradient of the log-likelihood
#==========================================================
computeGradient = function(fnLL, vParams, dDelta) {
  m = length(vParams)
  k = 1 # cols(vParams)
  vParamsTemp = vParams
  
}