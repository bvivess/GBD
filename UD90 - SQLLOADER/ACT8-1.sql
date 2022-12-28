DECLARE
    CURSOR c IS
            SELECT RTRIM(SUBSTR(texte,1,50)) nom,
                   RTRIM(SUBSTR(texte,51,50)) adreca,
                   RTRIM(SUBSTR(texte,101,15)) telefon,
                   RTRIM(SUBSTR(texte,116,15)) trestaurant
            FROM temporal;
	--
    r c%ROWTYPE;
    trscod  restaurants.res_trs_codi%TYPE;
BEGIN
    FOR r IN c LOOP
        BEGIN
            SELECT trs_codi INTO trscod 
			FROM trestaurants 
			WHERE trs_descripcio = r.trestaurant;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                INSERT INTO trestaurants (trs_descripcio) VALUES (r.trestaurant);
				--
                SELECT trs_codi INTO trscod FROM trestaurants WHERE trs_descripcio = r.trestaurant;
        END;
        --
        INSERT INTO restaurants (res_nom, res_adreca, res_telefon, res_trs_codi)
        VALUES ( r.nom, r.adreca, r.telefon, trscod);
    END LOOP;
END;