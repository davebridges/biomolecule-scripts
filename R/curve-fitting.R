# taken from http://cran.r-project.org/doc/contrib/Fox-Companion/appendix-nonlinear-regression.pdf

# Load companion for applied regression (car) package.  These steps are only required for loading the sample data
library(car)
data(US.pop) #load data set for US.pop
attach(US.pop) #attach US.pop data
plot(year, population) #plot population data vs year
time <- 0:20 #set time variable

library(nls) # load the nls package
# Set the curve fitting equation as:
# Population = beta1/(1 + exp(beta2 + beta3*time))
# Set inital start values.  These should be estimated.  Setting trace=T shows results of regression
pop.mod <- nls(population ~ beta1/(1 + exp(beta2 + beta3*time)),  start=list(beta1 = 350, beta2 = 4.5, beta3 = -0.3), trace=T)
# Output the summary of the nonlinear regression fit
summary(pop.mod)
# Plot fitted values for the fitting.  Shows original points plus best fit line
lines(year, fitted.values(pop.mod), lwd=2)
# Plot residuals vs year
plot(year, residuals(pop.mod), type=’b’)
# Add a horizontal line at zero for residual fitting
abline(h=0, lty=2)


