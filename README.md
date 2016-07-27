CFA Exam Score Estimation
=========================

Since CFA Institute doesn't release the exact exam score we have to estimate the exact score with the provided ranges (<=50%, 51%-70%, >70%) for each topic.
Although I don't really care about my exact score as long as I passed, it is a good educational project which also shows the simplicity of Monte Carlo sampling. Please don't take this too serious, this was all done just for fun in about two hours.

### Link

[CFA Exam Score Estimation](https://lukstei.shinyapps.io/cfa-exam-score-estimation/)

### Methodology

We assume a discrete uniform distribution for each topic (i.e. each topic score within the range has the same probablity, for example for the topic Economics which has a maximum of 24 Points, if you got 51%-70% in this topic, we assume 13, 14, 15 and 16 all have a probablity of 25%). We produce samples of this distribution for each category, and the we sum up all categories and plot a histogram of the samples. This is also a good visual example of the Central Limit Theorem, which says the sum of **any** independent random variable will be normal distributed, as the number of summands go to infinty. As we can see, the sum of 10 uniform distributed variables already looks approximately like a normal distribution. 

### How to run it locally

1) Install RStudio and download the source code
2) Open app.R
3) Install the required packages (shiny, shinydashboard, ggplot2)
4) Click 'Run app'

### Who

This was done by [Lukas Steinbrecher](https://lukstei.com), if you have questions feel free to contact me.

### Disclaimer

This app is not affiliated with CFA Institute.

### License

MIT