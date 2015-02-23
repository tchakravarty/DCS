# ==============================================================================
# purpose: this file replicates the code in the file "gaussianCopulaGASmodel.ox",
# packaged with the paper:
#  Creal, Koopman, Lucas (2013): "Generalized Autoregressive Score Models with Applications",
#    Journal of Applied Econometrics
# The code, at the time of translation could be found at the following link:
# (Ox) http://faculty.chicagobooth.edu/drew.creal/research/papers/crealKoopmanLucasGASoxCode.zip
# (Matlab) http://faculty.chicagobooth.edu/drew.creal/research/papers/crealKoopmanLucasGASmatlabCode.zip
# author: tirthankar chakravarty
# created: 20th january 2014
# revised:
# comments:
#==============================================================================

# read in the data
dfCKL = read.csv("Data/Patton4filtered.csv")
mData = as.matrix(dfCKL[, 2:3])
iT = nrow(mData)

# compute the parameters of the Gauassian copula GAS models
optimGASGC = GaussianCopulaGAS(c(0.005, -5, 5.0), mData = as.matrix(mData))
optimGASGC$par
fnRestrictedParams(optimGASGC$par)
