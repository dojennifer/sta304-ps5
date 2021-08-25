# Recovery from COVID-19 in Toronto & the Role of One's Demographics and Environment
In this paper, I use a logistic regression model to examine the probabilities of one's likelihood for recovery from COVID-19 infection based on one's demographic and environment in Toronto, Canada. 

## Note on file structure
The "outputs" folder contains material created including the paper (PDF file), RMarkdown file used to generate the paper (PS5.Rmd), and the generated images from the RMarkdown file ("figures" folder). 

The "inputs" folder contains the raw data file used for this paper (i.e. contains COVID-19 case data from January 23 to December 28, 2020). The data file is available through the City of Toronto’s Open Data Portal: COVID-19 Cases in Toronto and is updated weekly.

The "scripts" folder contains the R script "plots" used to clean the dataset and produce the plots for the RMarkdown file. Please run this script prior to running the RMarkdown file in order to generate the report. 

## Suggested steps for recreating this report
1. Download the raw data file as provided in the "inputs" folder. Alternvatively, ensure any data taken from the City of Toronto's Open Data Portal: COVID-19 Cases in Toronto, corresponds to the dates considered in the paper. 
2. Run the data cleaning script that is provided in the "scripts" folder. In order for the scripts to run correctly, ensure that the filepath and file names in your code match with the ones on your system.
3. Ensure that the cleaned data files from step 2 are placed in the "outputs" folder.
4. In the "outputs" folder, you will find the 'paper' sub-folder. Run the .Rmd file there to generate the report.


