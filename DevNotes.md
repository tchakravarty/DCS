Development Notes:
=====
*Last updated: 26rd February 2015*

26th Februrary 2015
-------------------
* Create the code for the simulation of the marked point process in C++. Ox's idiom for returning multiple objects by making them global and using functions to fill them up is nasty. 
* Objects from this function are to be returned as a list. 
* Create a new file for the R version of the marked point process code, before completing the C++ version.
* Recall that for Ox, even vectors are matrices, and exactly the other way around for R -- even matrices are vectors. 
* Completed the R version of the marked point process simulation code. 
* 

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
