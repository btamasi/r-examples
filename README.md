# R Code Snippets

Some useful R code for reuse

# Graphics

- [Draw grid behind histogram](add_grid_behind_histogram.R)
- [Create jittered dotplot with median lines with ggplot2](jittered_dotplot_ggplot2.R)
- [Add a single main title to a multiplot](Weibull_multiplot.R)
- [Legend with expressions and values from variables](Weibull_multiplot.R)
- [Various ways of visualizing conditional distributions with ggplot2](cond_dist_ggplot.Rmd)
- [Wrap text on axis with stringr](cond_dist_ggplot.Rmd)
- [QQ-plot for non-normal distribution](qqplot_gamma.R)
- [Paired plot for baseline and follow-up measurements](paired_plot.R)
- [Legend settings](bivar_loglik_profilelik.R)
- [Survival: Plotting fitted parametric survivor functions](plot_param_surv.R)
- [Comparing discrete distributions using empirical CDF](binom_vs_poisson.R)
- [Points with error bars using base R](error_bars.R)
- [Histogram with legend for bar and line](hist_legend_bar_line.R)
- [Create animation with library(animation)](gol.R)

# Vector and matrix manipulation

- [Fill NAs with last non-NA values](fill_NA_with_last_non-NA.R)
- [Insert values after specified indices](insert_value_after_index.R)
- [Apply function to grouped data](grouped_data_calculations.R)
- [Compare the elements of two vectors](compare_vector_elements.R)
- [Get duplicated elements from a vector](get_duplicated_elements.R)
- [Create AR(1) correlation matrix](ar_cor_matrix.R)
- [Count consecutive 1s in a vector](count_consecutive.R)
- [Get the (non-main) diagonals of a matrix](get_diagonals_matrix.R)
- [Converting integers to base 2 vectors](int_to_base2.R)
- [Converting base 2 vectors to decimals with Reduce()](elementary_ca.R)

# Functions

- [Evaluate a function recursively using previous results](evaluate_function_recursively.R)
- [Short-circuit evaluation](short-circuiting.R)
- [Updating lm objects recursively to eliminate insignificant variables](update_lm_recursion.R)
- [Extract model matrix and response vector using formula](logit_optim.R)
- [Calculate MLE of logit model using optim()](logit_optim.R)
- [Functions as inputs and outputs of other functions](elementary_ca.R)

# Data handling and manipulation

- [Match period beginnings to events in grouped data using rolling join in data.table](rolling_join.R)
- [Read data from an url with RCurl](read_csv_from_url.R)

# Package specific

- [survival: lagged time dependent covariates](lagged_tdc_survival.R)
- [animation: creating animations and saving as gif](gol.R)

# Simulations

- [Approximating pi with Monte Carlo methods](pi_MC.R)
- [Reproducible parallel simulations](pi_MC.R)
- [Connection between Binomial and Poisson distributions](binom_vs_poisson.R)
- [Conway's Game of Life](gol.R)
- [Wolfram's elementary cellular automata](elementary_ca.R)
- [Using Poisson process to generate Poisson-distributed random sample](X2_gof_discrete.R)
- [Simulate continuous-time Markov chains](sim_ctmc.R)
- [Simulate M/M/s/c queues](sim_queue.R)

# Statistics

- [Power curves, and determinants of the power of a test](power_curves.R)
- [Calculate MLE of logit model using optim()](logit_optim.R)
- [Poisson regression with offset](poisson_reg_offset.R)
- [Setting contrasts for factors in lm()](contrasts_lm.R)
- [Likelihood: Comparing likelihood-based confidence intervals for binomial data](binom_ci_coverage.R)
- [Likelihood: Joint likelihood and profile likelihood](bivar_loglik_profilelik.R)
- [Survival: Fitting parametric survival model](plot_param_surv.R)
- [Testing linear parameter restrictions in a normal linear regression model](test_param_rest_lm.R)
- [Bayesian: Logistic regression with Metropolis sampling](logit_MCMC.R)
- [Using Chi-square goodness-of-fit test to test discrete distribution](X2_gof_discrete.R)
