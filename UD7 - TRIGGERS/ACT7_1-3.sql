-- View
CREATE OR REPLACE VIEW VW_products(
	vw_product_id,	vw_product_name,	vw_product_description,
	vw_category_id,	vw_weight_class,	vw_warranty_period,
	vw_supplier_id,	vw_product_status,	vw_list_price,
	vw_min_price,	vw_catalog_url,
	vw_language_id,	vw_translated_name,	vw_translated_description
) AS
	SELECT 
		i.product_id,	i.product_name,		i.product_description,
		i.category_id,	i.weight_class,		i.warranty_period,
		i.supplier_id,	i.product_status,	i.list_price,
		i.min_price,	i.catalog_url,
		d.language_id,	d.translated_name,	d.translated_description
	FROM product_information i,  product_descriptions d
	WHERE d.product_id = i.product_id;
