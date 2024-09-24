# Install and load the required packages
install.packages("sleeperapi")
install.packages("dplyr")
install.packages("ggplot2")

library(sleeperapi)
library(dplyr)
library(ggplot2)

# Step 1: Define the league ID and week
league_id <- "1131084017341890560"
week <- 3

# Step 2: Fetch detailed player matchups for Week 3
player_matchups <- get_weekly_matchups(league_id, type = "player")

# Step 3: Inspect the structure to check for the right columns
str(player_matchups)

# Step 4: Assuming the columns 'actual_points' and 'projected_points' exist, prepare the data
top_performers <- player_matchups %>%
  select(player_id, actual_points, projected_points) %>%
  mutate(over_achieve = actual_points - projected_points) %>%
  arrange(desc(over_achieve))

# Step 5: Plot the data
ggplot(top_performers, aes(x = reorder(player_id, over_achieve), y = over_achieve)) +
  geom_bar(stat = "identity", fill = "lightblue") +
  coord_flip() +
  labs(title = "Top Overachievers in Week 3",
       x = "Player ID",
       y = "Points Above Projection") +
  theme_minimal()
