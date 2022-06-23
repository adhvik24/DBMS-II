COPY publication_venue(publisher_id,venue,valid_years)  FROM '/home/adhvik/Downloads/Adhvik/courses/sem4/DBMS2/assignments/assign2/final/final/publication.csv' DELIMITER E'\t';
COPY author(author_id,first_name,last_name,email_id)  FROM '/home/adhvik/Downloads/Adhvik/courses/sem4/DBMS2/assignments/assign2/final/final/Author_data.csv' DELIMITER E'\t';
COPY paper(paper_id,main_author_id_fk,publisher_id_fk,publication_year,title,abstract)  FROM '/home/adhvik/Downloads/Adhvik/courses/sem4/DBMS2/assignments/assign2/final/final/Paper_details_data.csv' DELIMITER E'\t';
COPY citation(main_paper_id_fk,referred_paper_id_fk) FROM '/home/adhvik/Downloads/Adhvik/courses/sem4/DBMS2/assignments/assign2/final/final/citation.csv' DELIMITER E'\t';
COPY co_author(paper_id_fk,co_author_id_fk,rank) FROM '/home/adhvik/Downloads/Adhvik/courses/sem4/DBMS2/assignments/assign2/final/final/Co_Author_data.csv' DELIMITER E'\t';

