Development Notes:
=====
*Last updated: 23rd February 2015*
23rd February 2015
------------------
* Pesky issue with `useDynLib` not being recognized by `roxygen2`. Need to add a `NULL` to the end of the package file to get it to do this. 
* The `CrealKoopmanLucas2013.R` example file should now work.
* Remove the `R` version of the Gaussian GAS copula model.
* Remove the `R` version of the function for estimating restricted values of the parameters.
* 
 
26th January 2015
----
* Create the function that optimizes the GAS Gaussian copula model as in Creal, Koopman & Lucas (2013).
* TODO: delete the R versions of the GAS Gaussian copula likelihood functions, or make them loadable when requested with the `Ronly` switch.
This is intended to be similar in functionality to a `stataonly` switch that switches off Mata in Stata. 

* Create the function that optimizes the marked point process model as in Creal, Koopman & Lucas (2013).
