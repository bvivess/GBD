-- STEP 1
CREATE TABLE status_tab( 
	status_id			INT NOT NULL,
	status_description	VARCHAR(30) NOT NULL,
	CONSTRAINT status_tab_pk PRIMARY KEY (status_id)
);

-- STEP 2
ALTER TABLE orders DROP CONSTRAINT order_status_ck;

-- STEP 3
-- Versión 1
INSERT INTO status_tab( status_id, status_description )
	SELECT DISTINCT order_status, 'sin descripcion' status_description -- que sigui l'usuari qui modifiqui el valor d'aquest atribut
	FROM orders;

-- Version 2
INSERT INTO status_tab( status_id, status_description )
	VALUES	(0, 'Not fully entered'),
			(1, 'Entered'),
			(2, 'Canceled - bad credit'),
			(3, 'Canceled - by customer'),
			(4, 'Shipped - whole order'),
			(5, 'Shipped - replacement items'),
			(6, 'Shipped - backlog on items'),
			(7, 'Shipped - special delivery'),
			(8, 'Shipped - billed'),
			(9, 'Shipped - payment plan'),
			(10, 'Shipped - paid');

-- STEP 4
ALTER TABLE orders RENAME COLUMN order_status TO status_id;
ALTER TABLE orders ADD CONSTRAINT ord_ost_fk
	FOREIGN KEY (status_id) REFERENCES status_tab(status_id);

