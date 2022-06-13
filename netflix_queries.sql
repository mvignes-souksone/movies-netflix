Analysis netflix SQL queries

create table moviedata as (select T1.id, T1.type, T1.title, cast(T1.release_year as char(4)), T1.imdb_score, T1.production_countries, T2.person_id, T2.name, T2.role from titles T1 inner join credits T2 on T1.id = T2.id);

create table titlesf as (select *, cast(release_year as char(4)) as release_yearf from titles);


select count(distinct T1.title) from titles T1 left join credits T2 on  T1.id = T2.id where T2.id is null;

select count(distinct T1.person_id) from credits T1 left join titles T2 on  T1.id = T2.id where T2.id is null;

