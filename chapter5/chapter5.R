library(nycflights13)
library(tidyverse) 

flights 

#tibbles are dataframes specifically made for use in the tidyverse
#key words in dplyr
#   1) filter() - pick observation by value 
#   2) arrange() - reorder the rows 
#   3) select() - pick variables by their names 
#   4) mutate() - create new variables with functions of existing variables 
#   5) summarise() - collapse many values down to a single summary 
#   6) group_by() - can be used by all of the above and changes the scope of
#      each function to work on a specific subsection of the data 

#using filter() - first is data, next are expressions to filter 
filter(flights, month == 1, day == 1) 
#dplyr never changes their inputs, so you must save the output to a variable 
jan1 <- filter(flights, month == 1, day == 1)
#wrap in () to both assign variable and print the filtered dataframe 
(dec25 <- filter(flights, month == 12, day == 25)) 
#instead of using classic comparison operators like <, <=, >, >=, == and 
#boolean operators like |, &, and ! (which can all be used for filtering), you 
#can also do stuff like: 
nov_dec <- filter(flights, month %in% c(11, 12))
#where x %in% y filters for rows where x matches a value in y 
#If you want to determine if a value is missing, use is.na(): 
x <- NA 
is.na(x)
#> [1] TRUE 
#note that filter() only includes rows where the expresion evaluates to true, 
#so to preserve NA's you must ask for this explicitly
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
#> # A tibble: 1 × 1
#>       x
#>   <dbl>
#> 1     3
filter(df, is.na(x) | x > 1) 
#> # A tibble: 2 × 1
#>       x
#>   <dbl>
#> 1    NA
#> 2     3 

#5.2.4 Exercises

#1) Find all flights that

    #Had an arrival delay of two or more hours 
(filter(flights, arr_delay >= 120)) 
    #Flew to Houston (IAH or HOU) 
(filter(flights, dest %in% c("IAH", "HOU"))) 
    #Were operated by United "UA", American "AA", or Delta "DL"  
(filter(flights, carrier %in% c("UA", "AA", "DL")))  
    #Departed in summer (July, August, and September) 
(filter(flights, month %in% c(9, 8, 7))) 
    #Arrived more than two hours late, but didn’t leave late
(filter(flights, arr_delay > 120 & dep_delay <=0))
    #Were delayed by at least an hour, but made up over 30 minutes in flight 
(filter(flights, dep_delay >= 60 & dep_delay - arr_delay > 30))  
    #Departed between midnight and 6am (inclusive) 
(filter(flights, dep_time %% 2400 %in% 0000:0600)) 

#2) Another useful dplyr filtering helper is between().
#What does it do? Can you use it to simplify the code needed to answer the previous challenges? 
#yes, it operates similarly to the : operator in the form of between(variable, min, max) 

#3) How many flights have a missing dep_time?
#What other variables are missing? What might these rows represent? 
(filter(flights, is.na(dep_time))) 

#4) Why is NA ^ 0 not missing? Why is NA | TRUE not missing?
#Why is FALSE & NA not missing? Can you figure out the general rule?
#(NA * 0 is a tricky counterexample!) 
# everything here can be defined even when the other value (NA) is unknown 

#arrange() will order column names in the order specified
(arrange(flights, year, month, day)) 
#you can arrange a column in descending order using desc() 
(arrange(flights, desc(dep_delay))) 
#regardless of if desc() is used, NA's are always put at the end 

#5.3.1 Exercises
#1) How could you use arrange() to sort all missing values to the start?
#(Hint: use is.na()). 
#The answer is as follows (I dont think its possible to solve this withoug looking) 
(arrange(flights, desc(is.na(dep_time)), dep_time)) 

#2) Sort flights to find the most delayed flights. Find the flights that left earliest.
(arrange(flights, desc(dep_delay)))  
(arrange(flights, dep_delay))  

#3) Sort flights to find the fastest (highest speed) flights.
(arrange(flights, desc(distance/air_time))) 

#4) Which flights travelled the farthest? Which travelled the shortest?
#same kind of idea, Im going to skip this for now 

