#your data will need to be a vector of length N and a matrix of width N (the number of rows dosent matter, but those are the genes youll be testing).
#in this example thing being correlated to must be called sample_vector
#matrix is called sample_matrix
#rownames will be corresponding to the objects being correlated


fit <- lm(t(sample_matrix) ~ igf_sample_vector) 

#presumes a linear model, allowing for an intercept
#in summary.data rsq is the adjusted r-squared
#pval is the unadjusted p-value of the linear model
#estimate is the slope (one unit change of sample_vector = X change in thing being tested)
#padj is the BH adjusted pval

summary.data <- data.frame(row.names=colnames(fit$fitted.values),
                           rsq = rep(NA, length(colnames(fit$fitted.values))),
                           pval = rep(NA, length(colnames(fit$fitted.values))),
                           estimate = rep(NA, length(colnames(fit$fitted.values)))
                           )
for (n in seq(1,dim(fit$fitted.values)[2])) {
   summary.data[colnames(fit$coef)[n],]$rsq <- summary(fit)[[n]]$adj.r.squared
   summary.data[colnames(fit$coef)[n],]$pval <- summary(fit)[[n]]$coefficients[2,4]
   summary.data[colnames(fit$coef)[n],]$estimate <- summary(fit)[[n]]$coefficients[2,1] 
}
#adjusts the pvalue using the method of BH
summary.data$padj <- p.adjust(summary.data$pval, method="BH")