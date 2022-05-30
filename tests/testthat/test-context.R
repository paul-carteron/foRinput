test_that("Logical equivalence", {
   x <- TRUE
   expect_equal(x, TRUE)
})

test_that("Numerical equivalence", {
   x <- 1
   expect_equal(x, 1)
})

test_that("Character equivalence", {
   x <- "pouet"
   expect_equal(x, "pouet")
})
