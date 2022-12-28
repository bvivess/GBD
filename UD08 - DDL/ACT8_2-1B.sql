--
ALTER TABLE orders DROP CONSTRAINT ord_ost_fk;
ALTER TABLE orders RENAME COLUMN order_status_id TO order_status;

--
ALTER TABLE orders ADD CONSTRAINT order_status_CK CHECK order_status BETWEEN 0 AND 10;

--
DROP TABLE order_status_tab;


