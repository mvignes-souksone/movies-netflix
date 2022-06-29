Analysis netflix SQL queries

create table moviedata as (select T1.id, T1.type, T1.title, cast(T1.release_year as char(4)), T1.imdb_score, T1.production_countries, T2.person_id, T2.name, T2.role from titles T1 inner join credits T2 on T1.id = T2.id);

create table titlesf as (select *, cast(release_year as char(4)) as release_yearf from titles);

alter table moviedata 
	alter production_countries type text[] using string_to_array(production_countries, ',');


update moviedata set production_countries = replace(production_countries,']','') ;

update moviedata set production_countries = replace(production_countries,'[','') ;

create table moviedatafinal as (select t.id, t.type, t.title, t.release_year, t.imdb_score, u.production_countries, t.person_id, t.name, t.role 
from moviedata t cross join
     unnest(t.production_countries) u(production_countries));

update moviedatafinal SET production_countries = trim(production_countries)

update moviedatafinal SET production_countries = replace(production_countries, '''', '');


select count(distinct T1.title) from titles T1 left join credits T2 on  T1.id = T2.id where T2.id is null;

select count(distinct T1.person_id) from credits T1 left join titles T2 on  T1.id = T2.id where T2.id is null;

update titlesf set genres = replace(genres,']','') ;

update titlesf set genres = replace(genres,'[','') ;

alter table titlesf 
	alter genres type text[] using string_to_array(genres, ',');

create table titlesfinal as (select t.id, t.type, t.title, t.release_year, t.imdb_score, u.genres
from titlesf t cross join
     unnest(t.genres) u(genres));

update titlesfinal SET genres = trim(genres);

update titlesfinal SET genres = replace(genres, '''', '');

