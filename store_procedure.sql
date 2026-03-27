-- Store procedure para obtener el total de costos

#Creación del Store Procedure
CREATE PROCEDURE `chocolate_sales`.`getcosto`(IN cntry VARCHAR(50), OUT ctry varchar(50), out cts double )
BEGIN
	SELECT
		st.country,
		sum(sl.cost) as cost
		into ctry, cts 
	FROM chocolate_sales.sales sl
	INNER JOIN chocolate_sales.stores st on sl.store_id = st.store_id
	WHERE st.country = 'USA' #cntry 
	GROUP BY 1;
END 

#llamar al store_procedure
call chocolate_sales.getcosto('USA', @country_out, @costo_out);

select @country_out as country, @costo_out as costo;