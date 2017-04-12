for (i in pageRange) {
  # concatenate URL for each page
  uri <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=", q, "&page=", i, "&fl=pub_date&api-key=", api)
  d <- getURL(uri)
  res <- fromJSON(d,simplify = FALSE)
  dat <- append(dat, unlist(res$response$docs))  # convert the dates to a vector and append
}
# establish date range
dat.conv <- strptime(dat, format="%Y-%m-%d") # need to convert dat into POSIX format
daterange <- c(min(dat.conv), max(dat.conv))
dat.all <- seq(daterange[1], daterange[2], by="day") # all possible days

# aggregate counts for dates and coerce into a data frame
cts <- as.data.frame(table(dat))

# compare dates from counts dataframe with the whole data range
# assign 0 where there is no count, otherwise take count
# (take out PSD at the end to make it comparable)
dat.all <- strptime(dat.all, format="%Y-%m-%d")
# can't seem to be able to compare Posix objects with %in%, so coerce them to character for this:
freqs <- ifelse(as.character(dat.all) %in% as.character(strptime(cts$dat, format="%Y-%m-%d")), cts$Freq, 0)

plot (freqs, type="l", xaxt="n", main=paste("Search term(s):",q), ylab="# of articles", xlab="date")
axis(1, 1:length(freqs), dat.all)
lines(lowess(freqs, f=.2), col = 2)