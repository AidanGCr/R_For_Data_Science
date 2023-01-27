library(tidyverse) 

?mpg

head(mpg)

# note here that plots will have to be saved manually and viewed that way
ggplot(data = mpg) + #creates empty plot
  geom_point(mapping = aes(x = displ, y = hwy)) #add a layer to the plot
ggsave('plot1-mpg.png') #saves the plot 

#template for a ggplot is as follows: 
#ggplot(data = <DATA>) + 
  #<GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

#3.2.4 Exercises
#1 Run ggplot(data = mpg). What do you see?
ggplot(data = mpg) 
ggsave('3.2.4.Ex.1.png')
#gives a blank figure

#2 How many rows are in mpg? How many columns?
mpg
#the mpg data frame gives 234 x 11 as its size

#3 What does the drv variable describe? Read the help for ?mpg to find out 
?mpg
#from the documentation: "drv the type of drive train, where f = front-wheel drive, r = rearwheel drive, 4 = 4wd"

#4 Make a scatterplot of hwy vs cyl.
ggplot(data = mpg) +
    geom_point(mapping = aes(x = hwy, y = cyl))
ggsave('3.2.4.Ex.4.png')

#5 What happens if you make a scatterplot of class vs drv? Why is the plot not useful? 
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = class, y = drv)) 
ggsave('3.2.4.Ex.5.png')

#showing how aesthetics can be used as another method of displaying data
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) #color adds aesthetic
ggsave('plot2-aesthetic.png') 
#other aesthetics include size, shape, alpha 

#aesthetics can also be set manually. For example: 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
ggsave('plot3-blue.png')
#note that it goes outside of the aes function 

#3.3.1 Exercises
#1 What’s gone wrong with this code? Why are the points not blue?
# ggplot(data = mpg) + 
  #geom_point(mapping = aes(x = displ, y = hwy, color = "blue")) 
# As mentioned above, "blue" must be outside the aes function


#2 Which variables in mpg are categorical? Which variables are continuous? 
#(Hint: type ?mpg to read the documentation for the dataset). 
#How can you see this information when you run mpg? 
# I feel the answer is self-explanatory 

#3 Map a continuous variable to color, size, and shape. 
#How do these aesthetics behave differently for categorical vs. continuous variables?
#mapping to color
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = cty))
ggsave('3.3.1.Ex.3-1.png')

#mapping to size
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, size = cty))  
ggsave('3.3.1.Ex.3-2.png')

#mapping to shape - note this will not work 
#ggplot(data = mpg) + 
#    geom_point(mapping = aes(x = displ, y = hwy, shape = cty))  
#ggsave('3.3.1.Ex.3-3.png')

#this will work - though we get a warning because only 6 shapes will be mapped 
#at a time
#ggplot(data = mpg) + 
#    geom_point(mapping = aes(x = displ, y = hwy, shape = trans))  
#ggsave('3.3.1.Ex.3-4.png')

#4 What happens if you map the same variable to multiple aesthetics? 
 ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, size = cty, color = cty))  
ggsave('3.3.1.Ex.4.png')
#it seems to work fine

#5 What does the stroke aesthetic do? What shapes does it work with? 
#(Hint: use ?geom_point)   
?geom_point 
vignette("ggplot2-specs") 
#from these docs, it seems like stroke alters the width of various shapes with 
#empty innards. So, I think only hollow shapes can use stroke. 

#6 What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)? 
#Note, you’ll also need to specify x and y.
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = cty > 18))  
ggsave('3.3.1.Ex.6.png') 
#it seems like R will color the points whether or not they pass the boolean check 

#facets can also be used to section figures by a discrete variable 
#first argument to facet_wrap() must be a formula data structure created via the ~ operator
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
ggsave('plot4-facets.png') 

#to facet on two variables: 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
ggsave('plot5-twofacets.png') 
#note that 'drv ~ cyl' is also a forumla 
#avoid faceting in the x or y axis by using a . 
#for example '. ~ cyl' or 'drv ~ .'

#3.5.1 Exercises
#1 What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty)
ggsave('3.5.1.Ex.1.png') 
#it seems to work, but you get a facet for each value of the continuous set

#2 What do the empty cells in plot with facet_grid(drv ~ cyl) mean? 
#How do they relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
ggsave('3.5.1.Ex.2.png') 
#I would assume it is the case that none of the cars fit those squares' criteria 
#This is confirmable via the plot saved above

#3 What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggsave('3.5.1.Ex.3-1.png') 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
ggsave('3.5.1.Ex.3-2.png') 
#These plots should change whether the faceting happes in the x or y directions, 
#meaning columns or rows. First dot is by columns, second is by rows

#4 Take the first faceted plot in this section: 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
ggsave('3.5.1.Ex.4.png')
#What are the advantages to using faceting instead of the colour aesthetic?
#What are the disadvantages? How might the balance change if you had a larger dataset?
#I feel the first part is self explanatory. The balance will change to the colors in a larger dataset 

