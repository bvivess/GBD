--
ALTER TABLE customers ADD marital_status_id VARCHAR(1);

--
UPDATE TABLE customers c1
SET marital_status_id = (SELECT marital_status_id FROM mst_x_cus c2 WHERE c1.customer_id = c2.customer_id);

ALTER TABLE customers ADD CONSTRAINT MST_CUS_FK FOREIGN KEY (marital_status_id) REFERENCES marital_status_tab(marital_status_id);

--
DROP TABLE mst_x_cus;





