WITH newEnroll as (SELECT * FROM class c
  INNER JOIN enroll_current e ON e.CLASS_ID = c.CLASS_ID)
CREATE FUNCTION check_limit() RETURNS trigger AS $check_limit$
DECLARE
  limit_ int8;
BEGIN
  limit_ int8 = (SELECT class.ENROLLMENT_LIMIT from class where class.CLASS_ID = NEW.CLASS_ID)
  IF (TG_OP = 'Insert') THEN
    IF EXISTS(
      SELECT * FROM OLD WHERE OLD.CLASS_ID = NEW.CLASS_ID
    )
    THEN
      IF (SELECT COUNT(*) FROM OLD WHERE OLD.CLASS_ID = NEW.CLASS_ID) >= limit_
      THEN RAISE EXCEPTION 'the class limit exceeded!';
      END IF;
    END IF;
  ELSE
    IF limit_ <= (SELECT COUNT(*) FROM OLD WHERE OLD.CLASS_ID = NEW.CLASS_ID)
    THEN RAISE EXCEPTION 'the class limit exceeded!';
    END IF;
  END IF;
  RETURN NEW;
END;
$check_limit$ LANGUAGE plpgsql;

CREATE TRIGGER check_limit BEFORE INSERT OR UPDATE ON enroll_current
    FOR EACH ROW EXECUTE PROCEDURE check_limit();
DROP trigger check_limit on enroll_current;
DROP FUNCTION check_limit();
