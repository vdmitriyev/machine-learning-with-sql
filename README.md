### About

Collection of SQL scripts/queries that are targeting machine learning (data mining) algorithms directly inside database using only standardized SQL version. Significant part of SQL was reused from multiple sources, details can be found in "Credits/References" section. Please note then terms "machine learning" and "data mining" are used here interchangeably.

### Usage

It primary planed to be implemented and tested with [SQLite](https://sqlite.org/). As GUI for SQLite [SQLiteStudio](http://sqlitestudio.pl/) can be used. Start via "start.bat" and use following configurations: ``` .read configs.sql```

### CSV Based Import for SQLite (Example)

```
> .mode csv
> .import ../data/boston_housing_data.csv TBL_BOSTON_HOUSING_IMPORT
> SELECT COUNT (*) FROM TBL_BOSTON_HOUSING_IMPORT; -- must be 506
> .read ../data/TBL_BOSTON_HOUSING.sql
-- copy from import to real
> .read ../data/COPY_FROM_IMPORT_TBL.sql
> .save ml-with-sql.db
```

### SQL Based Import for SQLite (Example)

```
> .read ../data/TBL_BOSTON_HOUSING_DB_FULL.sql
```

### Dependencies

* [SQLite](https://sqlite.org/)

### Datasets

* [Boston Housing Data Set by UCI](https://archive.ics.uci.edu/ml/datasets/Housing)

### Credits/References

* [X] [SQL Linear Regression](http://mikemstech.blogspot.de/2013/07/sql-linear-regression.html)
* [ ] [Optimal two variable linear regression calculation](http://stackoverflow.com/questions/2799047/optimal-two-variable-linear-regression-calculation)
* [ ] [Single & Multiple Regression in SQL](http://sqldatamine.blogspot.de/2013/07/single-multiple-regression-in-sql.html)
* [ ] [K Means Clustering](http://sqldatamine.blogspot.de/2013/08/k-means-clustering.html)
* [ ] [Associated Items Using the Apriori Algorithm](http://sqldatamine.blogspot.de/2014/02/associated-items-using-apriori-algorithm.html)
* [ ] [Classification Using Naive Bayes](http://sqldatamine.blogspot.de/2013/07/classification-using-naive-bayes.html)
* [ ] [Outlier Detection with SQL Server by Stevan Bolton](https://multidimensionalmayhem.wordpress.com/category/diy-data-mining/outlier-detection-with-sql-server/)
* [ ] [In-Database Scoring of Random Forest Models built using R via SQL](https://gist.github.com/shanebutler/96f0e78a02c84cdcf558)
* [ ] [Integrating Fuzzy c-Means Clustering with PostgreSQL](http://mzym.susu.ru/papers/Miniakhmetov_SYRCoDIS-11.pdf)
* [ ] [SQL Database Primitives for Decision Tree Classifiers](http://fusion.cs.uni-magdeburg.de/pubs/classprim.pdf) by Kai-Uwe Sattler and Oliver Dunemann