#5 Read ?facet_wrap. What does nrow do?
#What does ncol do? What other options control the layout of the individual panels?
#Why doesn’t facet_grid() have nrow and ncol arguments?
#Again, pretty self self-explanatory

#6 When using facet_grid() you should usually put the variable with more unique levels in the columns. Why? 
#For readability purposes. 

#change the geometric objects used to plot via the geom functions
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
ggsave('plot6-point.png') 

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggsave('plot7-smooth.png')

#not all aesthetics work for every geom, but geoms all take mappings, for example 
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
ggsave('plot8-linetypes.png') 

#using group instead of color or linetype will prevent creation of a legened
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
ggsave('plot9-samelooklines.png') 

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )
ggsave('plot10-blockedlegend.png') 

#multiple geoms can be shown at the same time 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy)) 
ggsave('plot11-multiplegeoms.png') 

#avoid code duplication by passing mappings to ggplot itselo
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggsave('plot12-noduplication.png')

#mappings in the gglpot function can be overwritten by local mappings in the geom functions 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
ggsave('plot13-localmapping.png')

#even data can be overwritten within geom_smooth
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
ggsave('plot14-localdata.png') 
#note that the the 'se' option turns on and off confidence intervals 

#3.6.1 Exercises
#1 What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
# geom_line(), geom_boxplot(), geom_area()

#2 Run this code in your head and predict what the output will look like.
#Then, run the code in R and check your predictions. 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
ggsave('3.6.1.Ex.2.png') 
#I predict a plot of displ vs. hwy (on the x and y). First, a scatter plot colored
#by drv. Then a multiple smooth line plots for each drv, without confidence intervals.
#I was correct. 

#3 What does show.legend = FALSE do? What happens if you remove it?
#Why do you think I used it earlier in the chapter? 
#It likely turns of legend creation and was used to demonstrate how 'group' worked

#4 What does the se argument to geom_smooth() do?
#It turns off confidence intervals 

#5 Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggsave('3.6.1.Ex.5-1.png') 

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
ggsave('3.6.1.Ex.5-2.png') 
#These figures will look the same 

#6 Recreate the R code necessary to generate the following graphs.(see book) 
#first plot 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point() + 
    geom_smooth(se = FALSE) 
ggsave('3.6.1.Ex.6-1.png') 
 
#second plot 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point() + 
    geom_smooth(se = FALSE, mapping = aes(group = drv)) 
ggsave('3.6.1.Ex.6-2.png') 

#third plot
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
    geom_point() + 
    geom_smooth(se = FALSE) 
ggsave('3.6.1.Ex.6-3.png') 

#fourth plot 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(color = drv)) + 
    geom_smooth(se = FALSE) 
ggsave('3.6.1.Ex.6-4.png') 

#fifth plot 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(color = drv)) + 
    geom_smooth(se = FALSE, mapping = aes(linetype = drv))   
ggsave('3.6.1.Ex.6-5.png') 

#sixth plot
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(fill = drv), shape = 21, color = "white", stroke = 3)
ggsave('3.6.1.Ex.6-6.png') 
#this approximates the figure I think 

#bar plots and other statistical plots calculate new values to plot for example: 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
ggsave('plot15-displayingcounts.png')
#the y-axis ("counts"), is not a value in the data set, but is calculated for the figures

#    1)bar charts, histograms, and frequency polygons bin your data and then plot bin counts, the number of points that fall in each bin.

#    2)smoothers fit a model to your data and then plot predictions from the model.

#    3)boxplots compute a robust summary of the distribution and then display a specially formatted box.

#The values are calculated using a "stat" or statistical transformation
#Each default geom has a stat and each stat has a default geom
#As such, the same plot as above can be achieved by: 
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))
ggsave('plot16-usestat.png') 
#where stat_count() is the default stat used by geom_bar() to compute its counts
#Note that stat_count() also uses geom_bar() by default which is why it can do the plot on its own 
#Stats can be switched in and out as follows: 
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")
ggsave('plot17-swapstat.png')

#You can change the default mapping of stat generated values as well, for example: 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))
ggsave('plot18-changestatmap.png')

#You can use stat_summary() to summarize the transformations done by a stat: 
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  ) 
ggsave('plot19-statsummary.png') 

#3.7.1 Exercises
#1 What is the default geom associated with stat_summary()?
#How could you rewrite the previous plot to use that geom function instead of the stat function? 
#The default geom is geom_pointrange(). I would rewrite as follows:
ggplot(data = diamonds) +
  geom_linerange(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median, 
    stat ="summary"
  ) 
ggsave('3.7.1.Ex.1.png')
#actually a fairly difficult question, though this was taken from the internet 
#the ggplot documentation is sometimes lackingas it says the default geom is geom_pointrange()
#when it looks like its geom_linerange() 

