CREATE OR REPLACE PROCEDURE dev.gold.map_member_id_to_sk(
  IN member_id INT,
  OUT member_sk INT
)
AS $$
BEGIN
  -- Your logic here
  SELECT sk INTO member_sk FROM dev.gold.dim_member WHERE id = member_id and is_valid=true;
END;
$$ LANGUAGE plpgsql;
