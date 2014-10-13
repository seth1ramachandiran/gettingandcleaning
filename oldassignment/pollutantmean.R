'pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  values <- numeric(0)
  for(i in id) {
    monitor <- read.csv(paste0(directory,
                               '/',
                               sprintf('%03d', i), # add leading zeros if needed
                               '.csv'),
                        colClasses=c('Date', 'numeric', 'numeric', 'integer'))
    pollutant.values <- monitor[[pollutant]]
    values <- c(values, pollutant.values) 
    print(length(pollutant.values))
    print(length(values))
    print(i)
    
  }
  mean(values, na.rm=TRUE)
}

