The code in [run_analysis.R](run_analysis.R) performs the processing of source dataset described [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) into the output dataset described [here](CodeBook.md). Steps of the processing:

* Reading the source datasets
* Adding subject and activity fields to the main table
* Merging test and training datasets
* Using regex to find the variables that represent std dev and mean of the observations, and extracting only those variables at the same time renaming them according to the source feature names
* Replacing activity ID with activity names
* Writing out the first dataset
* Grouping and summarizing the first dataset to produce the second dataset. Each variable is summarized separately, and is then assigned a column name in the output
* Writing out second dataset
