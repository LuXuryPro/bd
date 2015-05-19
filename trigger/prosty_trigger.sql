CREATE OR REPLACE TRIGGER TRIGGER1
BEFORE UPDATE ON GRA
for each row
begin
  insert into UPDATE_TABLE (nazwa,old_nazwa,timestamp,user_c) values (:new.nazwa,:old.nazwa,CURRENT_TIMESTAMP,(SELECT user FROM dual));
END;
/
