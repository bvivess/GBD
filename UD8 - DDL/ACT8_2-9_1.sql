-- STEP 1
CREATE TABLE manufacturers_tab(
	manufacturer_id   INT NOT NULL,
	manufacturer_name VARCHAR(100) NOT NULL,
	CONSTRAINT manufacturers_PK PRIMARY KEY (manufacturer_id)
);

-- STEP 2
Es posible crear un MANUFACTURER_ID = 0, MANUFACTURER_NAME='PENDIENTE ASIGNAR'
y relacionar todos los productos a este ID para luego dejar la relación
con el tipo NOT NULL.

Se descarta esta opción.

-- STEP 3
ALTER TABLE product_information 
	ADD manufacturer_id INT;

ALTER TABLE product_information ADD CONSTRAINT pro_man_FK
	FOREIGN KEY (manufacturer_id) REFERENCES manufacturer_tab(manufacturer_id);