DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS offered;
DROP TABLE IF EXISTS enroll;
CREATE TABLE course( course_name  text, units integer);
INSERT INTO course VALUES ('cse8a',4);
CREATE TABLE offered( course_name  text, quarter text);

INSERT INTO offered VALUES ('cse8a','SP2015');
INSERT INTO offered VALUES ('cse8a','SP2016');

CREATE TABLE enroll(section_id integer, course_name  text, pid integer);

INSERT INTO enroll VALUES (1,'cse8a',10);
INSERT INTO enroll VALUES (1,'cse8a',11);


SELECT c.*, o.*, e.*
FROM course c
inner join offered o
	on c.course_name = o.course_name
inner join enroll e
	on o.course_name = e.course_name
where e.pid = 10

DROP TABLE IF EXISTS cate_degree;
DROP TABLE IF EXISTS degree;
DROP TABLE IF EXISTS enrolled;
DROP TABLE IF EXISTS catList;
CREATE TABLE cate_degree( cate_name  text, units integer, degree_name text, degree_type text);

INSERT INTO cate_degree VALUES ('lower',60, 'cs', 'BS');
INSERT INTO cate_degree VALUES ('upper',50, 'cs', 'BS');
INSERT INTO cate_degree VALUES ('technical',16, 'cs', 'BS');
INSERT INTO cate_degree VALUES ('lower',45, 'me', 'BS');
INSERT INTO cate_degree VALUES ('lower',30, 'phil', 'BS');

CREATE TABLE degree( degree_name  text, degree_type text, units integer);

INSERT INTO degree VALUES ('cs','BS', 100);
INSERT INTO degree VALUES ('cs','MS', 80);
INSERT INTO degree VALUES ('me','BS', 90);
INSERT INTO degree VALUES ('phil','BS', 70);

CREATE TABLE enrolled(section_id integer, course_name  text, pid integer, units integer, quarter text);

INSERT INTO enrolled VALUES (1,'cse8a',10, 4, 'SP14');
INSERT INTO enrolled VALUES (1,'cse8a',11, 4, 'SP14');
INSERT INTO enrolled VALUES (2,'cse8b',11, 4, 'SP14');
INSERT INTO enrolled VALUES (3,'cse12',10, 4, 'SP14');
INSERT INTO enrolled VALUES (4,'cse15l',10, 2, 'FA15');
INSERT INTO enrolled VALUES (5,'cse132',10, 4, 'FA15');


CREATE TABLE catList( cate_name text, course text, degree_name text, degree_type text);

INSERT INTO catList VALUES ('lower','cse8a', 'cs', 'BS' );
INSERT INTO catList VALUES ('lower','cse8b', 'cs', 'BS');
INSERT INTO catList VALUES ('lower','cse12', 'me', 'BS');
INSERT INTO catList VALUES ('lower','cse15l', 'cs', 'BS');
INSERT INTO catList VALUES ('upper','cse132', 'cs', 'BS');
INSERT INTO catList VALUES ('upper','cse134', 'cs', 'BS');
INSERT INTO catList VALUES ('technical','cse134', 'cs', 'BS');


SELECT cate_name,((SELECT units FROM degree WHERE degree_name = 'cs') - (SELECT SUM(units) FROM enrolled WHERE PID = 10 AND course_name IN (SELECT course FROM catList WHERE degree_name = 'cs')))
AS units_for_degree FROM cate_degree
WHERE degree_name = 'cs' AND degree_type = 'BS';


with cate_require as ( SELECT c.cate_name, (c.units - (select sum(e.units)
  from enrolled e
  inner join catList cl on e.course_name = cl.course
  where cl.cate_name = c.cate_name and cl.degree_name = c.degree_name and e.pid = 10)) as units_left
from cate_degree c
where c.degree_name = 'cs')
select distinct ca.cate_name,
case when cr.units_left is NULL then ca.units else cr.units_left end
from cate_degree ca
inner join cate_require cr
on ca.cate_name = cr.cate_name;


SELECT c.cate_name,
case when (c.units - (select sum(e.units)
  from enrolled e
  inner join catList cl on e.course_name = cl.course
  where cl.cate_name = c.cate_name and cl.degree_name = c.degree_name and e.pid = 10)) is NULL then c.units
else (c.units - (select sum(e.units)
  from enrolled e
  inner join catList cl on e.course_name = cl.course
  where cl.cate_name = c.cate_name and cl.degree_name = c.degree_name and e.pid = 10)) end
from cate_degree c
where c.degree_name = 'cs'


