library(dplyr)
library(ggplot2)

## Load datasets
migrant <- read.csv("/home/agar/OneDrive/Documents/Library/Datasets/SYB61_T04_International Migrants and Refugees.csv", skip = 1, stringsAsFactors = F)
pop <- read.csv("/home/agar/OneDrive/Documents/Library/Datasets/SYB61_T02_Population, Surface Area and Density.csv", skip = 1, stringsAsFactors = F)

migrant %>%
  group_by(Year) %>%
    summarise(n())
pop %>%
  group_by(Year) %>%
  summarise(n())

## year 2015 had the most entries for both datasets

mig <- select(migrant, X, Year, Series, Value, Footnotes) %>%
          filter(Series == "International migrant stock: Both sexes (number)", Year == 2015) %>%
            select(X, Year, Value, Footnotes) %>%
              arrange(desc(Value))

pop2 <- select(pop, X, Year, Series, Value, Footnotes) %>%
          filter(Series == "Population mid-year estimates (millions)", Year == c(2015)) %>%
            select(X, Year, Value, Footnotes) %>%
              arrange(desc(Value))

x <- merge(mig, pop2, by.x = "X", by.y = "X")
x <- x[,-c(2,4,5,7)]
names(x)[c(2, 3)] <- c("Migrnt_stck_mil", "Ppl_mil")
x$Migrnt_stck_mil <- as.numeric(gsub(",", "", x$Migrnt_stck_mil))/1000000
g <- ggplot(x, aes(y = log(Migrnt_stck_mil), Ppl_mil))
g + geom_point() + geom_smooth(method = "loess", formula = 'y~x')
