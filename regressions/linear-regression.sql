--
-- THIS SQL SCRIPT REQURES TABLE "TBL_BOSTON_HOUSING"
--

-- creating table for coefficients
--DROP TABLE TBL_BOSTON_HOUSING_COEF;
DROP TABLE IF EXISTS TBL_BOSTON_HOUSING_COEF;
CREATE TABLE TBL_BOSTON_HOUSING_COEF(
    ID INTEGER PRIMARY KEY,
    a   DOUBLE,
    b   DOUBLE,
    r_r DOUBLE
);

-- variant 1
-- Originally developed by Mike Burr
-- This query calculates a linear regression
-- in the form y = a + bx and calculates
-- the correlation coefficient for the source data
-- according to the this formula http://2.bp.blogspot.com/-PPQWNlRlyTw/Udxp_XPOfcI/AAAAAAAAA4g/b6ASV50XYKg/s1600/ihgfeegb-749072.png

insert into TBL_BOSTON_HOUSING_COEF(a, b, r_r)
select a as 'a',
       b as 'b',
       -- Correlation coefficient
       (ss_xy * ss_xy)/ (ss_xx * ss_yy) as 'r_r'
from (
   -- In this inner query we calculate the parameters
   -- and the correlation coefficient for the linear model
   -- that we calculated

   select
      ((avg_yi * sum_xi_xi) - (avg_xi * sum_xi_yi )) /
      (sum_xi_xi-(n* avg_xi * avg_xi))
      as 'a',

      (sum_xi_yi - (n * avg_xi * avg_yi)) /
      (sum_xi_xi - (n * avg_xi * avg_xi))
      as 'b',

      sum_xi_xi - (n * avg_xi * avg_xi )
      as 'ss_xx',

      sum_yi_yi - (n * avg_yi * avg_yi )
      as 'ss_yy',

      sum_xi_yi - (n * avg_xi * avg_yi )
      as 'ss_xy'

   from (
      -- In this inner query, we build the
      -- variables used in the linear regression
      -- calculation

      select avg(y) as 'avg_yi',
             avg(x) as 'avg_xi',
             count(x) as 'n',
             sum(x*x) as 'sum_xi_xi',
             sum(y*y) as 'sum_yi_yi',
             sum(x*y) as 'sum_xi_yi',
             sum(x) as 'sum_xi'
      from (

         -- Insert source data query here
         -- Alias the x-variable column as 'x'
         -- Alias the y-variable column as 'y'
         SELECT RM as "x",
                PRICE as "y"
         FROM TBL_BOSTON_HOUSING
      ) as source_data
   ) as regression
) as final_parameters
;

-- creating table with fitted values
--DROP TABLE TBL_BOSTON_HOUSING_FITTED;
DROP TABLE IF EXISTS TBL_BOSTON_HOUSING_FITTED;
CREATE TABLE TBL_BOSTON_HOUSING_FITTED(
    ID INT,
    FITTED DOUBLE
);

-- Fitting all values and saving to another table
INSERT INTO TBL_BOSTON_HOUSING_FITTED
SELECT  data.ID,
        coef.a + coef.b * data.RM
FROM
    TBL_BOSTON_HOUSING_COEF as coef,
    TBL_BOSTON_HOUSING as data
WHERE coef.ID = 1;


-- Comparing real values with predicted (fitted) values and their difference.
SELECT
    predicted."FITTED",
    data."PRICE",
    (predicted."FITTED"- data."PRICE") as "DIFFERENCE"
FROM TBL_BOSTON_HOUSING_FITTED as predicted,
     TBL_BOSTON_HOUSING as data
WHERE data.ID = predicted.ID;

-- calculating "mean squared error"(MSE)
SELECT
    AVG((predicted."Fitted" - data."PRICE") * (predicted."Fitted" - data."PRICE")) as "MSE"
FROM TBL_BOSTON_HOUSING_FITTED as predicted,
     TBL_BOSTON_HOUSING as data
WHERE data.ID = predicted.ID;

-- TBL_BOSTON_HOUSING:
--  Linear equation for "RM" and "PRICE" will be as following: Y = (-34.6706207764) + 9.10210898 * X, with MSE equals to 43.6005517712

-- Variant 2 - http://sqldatamine.blogspot.de/2013/07/single-multiple-regression-in-sql.html

INSERT INTO TBL_BOSTON_HOUSING_COEF(a, b)
SELECT ybar - slope * xbar as "a_coef/intercept",
       slope as "b_coef"
  FROM (
           SELECT (sum(x * y) - (sum(x) * sum(y) / count(1) ) ) / (sum(x * x) - (sum(x) * sum(x) / count(1) ) ) slope,
                  avg(x) xbar,
                  avg(y) ybar
             FROM (
                      SELECT RM AS x,
                             PRICE AS y
                        FROM TBL_BOSTON_HOUSING
                  )
                  AS data
       );
