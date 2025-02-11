library(dplyr)
library(purrr)



# Codebook with all possible response values and definitions
cb <- data.frame(
  val = c(1:5, 9),
  defn = paste("answer", c(1:5, 9))
)



# Convert `val` to factor
cb$val <- factor(cb$val, levels = sort(cb$val))



# Create data (one question only)
df <- data.frame(q1 = sample(cb$val, 100, replace = TRUE))



# Create data with unrepresented values
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



