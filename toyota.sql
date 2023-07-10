SELECT *
 FROM portfolio_project.toyota_price;
--------------------------------------------------------------------------
 -- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY make,
				 mileage,
				 Price,
				 body,
				 accident_status
				 ORDER BY
					year
					) row_num

From portfolio_project.toyota_price
-- order by make
)

Select *
From RowNumCTE
Where row_num > 1
Order by model;

SELECT *
 FROM portfolio_project.toyota_price;
 ---------------------------------------------------------------------------------
 -- calculating car_age difference
 SELECT year, 2022-year AS Car_age
 FROM portfolio_project.toyota_price;
 ALTER TABLE portfolio_project.toyota_price
ADD Car_age integer;
UPDATE portfolio_project.toyota_price
SET Car_age =2022-year;
 ------------------------------------------------------------------------------------
 -- creating car age status column
SELECT car_age,
IF(Car_age > 3, 'OLD', 'NEW') As Car_Status
FROM portfolio_project.toyota_price; 
ALTER TABLE portfolio_project.toyota_price
ADD Car_status VARCHAR(255);
UPDATE portfolio_project.toyota_price
SET Car_status =IF(Car_age > 3, 'OLD', 'NEW');