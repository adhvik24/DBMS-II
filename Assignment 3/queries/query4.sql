-- Query 4

SELECT title,paper.paper_id,cite_count
FROM paper 
INNER JOIN (SELECT referred_paper_id_fk as "paper_id",count(referred_paper_id_fk) as "cite_count"
FROM citation
GROUP BY referred_paper_id_fk
ORDER BY count(referred_paper_id_fk) DESC LIMIT 20 ) AS most_cite
ON paper.paper_id = most_cite.paper_id;