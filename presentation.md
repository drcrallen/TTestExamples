Curse of the Long Tail - Eample of t-test failure
========================================================
author: Charles Allen
date: 2016-06-25
autosize: true

t-test
========================================================

The t-test is one of the most common statistical tests performed

- Can determine if metrics from two populations differe in a statistically significant manner
- Works best with *normal* distributions
- More information available on [wikipedia](https://en.wikipedia.org/wiki/Student%27s_t-test)
- Key metric is the "t-statistic", which is relate to the difference in means devided by the standard error
- Depends on sample size

$$
t = \frac{\mu_1 - \mu_2}{\sqrt{(var_1 + var_2)/n}}
$$

Normal distribution t-test
========================================================
A simple t-test is often performed against normally distributed data of the type below:


```r
gaussian_fn <- function(x, mu, sigma) {
    dnorm(x, mean = mu, sd = sigma)
}
mu <- 5000
sigma <- 500
x <- 1:10000
plot(x, y = gaussian_fn(x, mu, sigma), xlab = "", ylab = "Density", type = 'l')
```

![plot of chunk unnamed-chunk-1](presentation-figure/unnamed-chunk-1-1.png)

Non-normal distribution
========================================================
For a distribution with a long-tail, we can use [Planck's law](https://en.wikipedia.org/wiki/Planck%27s_law). When ignoring scaling factors, this takes the general form of:

```r
library(ggplot2)
planck_fn <- function(x, a) {
    y <- x
    positive = x > 0
    y[!positive] <- 0
    y[positive] <- 1/(exp(a/x[positive]) - 1) / x[positive]^5
}
x <- 1:10000
plot(x, y = planck_fn(x / 500, 10), xlab = "", ylab = "Density", type = 'l')
```

![plot of chunk unnamed-chunk-2](presentation-figure/unnamed-chunk-2-1.png)

The long-tail at higher x-values completely screws up a simple t-test, yielding results very different from visual inspection.

TTestExamples
========================================================
t-test examples are [hosted online](https://allen-net.shinyapps.io/TTestExamples/) as an educational tool and allow easy manipulation of a normal and a long-tail distribution to see the effect on the p-value (same-ness statistic) for visually simmilar distributions.

The source is hosted on [github](https://github.com/drcrallen/TTestExamples)