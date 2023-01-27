#4.4 Exercises
#1) Why does this code not work?
my_variable <- 10
my_variable
#> Error in eval(expr, envir, enclos): object 'my_varıable' not found 
#originally this code didn't work because there was a small spelling error 

#2) Tweak each of the following R commands so that they run correctly:
library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3) 
#errors have been corrected

#3) Press Alt + Shift + K. What happens? How can you get to the same place using the menus?
#nothing, likely an RStudio thing but I am in nvim... 


