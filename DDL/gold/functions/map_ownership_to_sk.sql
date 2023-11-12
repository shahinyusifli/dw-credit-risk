CREATE OR REPLACE PROCEDURE gold.map_ownership_id_to_sk(p_home_ownership character varying(256), OUT p_sk integer)
 LANGUAGE plpgsql
AS $$
BEGIN
  -- Your logic here
  SELECT sk INTO p_sk FROM dev.gold.dim_ownership WHERE home_ownership = p_home_ownership;
END;
$$
