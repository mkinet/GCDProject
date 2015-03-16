fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- './data.zip'
download.file(fileurl,destfile = zipfile,method='curl')
dateDownloaded <- date()
unzip(zipfile)
