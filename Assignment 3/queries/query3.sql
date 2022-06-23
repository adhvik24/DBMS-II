--Query 3

DRop table if exists temp1;
DRop table if exists temp2;

CREATE table temp1 as 
SELECT foo.paper_index,string_agg(CAST(Name as varchar),' , ') as Author ,publication_year,venue,title,abstract FROM (SELECT paper.paper_id as paper_index, first_name || ' ' || last_name as Name,publication_year,venue,title,abstract FROM
(paper
INNER JOIN publication_venue
ON publication_venue.publisher_id = publisher_id_fk)
INNER JOIN author
ON main_author_id_fk = author_id 
UNION
SELECT  paper.paper_id as paper_index, first_name || ' ' || last_name as Name,publication_year,venue,title,abstract FROM
(( paper
INNER JOIN publication_venue
ON publication_venue.publisher_id = publisher_id_fk)
INNER JOIN co_author
ON paper.paper_id  = paper_id_fk)
INNER JOIN author
ON co_author_id_fk = author_id 
order by paper_index ASC ) as foo
GROUP BY paper_index,publication_year,venue,title,abstract
order by paper_index ASC ;


CREATE table temp2 as
SELECT T1.referred_paper_id_fk as X , T2.main_paper_id_fk as Z
FROM citation T1, citation T2 
WHERE T1.main_paper_id_fk = T2.referred_paper_id_fk;


select paper_id_1,temp1.paper_index as paper_id_2,author_1,temp1.Author as Author_2, publication_year_1,temp1.publication_year as publication_year_2,venue_1,temp1.venue as venue_2,title_1,temp1.title as title_2,abstract_1,temp1.abstract as abstract_2  from (select temp1.paper_index as paper_id_1,temp1.Author as Author_1, temp1.publication_year as publication_year_1,temp1.venue as venue_1,temp1.title as title_1,temp1.abstract as abstract_1 , temp2.Z from temp1
INNER JOIN  temp2
ON temp1.paper_index = temp2.X) as temp3 
INNER JOIN temp1 
ON temp3.Z = temp1.paper_index
ORDER BY paper_id_1 ASC;