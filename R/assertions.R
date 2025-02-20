# deluxe dogma:
# 1. no dependencies
# 2. individual scripts work independently
# 3. if a function takes a dataset, it must handle both data.frame and data.tables
# 4. public domain license (no one's going to court over an R package)

assert_equal = \(x, y, FUN=\(x) x) {
  if (FUN(x) != FUN(y))
    stop('not equal')
}
assert_equal_nrow = \(x, y) {
  assert_equal(FUN=nrow, x, y)
}
