-- SOTA L'USUARI 'SYSTEM'

CREATE USER oe_10 IDENTIFIED BY oe_10; 
GRANT connect, resource TO oe_10;
--
CREATE USER oe_20 IDENTIFIED BY oe_20; 
GRANT connect, resource TO oe_20;
--
CREATE USER oe_30 IDENTIFIED BY oe_30; 
GRANT connect, resource TO oe_30;
--
GRANT SELECT, INSERT, UPDATE, DELETE ON oe.categories_tab TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON oe.product_information TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON oe.product_descriptions TO PUBLIC;


