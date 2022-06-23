-- Query 1

SELECT foo.paper_index,cited_paper_index,string_agg(CAST(Name as varchar),' , ') as Author ,publication_year,venue,title,abstract FROM (SELECT citation.referred_paper_id_fk as paper_index, citation.main_paper_id_fk as cited_paper_index,first_name || ' ' || last_name as name ,publication_year,venue,title,abstract FROM
(( paper
INNER JOIN citation
ON citation.main_paper_id_fk = paper.paper_id )
INNER JOIN publication_venue
ON publication_venue.publisher_id = publisher_id_fk)
INNER JOIN author
ON main_author_id_fk = author_id 
UNION
SELECT citation.referred_paper_id_fk as paper_index, citation.main_paper_id_fk as cited_paper_index, first_name || ' ' || last_name as name,publication_year,venue,title,abstract FROM
((( paper
INNER JOIN citation
ON citation.main_paper_id_fk = paper.paper_id )
INNER JOIN publication_venue
ON publication_venue.publisher_id = publisher_id_fk)
INNER JOIN co_author
ON paper.paper_id  = paper_id_fk)
INNER JOIN author
ON co_author_id_fk = author_id 
order by paper_index ASC  ) as foo
GROUP BY paper_index,cited_paper_index,publication_year,venue,title,abstract
order by paper_index ASC 
