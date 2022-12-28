-- SEMBLANT A L'ACT ACT6_3-5D.sql

-- UNA ALTRA MANERA MENYS ACCURADA SERIA:

DECLARE
	total_1 NUMBER;
	total_2 NUMBER;
BEGIN
	-- ES CONTEN ELS REGISTRES D'OE.product_information
	SELECT COUNT(*) INTO total_1 FROM product_information;
	-- ES CONTEN ELS REGISTRES D'OE_10.product_information + OE_20.product_information + OE_30.product_information 
	SELECT SUM(total) INTO total_2 FROM (
		 SELECT COUNT(*) total FROM OE_10.product_information
		UNION ALL
		 SELECT COUNT(*) FROM OE_20.product_information
		UNION ALL
		 SELECT COUNT(*) FROM OE_20.product_information
	);
	-- ES COMPAREN
	IF (total_1 != total_2) THEN
		DBMS_OUTPUT.PUT_LINE('ERROR, el nombre de PRODUCT_INFORMATION no coincideix');
	ELSE
		DBMS_OUTPUT.PUT_LINE('OK');
	END IF;
END;