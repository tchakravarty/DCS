#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::depends(RcppArmadillo)]]
//' Simulate a marked point process
//' 
//' @param vEta vector
//' @param mAlpha matrix
//' @param vOmega vector 
//' @param mA matrix
//' @param mB matrix
//' @param iN integer
//' @param iMaxT integer
arma::vec SimulateMarkedPointProcess(arma::vec vEta, arma::mat mAlpha, arma::vec vOmega, 
                                     arma::mat mA, arma::mat mB, int iN, int iMaxT) {
  int t, i2;
  arma::vec vR, vFactors, vExpLambda, vScore, vSt, vLmax;
  double dSpellTotal;
  arma::mat mInfoMatrix;
  
  // initialize
  vR = iN | iN;  // CHECK: what does this mean?
  vFactors = 0;  // CHECK: will it recycle?
  
  // intialize the objects to be returned
  arma::vec s_vTau;
  arma::mat s_mY, s_mR;
  
  // create a new loop
  for(dSpellTotal = 0, t=0; dSpellTotal <= iMaxT; t++) {
    if(t >= s_mTau.n_rows - 1){
      s_vTau = arma::join_rows(s_vTau);
    }
  }
  
  
}