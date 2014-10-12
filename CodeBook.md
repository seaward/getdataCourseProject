---
title: "Analyzed accelerometer data from Samsung Galaxy S"
author: "Seaward Chen"
date: "Tuesday, September 16, 2014"
output: html_document
---

Run ```{r}run_analysis``` to generate tidy data from collected accelerometer data from Samsung Galaxy S.

The accelerometer data is here: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. Download it to working directory, unzip it, then run ```{r}run_analysis``` to generate tidy datasets.

First we get `data.frame` `ds`, is the data selected from accelerometer dataset, which include all sd and mean variables; distilled from `ds`, `dsMean` has the mean of all sd and mean variables by subject and activity.
