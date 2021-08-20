## Match event dates group-by-group with the corresponding period starting dates
## using rolling join in data.table. If an event date is smaller than the
## earliest period beginning for that group then it gets NAs for the joined
## values.

library("data.table")

events <- data.table(id = c(rep(1, 5), rep(2, 3), rep(3, 4)),
                     date = as.Date(c("2017-02-05", "2017-03-02", "2017-03-16",
                         "2017-05-01", "2017-06-02", "2017-03-09", "2017-06-15",
                         "2017-08-01", "2017-01-25", "2017-04-10", "2017-07-04",
                         "2017-09-01")),
                     value = 1:12)
print(events)

periods <- data.table(start.date = as.Date(c("2017-02-01", "2017-03-01",
                          "2017-04-12", "2017-01-01", "2017-06-15",
                          "2017-02-02", "2017-06-01")),
                      id = c(1, 1, 1, 2, 2, 3, 3),
                      code = c("a", "b", "c", "a", "b", "a", "b"))
print(periods)

events[, rollDate := date]
periods[, rollDate := start.date]

matched <- periods[events, roll = TRUE, on = c("id", "rollDate")]

print(matched)

## note that nrow(matched) == nrow(events) is TRUE