DROP TABLE IF EXISTS cate_degree;
DROP TABLE IF EXISTS degree;
DROP TABLE IF EXISTS enrolled;
DROP TABLE IF EXISTS catList;
DROP TABLE IF EXISTS conList;
DROP TABLE IF EXISTS con_degree;
CREATE TABLE cate_degree( cate_name  text, units integer, degree_name text, degree_type text);

INSERT INTO cate_degree VALUES ('lower',60, 'cs', 'BS');
INSERT INTO cate_degree VALUES ('upper',50, 'cs', 'BS');
INSERT INTO cate_degree VALUES ('technical',16, 'cs', 'BS');
INSERT INTO cate_degree VALUES ('lower',45, 'me', 'BS');
INSERT INTO cate_degree VALUES ('lower',30, 'phil', 'BS');

CREATE TABLE degree( degree_name  text, degree_type text, units integer);

INSERT INTO degree VALUES ('cs','BS', 100);
INSERT INTO degree VALUES ('cs','MS', 80);
INSERT INTO degree VALUES ('me','BS', 90);
INSERT INTO degree VALUES ('phil','BS', 70);

CREATE TABLE enrolled(section_id integer, course_name  text, pid integer, units integer, quarter text);

INSERT INTO enrolled VALUES (1,'cse8a',10, 4, 'SP14');
INSERT INTO enrolled VALUES (1,'cse8a',11, 4, 'SP14');
INSERT INTO enrolled VALUES (2,'cse8b',11, 4, 'SP14');
INSERT INTO enrolled VALUES (3,'cse12',10, 4, 'SP14');
INSERT INTO enrolled VALUES (4,'cse15l',10, 2, 'FA15');
INSERT INTO enrolled VALUES (5,'cse132',10, 4, 'FA15');
INSERT INTO enrolled VALUES (6,'cse167',10, 4, 'FA15');
INSERT INTO enrolled VALUES (7,'cse165',10, 4, 'FA15');
INSERT INTO enrolled VALUES (8,'cse169',10, 4, 'WI16');


CREATE TABLE catList( cate_name text, course text, degree_name text, degree_type text);

INSERT INTO catList VALUES ('lower','cse8a', 'cs', 'BS' );
INSERT INTO catList VALUES ('lower','cse8b', 'cs', 'BS');
INSERT INTO catList VALUES ('lower','cse12', 'me', 'BS');
INSERT INTO catList VALUES ('lower','cse15l', 'cs', 'BS');
INSERT INTO catList VALUES ('upper','cse132', 'cs', 'BS');
INSERT INTO catList VALUES ('upper','cse134', 'cs', 'BS');
INSERT INTO catList VALUES ('technical','cse134', 'cs', 'BS');

CREATE TABLE conList( con_name text, course text);

INSERT INTO conList VALUES ('database','cse132');
INSERT INTO conList VALUES ('database','cse132a');
INSERT INTO conList VALUES ('graphics','cse167');
INSERT INTO conList VALUES ('graphics','cse168');
INSERT INTO conList VALUES ('graphics','cse169');
INSERT INTO conList VALUES ('graphics','cse165');


CREATE TABLE con_degree( con_name  text, units integer, degree_name text, degree_type text);

INSERT INTO con_degree VALUES ('database',8, 'cs', 'MS');
INSERT INTO con_degree VALUES ('graphics',12, 'cs', 'MS');



SELECT cate_name,((SELECT units FROM degree WHERE degree_name = 'cs') - (SELECT SUM(units) FROM enrolled WHERE PID = 10 AND course_name IN (SELECT course FROM catList WHERE degree_name = 'cs')))
AS units_for_degree FROM cate_degree
WHERE degree_name = 'cs' AND degree_type = 'BS';


with cate_require as ( SELECT c.cate_name, (c.units - (select sum(e.units)
  from enrolled e
  inner join catList cl on e.course_name = cl.course
  where cl.cate_name = c.cate_name and cl.degree_name = c.degree_name and e.pid = 10)) as units_left
from cate_degree c
where c.degree_name = 'cs')
select distinct ca.cate_name,
case when cr.units_left is NULL then ca.units else cr.units_left end
from cate_degree ca
inner join cate_require cr
on ca.cate_name = cr.cate_name;

SELECT distinct c.con_name
from con_degree cd
inner join conList c
on cd.con_name = c.con_name
inner join enrolled e
on c.course = e.course_name
where cd.degree_name = 'cs' and cd.degree_type = 'MS'
group by c.con_name
having cd.min_unit <= (select sum(units) from enrolled where course_id in (select course from conList where con_name = c.con_name)
