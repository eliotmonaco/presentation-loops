# Part 1: Write code to solve the problem once. No loop yet. In this step, we
# will
#  - create responses for a single survey question in a dataframe
#  - create a codebook that has all possible responses to the survey question
#  - write code to summarize those results (this is what will become a loop in
#    part 2)



library(dplyr)
library(purrr)



# Codebook with all possible response values and definitions
cb <- data.frame(
  val = c(1:5, 9),
  defn = paste("answer", c(1:5, 9))
)



# Convert `cb$val` to factor
cb$val <- factor(cb$val, levels = sort(cb$val))



# Create data (one question only)
df <- data.frame(q1 = sample(cb$val, 100, replace = TRUE))



# Adjust data so that a codebook value is unrepresented (the goal is to count
# all possible values, even if some don't appear in the results)
df <- data.frame(q1 = sample(cb$val[1:5], 100, replace = TRUE))



# Convert all values to factors (necessary for `count()` with `.drop = FALSE`)
df$q1 <- factor(df$q1, levels = sort(cb$val))



# Count values
df2 <- df |>
  count(q1, .drop = F)



# Join the definition from the codebook
df2 <- df2 |>
  left_join(cb, by = c("q1" = "val")) |>
  relocate(defn, .after = q1)



df2



