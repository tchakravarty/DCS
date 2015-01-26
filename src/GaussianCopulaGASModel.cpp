// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-
#include "RcppArmadillo.h"
// [[Rcpp::depends(RcppArmadillo)]]
using namespace Rcpp;

// [[Rcpp::export]]
arma::vec fnRestrictedParams(arma::vec vParams) {
  arma::vec vRestrictedParams = vParams;
  vRestrictedParams[1] = exp(vParams[1]);
  vRestrictedParams[2] = exp(vParams[2])/(1 + exp(vParams[2]));
  return(vRestrictedParams);
}

// [[Rcpp::export]]
double fnGASGaussianCopulaLikelihoodCpp(arma::vec vParams, int iT, arma::mat mData) {
  double dLL = 0;  // initialize the likelihood at zero
  arma::vec vRestrictedParams = fnRestrictedParams(vParams);
  double dOmega = vRestrictedParams[0];
  double dA = vRestrictedParams[1];
  double dB = vRestrictedParams[2];

  double dFactor = dOmega;
  dOmega = dOmega*(1 - dB);
  arma::vec vFactor = arma::zeros(iT);
  double rho, rho2, x, y, dSt = 0;
  NumericVector qu;
  arma::rowvec dataRow;
  

  for(int t=0; t < iT; t++) {
    // compute the copula parameters based on the factors
    rho = (1 - exp(-dFactor))/(1 + exp(-dFactor));
    rho2 = rho*rho;
    vFactor[t] = rho;
    
    // quantile functions
    dataRow = mData.row(t);
    qu = qnorm(NumericVector(dataRow.begin(), dataRow.end()));
    x = sum(pow(qu, 2));
    y = arma::prod(arma::vec(qu));
    
    // get the log pdf of the copula, and its gradient with respect to the copula parameters
    dLL +=  -0.5*log(1 - rho2) - 0.5*(rho2*x - 2*rho*y)/(1 - rho2);
    
    // scaled score function
    dSt = (2/(1 - rho2))*(y - rho - rho*(x - 2)/(1 + rho2));
    
    // GAS recursion
    dFactor = dOmega + dA*dSt + dB*dFactor;
  }
  return(-dLL/iT);
}