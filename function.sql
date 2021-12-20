-- Видаляє резльтат з таблиці результатів, которий має задану кількість очок

CREATE OR REPLACE FUNCTION del_points(point_arg int) RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN 
   DELETE FROM results 
   WHERE results.res_id IN 
      (SELECT results.res_id from results where results.points = point_arg);
END;
$$; 