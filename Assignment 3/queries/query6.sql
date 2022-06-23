-- Query 6

DROP TABLE IF EXISTS temp1 ;

Create table temp1  as
(Select paper_id , co_author_id_fk as author_id
FROM paper
INNER JOIN co_author 
ON paper.paper_id = co_author.paper_id_fk
UNION
select paper_id,main_author_id_fk as author_id FROM paper) ;


DROP TABLE IF EXISTS temp2 ;

CREATE TABLE  temp2 as
( 
	SELECT distinct * from (select author_id_1 , author_id  as author_id_2 FROM (SELECT author_id as author_id_1,referred_paper_id_fk FROM temp1 INNER JOIN citation
	ON temp1.paper_id = citation.main_paper_id_fk AND author_id != 48 )
	as k1
	INNER JOIN temp1
	ON k1.referred_paper_id_fk =  temp1.paper_id AND author_id != 48 AND author_id != author_id_1) as k45
 
);

DROP TABLE IF EXISTS temp3 ;

CREATE TABLE  temp3 as
(
	Select t1.author_id_1 as author_1 , t2.author_id_1 as author_2 , t3.author_id_1 as author_3
	FROM temp2 t1,temp2 t2,temp2 t3
	where t1.author_id_2 = t2.author_id_1 AND t2.author_id_2 = t3.author_id_1 AND t3.author_id_2 = t1.author_id_1 
	AND t1.author_id_1 < t2.author_id_1 AND t2.author_id_1 < t3.author_id_1 
	ORDER BY author_1 ASC

	
);

select Name_1,Name_2,first_name || ' ' || last_name as Name_3 from
(select Name_1,first_name || ' ' || last_name as Name_2,author_3 from
 (select first_name || ' ' || last_name as Name_1,author_2,author_3 from temp3 
INNER JOIN author
ON author_id = author_1) as k1
INNER JOIN author
ON author_id = author_2) as k2
INNER JOIN author
ON author_id = author_3;