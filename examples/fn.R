summarize_results <- function(df, cb) {
  # Convert codebook response values to factors
  cb$val <- factor(sort(cb$val))

  # Convert question response values to factors
  df <- df |>
    mutate(across(everything(), ~ factor(.x, levels = sort(cb$val))))

  ls <- list()

  vars <- colnames(df)

  for (i in 1:length(vars)) {
    ls[[i]] <- df |>
      rename(val = vars[i]) |>
      count(
        val,
        name = paste(vars[i], "(n)"),
        .drop = F)
  }

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
}