#select() can be used to specify the columns to use 
select(flights, year, month, day) 
#select all columns b/w year and day (inclusive)
select(flights, year:day)
#select all columns except those b/w year and day (inclusive)   
select(flights, -(year:day))
#available helper functions: 
#   1) starts <- with("abc"): matches names that begin with “abc” 
#   2) ends <- with("xyz"): matches names that end with “xyz”
#   3) contains("ijk"): matches names that contain “ijk”
#   4) matches("(.with("xyz"): matches names that end with “xyz”
#   3) contains("ijk"): matches names that contain “ijk”
#   4) matches("(.)\\1"): selects variables that match a regular expression.
#      This one matches any variables that contain repeated characters.
#      You’ll learn more about regular expressions in strings) 
#   5) num <- range("x", 1:3): matches x1, x2 and x3

#select() can be used to rename columns, but it drops all columns not mentioned
#rename() also can rename, but it will not drop unmentioned columns
rename(flights, tail <- num = tailnum)
#use the everything() helper to move specific variables to the front of the dataframe 
select(flights, time <- hour, air <- time, everything())

#5.4.1. Exercises 
#1) Brainstorm as many ways as possible to select dep <- time, dep <- delay, arr <- time, and arr <- delay from flights. 
#I would just re-read the chapter section instead - too long 

#2) What happens if you include the name of a variable multiple times in a select() call?
(select(flights, year, year))  
#it doesn't look like anything odd happens - the book notes this allows for the use of the everything() helper

#3) What does the any_of() function do? Why might it be helpful in conjunction with this vector? 
vars <- c("year", "month", "day", "dep_delay", "arr_delay") 
#it can be used to select the data in the string array using select(any_of(vars)) 

#4) Does the result of running the following code surprise you?
#How do the select helpers deal with case by default? How can you change that default? 
select(flights, contains("TIME")) 
#they have a default of ingnore.case = TRUE, so I can change this to false if I want

#mutate() will add new columns to the end of your dataset 
flights <- sml <- select(flights, 
                        year:day, 
                        ends_with("delay"), 
                        distance, 
                        air_time
                        )
mutate(flights_sml,
        gain = dep_delay - arr_delay,
        speed = distance / air_time * 60
      )
#> # A tibble: 336,776 × 9
#>    year month   day dep <- delay arr <- delay distance air <- time  gain speed
#>   <int> <int> <int>     <dbl>     <dbl>    <dbl>    <dbl> <dbl> <dbl>
#> 1  2013     1     1         2        11     1400      227    -9  370.
#> 2  2013     1     1         4        20     1416      227   -16  374.
#> 3  2013     1     1         2        33     1089      160   -31  408.
#> 4  2013     1     1        -1       -18     1576      183    17  517.
#> 5  2013     1     1        -6       -25      762      116    19  394.
#> 6  2013     1     1        -4        12      719      150   -16  288.
#> # … with 336,770 more rows

#note that you can refer to columns you just created in prior lines in later lines 
mutate(flights_sml,
         gain = dep_delay - arr_delay,
           hours = air_time / 60,
           gain_per_hour = gain / hours
           )
#I dont know why the formating is so fucked up 

#to keep only the new values just created, use transmute() 
transmute(flights,
            gain = dep_delay - arr_delay,
              hours = air_time / 60,
              gain_per_hour = gain / hours
              )
#> # A tibble: 336,776 × 3
#>    gain hours gain <- per <- hour
#>   <dbl> <dbl>         <dbl>
#> 1    -9  3.78         -2.38
#> 2   -16  3.78         -4.23
#> 3   -31  2.67        -11.6 
#> 4    17  3.05          5.57
#> 5    19  1.93          9.83
#> 6   -16  2.5          -6.4 
#> # … with 336,770 more rows

#5.5.1 Exercises
#1) Currently dep_time and sched_dep <- time are convenient to look at, but hard 
#to compute with because they’re not really continuous numbers. 
#Convert them to a more convenient representation of number of minutes since midnight. 
(transmute(flights, dep_time = (((dep_time %/% 100) * 60) + (dep_time %% 100)), 
                    sched_dep_time = ((sched_dep_time %/% 100) * 60) + (sched_dep_time %% 100)) 
            )

#2) Compare air_time with arr_time - dep_time. What do you expect to see?
#What do you see? What do you need to do to fix it?  
#first Ill compare the two 
(transmute(flights, air_time, obs_air_time = arr_time - dep_time)) 
#values do not match, the observed values are larger. To fix this, I would 
