## Count the consecutive ones in a sequence of 0s and 1s.

set.seed(13)
v <- sample(c(0, 1), 20, replace = TRUE)

v_ <- (v == 1) * unlist(lapply(rle(v)$lengths, seq_len))
print(v)
print(v_)