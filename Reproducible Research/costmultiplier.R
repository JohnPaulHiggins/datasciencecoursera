cost.multiplier <- function(x) {
  if (x == "") {
    0
  }
  else {
    switch(x,
           "b" =,
           "B" = 1000000000,
           "h" =,
           "H" = 100,
           "K" =,
           "k" = 1000,
           "m" =,
           "M" = 1000000,
           "?" =,
           "-" = 0,
           "+" = 1,
           10)
  }
}