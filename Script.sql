CREATE TABLE test_point(
id int,
task int,
x numeric(2, 0),
y numeric(2, 0),
z numeric(2, 0)
);


alter table test_point add constraint id primary key(id);

select * from test_point;

create table task (
id serial primary key,
name varchar(100)
);

alter table test_point add foreign key (task) references task(id);

create index index_task on test_point (task, id);

insert into task values
(1,'task1');

insert into test_point values
(1,1,1,0,0),
(2,1,0,1,0),
(3,1,0,0,1);

select * from test_point where id = 2;

select tp.id, t.name, tp.x, tp.y, tp.z 
from test_point as tp 
join task as t on tp.task = t.id
where tp.id = 2;


-- Enable PostGIS (as of 3.0 contains just geometry/geography)
CREATE EXTENSION postgis;
-- enable raster support (for 3+)
CREATE EXTENSION postgis_raster;
-- Enable Topology
CREATE EXTENSION postgis_topology;
-- Enable PostGIS Advanced 3D
-- and other geoprocessing algorithms
-- sfcgal not available with all distributions
CREATE EXTENSION postgis_sfcgal;
-- fuzzy matching needed for Tiger
CREATE EXTENSION fuzzystrmatch;
-- rule based standardizer
CREATE EXTENSION address_standardizer;
-- example rule data set
CREATE EXTENSION address_standardizer_data_us;
-- Enable US Tiger Geocoder
CREATE EXTENSION postgis_tiger_geocoder;


alter table test_point add column geom geometry;

insert into test_point(geom) values
(POINT(x, y, z));


update test_point set  geom = st_geomfromtext('POINT('|| test_point.x||' '||test_point.y||' '||test_point.z||')');

select st_asgeojson(test_point.geom) from test_point; 










