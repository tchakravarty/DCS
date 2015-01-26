DCS
===
This package provides functionality to estimate models of the Dynamic Conditional Score [DCS] class, proposed by Harvey & Chakravarty (2008, 2009), and by Creal, Koopman & Lucas (2013), simultaneously, and independently as Generalized Autoregressive Score [GAS] models. A comprehensive introduction to the theory of these models is given in Harvey (2013).

The models of the DCS class in the current version of the package include:  
* Gaussian copula GAS models (Creal, Koopman & Lucas, 2013);  
* Marked point process GAS models (Creal, Koopman & Lucas, 2013);  
* Beta-t-GARCH DCS models (Harvey & Chakravarty, 2008);  
* Beta-t-EGARCH DCS models (Harvey & Chakravarty, 2008);  
* GAS volatility models (Creal, Koopman & Lucas, 2013);  

TVQ (NOT_IMPLEMENTED)
===
This package provides functions to compute time-varying quantiles [TVQs] and expectiles [TVEs] as in the work of Andrew Harvey and co-authors. 
Time-varying quantiles and time-varying expectiles capture the notion that features of the distribution other than the mean and the variance (GARCH and stochastic volatility models) can be dynamic, and as such, are parsilmoniously modeled using state space models.

Some of the relevant literature covered here:
- [Dahlhaus (1997)](http://projecteuclid.org/euclid.aos/1034276620)
- [Harvey & Busetti (2010)](http://dx.doi.org/10.1111/j.1467-9892.2010.00676.x)
- [Harvey & de Rossi (2009)](http://dx.doi.org/10.1016/j.jeconom.2009.01.001)
- [Aue, Hormann, Horvath & Reimherr (2009)](http://projecteuclid.org/euclid.aos/1256303536)
- [Wied, Dehling, van Kampen & Vogel (2014)](http://http://dx.doi.org/10.1016/j.csda.2013.02.031)
- [Harvey (2010)](http://dx.doi.org/)
- [Busetti & Harvey (2011)](http://dx.doi.org/10.1093/jjfinec/nbq020)