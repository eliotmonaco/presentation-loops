source("examples/fn.R")


# Codebooks
cb1 <- data.frame(
  val = c(1:5, 9),
  defn = paste("answer", c(1:5, 9))
)

cb2 <- data.frame(
  val = 1:3,
  defn = c("yes", "no", "maybe")
)

cb3 <- data.frame(
  val = 1:2,
  defn = c("never", "always")
)

cb <- list(cb1, cb2, cb3)



# Data
q1 <- data.frame(
  q1.1 = sample(cb1$val[sample(1:6, 5)], 100, replace = TRUE),
  q1.2 = sample(cb1$val[sample(1:6, 5)], 100, replace = TRUE),
  q1.3 = sample(cb1$val[sample(1:6, 5)], 100, replace = TRUE)
)

q2 <- data.frame(
  q2.1 = sample(cb2$val, 100, replace = TRUE),
  q2.2 = sample(cb2$val, 100, replace = TRUE),
  q2.3 = sample(cb2$val, 100, replace = TRUE),
  q2.4 = sample(cb2$val, 100, replace = TRUE),
  q2.5 = sample(cb2$val, 100, replace = TRUE),
  q2.6 = sample(cb2$val, 100, replace = TRUE)
)

q3 <- data.frame(
  q3.1 = sample(cb3$val, 100, replace = TRUE),
  q3.2 = sample(cb3$val, 100, replace = TRUE),
  q3.3 = sample(cb3$val, 100, replace = TRUE),
  q3.4 = sample(cb3$val, 100, replace = TRUE)
)

data <- list(q1, q2, q3)


ls <- list()

for (i in 1:length(data)) {
  ls[[i]] <- summarize_results(data[[i]], cb[[i]])
}