#2 What does geom_col() do? How is it different to geom_bar()? 
#It uses stat_identity() instead of stat_count(), and so will plot values directly

#3 Most geoms and stats come in pairs that are almost always used in concert.
#Read through the documentation and make a list of all the pairs. What do they have in common? 
#Nope I dont want to do this. 

#4 What variables does stat_smooth() compute? What parameters control its behaviour?
#It is functionally identical to geom_smooth() but you should use the stat if you want to use 
#a non-standard geom 

#5 In our proportion bar chart, we need to set group = 1.
#Why? In other words what is the problem with these two graphs? 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop))) 
ggsave('3.7.1.Ex.5-1.png') 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop)))
ggsave('3.7.1.Ex.5-2.png')
#fixed graphs
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop), group = 1)) 
ggsave('3.7.1.Ex.5-3.png') 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop), group = color))
ggsave('3.7.1.Ex.5-4.png')  
# see this stackoverflow page for more information: 
#https://stackoverflow.com/questions/39878813/ggplot-geom-bar-meaning-of-aesgroup-1 

#fill and color are different in bar graphs because the boxes have fill and borders
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggsave('plot20-barcolor.png') 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
ggsave('plot21-barfill.png')

#fill can also be mapped to other variables where the bars will be stacked 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
ggsave('plot22-fillothervar.png') 
#how the bars are stacked is controlled by the "position adjustment" - in this case "stack" 
#1) "identity" will place the bars exactly where they fall in the context of the graph
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggsave('plot23-transparent.png') 

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
ggsave('plot24-nofill.png')

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(position = "identity")
ggsave('plot25-withfill.png') 

#2) "fill" works like stacking as seen above previously, making it so that 
#all the bars come to the same height, makign it easier to compare proportions 
#across group. Note that as seen in the last exercise section, the "group"
#aesthetic must be given a random value (like "1") to prevent the classic grouping 
#done by geom_bar whereby the x input is grouped 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
ggsave('plot26-fillexample.png')

#3) "dodge" puts overlapping objects next to each fct_other 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
ggsave('plot27-nooverlap.png') 

#Note that in scatter plots, values are rounded to show up on the plot and this
#can cause multiple points to overlap and not show up - called "overplotting". 
#The "jitter" position gives random noise to all points, making more withVisible 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
ggsave('plot28-jitter.png') 
#note you can also use the geom_jitter() to achieve the same thing

#3.8.1 Exercises 
#1) What is the problem with this plot? How could you improve it? 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() 
ggsave('3.8.1.Ex.1-1.png') 
#I would improve this by using position jitter 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_jitter() 
ggsave('3.8.1.Ex.1-2.png') 

#2) What parameters to geom_jitter() control the amount of jittering?
#it seems to be the width and height parameters

#3) Compare and contrast geom_jitter() with geom_count(). 
#it seems to be very similar but maps counts to area space 

#4) What’s the default position adjustment for geom_boxplot()?
#Create a visualisation of the mpg dataset that demonstrates it.
#The default position adjustment seems to be dodge2 
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
    geom_boxplot() 
ggsave('3.8.1.Ex.4.png') 

#The cartesian coordinate system is the default, but others exist too 
#Example: you want horizontal boxplots/you have labels that are too long - you can use coord_flip() 
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip() 
ggsave('plot29-fliped.png')

#Example: fixing aspect ratios for map data 
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
ggsave('plot30-incorrectnz.png') 

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()
ggsave('plot31-correctnz.png')  

#Example: turning a bar plot into polar coordinates (see book) 

#3.9.1 Exercises 
#1) Turn a stacked bar chart into a pie chart using coord_polar().
#taking the example of the stacked bar chart from earlier
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) +
  labs(x = NULL, y = NULL) + 
  coord_polar() 
ggsave('3.9.1.Ex.1.png') 

#2) What does labs() do? Read the documentation.
#labs is for labeling various parts of the plot

#3) What’s the difference between coord_quickmap() and coord_map()?
#quickmap is an approximation of map and preserves straight lines 

#4) What does the plot below tell you about the relationship between city and highway mpg?
#Why is coord_fixed() important? What does geom_abline() do?  
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
ggsave('3.9.1.Ex.4-1.png') 

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() 
ggsave('3.9.1.Ex.4-2.png') 
#coord_fixed() fixes the aspect ratio of the axes, and abline adds reference line 
#im not sure I understand why both were necessary here, but I am moving on

#Overall we have a new template
#ggplot(data = <DATA>) + 
  #<GEOM_FUNCTION>(
  #   mapping = aes(<MAPPINGS>),
  #   stat = <STAT>, 
  #   position = <POSITION>
  #) +
  #<COORDINATE_FUNCTION> +
  #<FACET_FUNCTION>
