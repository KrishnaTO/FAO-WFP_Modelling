library(dplyr)

pop_gro <- SYB60_T03_Population_Growth_Fertility_and_Mortality_Indicators[565:4978,]
pop_gro <- pop_gro[pop_gro$Series == "Population annual rate of increase (percent)" & pop_gro$Year == 2015,]

food <- wfpvam_foodprices
food <- food[food$pt_name == "Retail" & food$mp_year == 2015,]

food1 <- group_by(food, adm0_name, cm_name) %>%
  summarize(cur_name = paste(unique(cur_name)), 
            um_name = max(unique(um_name)), 
            "price" = round(mean(mp_price), digits = 2))

cm <- unique(sort(food1$cm_name))
cm <- as.matrix(strsplit(cm, split = c(" ")))
cm1 <- list()
for (i in c(1:304)) {
  cm1 <- rbind(cm1, unlist(cm[i])[1])  
}
cm1 <- unique(cm1)

summary(cm1)
group_by(food1, cm_name) %>%
  summarise("count" = n()) %>%
  arrange(desc(count))

categories <- data.frame(0,0,0,0,0)
names(categories) <- c("Grains", "Dairy", "Meat", "Vegetables", "Other")

categories$Vegetables <- c('Apples', 'Avocados', 'Bananas', 'Beans', 'Beans(mash)', 'Beetroots','Cabbage', 'Carrots', 'Cashew', 'Cassava', 'Cauliflower', 'Chickpeas', 'Chili', 'Groundnuts',  'Corn', 'Cowpeas', 'Cucumbers', 'Eggplants', 'Garlic', 'Guava', 'Lettuce','Mangoes','Onions', 'Oranges', 'Papaya', 'Passion', 'Peanut', 'Peas', 'Peppers', 'Plantains', 'Potatoes', 'Soybeans', 'Spinach', 'Squashes',  'Sweet Potato',  'Yam', 'Zucchini', 'Tomatoes')
'Fat', 'Fish', 'Labaneh', 'Livestock', 'Eggs', 'Meat', 'Pigeon', 'Poultry'
'Barley', 'Buckwheat', 'Bulgur','Cornstarch', 'Lentils', 'Maize', 'Millet', 'Noodles', 'Pasta', 'Pulses', 'Bread','Tortilla','Wheat', 'Rice', 'Sesame', 'Sorghum'
'Milk', 'Oil', 'Yogurt','Ghee', 'Cheese','Curd',  'Butter'
'Charcoal', 'Cocoa', 'Coffee',  'Sugar','Tea', 'Salt', 'Transport', 'Wage', 'Fuel', 'Water', 'Exchange', 'Fonio', 'Gari'





