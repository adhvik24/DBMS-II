-- Query 5

DROP table if exists foo ;

Create table foo  as
(Select paper_id , co_author_id_fk as author_id
FROM paper
INNER JOIN co_author 
ON paper.paper_id = co_author.paper_id_fk
UNION
select paper_id,main_author_id_fk as author_id FROM paper) ;

DROP table if exists temp1;

CREATE table temp1 as 
select t1.paper_id as paper_index ,t1.author_id as author_id_1,t2.author_id as  author_id_2, concat(t1.author_id,' , ',t2.author_id) as pair 
from foo t1,foo t2
where t1.paper_id = t2.paper_id AND t1.author_id != t2.author_id AND t1.author_id < t2.author_id
GROUP BY paper_index,author_id_1,author_id_2;


DROP table if exists temp3 ;
CREATE table temp3 as 
select author_id_1,author_id_2 from ( select author_id_1,author_id_2,count(pair) as N from temp1 GROUP by author_id_1,author_id_2 )as temp2 where N > 1 
ORDER BY author_id_1 ASC;


select Author_Name_1,first_name || ' ' || last_name as Author_Name_2 from ( Select first_name || ' ' || last_name as Author_Name_1,author_id_2
from temp3 t1
INNER JOIN author
ON author_id_1 = author_id) as t2
INNER join author 
ON author_id_2 = author_id;
