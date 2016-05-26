caloriesByDistance <- function(distance = 0,
                                 grade = 0,
                                 weight = 0,
                                 cff = 1,
                                 tf = 0)
{
  library(dplyr)
  
  cb <- data.frame("distance" = seq(from = 0, to = distance, by = 0.01),
                     "grade" = grade,
                     "weight" = weight,
                     "cff" = cff,
                     "tf" = tf)
  if (grade >= -15 && grade < -10)
  {
    cb <- cb %>% mutate(calories = ((((-0.02 * grade) + 0.35) * weight + tf) * distance * cff))
  }
  else if (grade >= -10 && grade < 0)
  {
    cb <- cb %>% mutate(calories = ((((0.04 * grade) + 0.95) * weight + tf) * distance * cff))
  }
  else if (grade >= 0 && grade < 10)
  {
    cb <- cb %>% mutate(calories = ((((0.05 * grade) + 0.95) * weight + tf) * distance * cff))
  }
  else if (grade >= 10)
  {
    cb <- cb %>% mutate(calories = ((((0.07 * grade) + 0.75) * weight + tf) * distance * cff))
  }
  cb <- cb %>% mutate(totalCalories = max(calories))
  cb
}