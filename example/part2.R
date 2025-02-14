# Part 2: Rewrite the code as a loop to produce the same outcome as in part 1,
# but for multiple survey questions. In this step, we will
#  - use the same codebook, but create a new dataframe of survey results with
#    multiple questions
#  - rework the code that summarized one question into a loop
#  - use a purrr function to convert the loop output, which is a list, to a
#    dataframe



library(dplyr)
library(purrr)



# Codebook with all possible response values and definitions
cb <- data.frame(
  val = c(1:5, 9),
  defn = paste("answer", c(1:5, 9))
)



# Convert `val` to factor
cb$val <- factor(cb$val, levels = sort(cb$val))



# Create data (multiple questions)
df <- data.frame(
  q1 = sample(cb$val[sample(1:6, 5)], 100, replace = TRUE),
  q2 = sample(cb$val[sample(1:6, 5)], 100, replace = TRUE),
  q3 = sample(cb$val[sample(1:6, 5)], 100, replace = TRUE),
  q4 = sample(cb$val[sample(1:6, 5)], 100, replace = TRUE),
  q5 = sample(cb$val[sample(1:6, 5)], 100, replace = TRUE)
)



# Convert all values to factors
df <- df |>
  mutate(across(everything(), ~ factor(.x, levels = sort(cb$val))))



# Create a list to accumulate loop results
ls <- list()



# Iterate over variable names in `df`
vars <- colnames(df)



# The loop
for (i in 1:length(vars)) {
  ls[[i]] <- df |>
    rename(val = vars[i]) |>        # <-- This line was not in part 1. It's here
    count(                          # because it will help to have the question
      val,                          # number in the count variable name.
      name = paste(vars[i], "(n)"), # <-- The `name` argument is new too. It's
      .drop = F)                    # what's needed to rename the count
}                                   # variable.



# Use `reduce()` to apply a join successively to list elements
df2 <- ls |>
  reduce(
    \(x, y) left_join(x, y, by = "val")
  )



# Join the definition from the codebook
df2 <- df2 |>
  left_join(cb, by = "val") |>
  relocate(defn, .after = val)



df2



