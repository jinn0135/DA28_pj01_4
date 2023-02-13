SELECT COUNT(*) FROM BEST_BOOKS_5years;
# DROP VIEW book20;

select likes, count(*) from best_books
where genre = '과학' and years = 2022
group by likes;

drop table if exists genre_idx;
CREATE TABLE IF NOT EXISTS genre_idx(
    genre varchar(20) NOT NULL,
    PRIMARY KEY(genre));
INSERT genre_idx VALUES
('소설'),('시/에세이'),('인문'),('가정/육아'),('요리'),('건강'),('취미/실용/스포츠'),('경제/경영'),
('자기계발'),('정치/사회'),('역사/문화'),('종교'),('예술/대중문화'),('중/고등참고서'),('기술/공학'),
('외국어'),('과학'),('취업/수험서'),('여행'),('컴퓨터/IT'),('잡지'),('청소년'),('초등참고'),
('유아(0~7세)'),('어린이(초등)'),('만화'),('대학교재'),('한국소개도서');

#CREATE OR REPLACE VIEW book22 AS
SELECT b22.years, b22.genre, sum(if(b22.ranks is not null, 101-b22.ranks,0)) g_rnk_sum, 
	   count(b22.ranks) g_rnk_count, 
       sum(if(b22.ranks is not null, 101-b22.ranks,0))/count(b22.ranks) g_rnk_res,
       dense_rank() OVER (ORDER BY sum(if(b22.ranks is not null, 101-b22.ranks,0))/count(b22.ranks) DESC) g_rnk_22
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2022) b22 GROUP BY 2;
      
select * from best_books_5years
where years = 2022;
      
CREATE OR REPLACE VIEW book21 AS
SELECT b21.years, b21.genre, sum(if(b21.ranks is not null, 101-b21.ranks,0)) g_rnk_sum, 
	   count(b21.ranks) g_rnk_count, 
       sum(if(b21.ranks is not null, 101-b21.ranks,0))/count(b21.ranks) g_rnk_res,
       dense_rank() OVER (ORDER BY sum(if(b21.ranks is not null, 101-b21.ranks,0))/count(b21.ranks) DESC) g_rnk_21
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2021) b21 GROUP BY 2;
      
CREATE OR REPLACE VIEW book20 AS
SELECT b20.years, b20.genre, sum(if(b20.ranks is not null, 101-b20.ranks,0)) g_rnk_sum, 
	   count(b20.ranks) g_rnk_count, 
       sum(if(b20.ranks is not null, 101-b20.ranks,0))/count(b20.ranks) g_rnk_res,
       dense_rank() OVER (ORDER BY sum(if(b20.ranks is not null, 101-b20.ranks,0))/count(b20.ranks) DESC) g_rnk_20
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2020) b20 GROUP BY 2;
      
CREATE OR REPLACE VIEW book19 AS
SELECT b19.years, b19.genre, sum(if(b19.ranks is not null, 101-b19.ranks,0)) g_rnk_sum, 
	   count(b19.ranks) g_rnk_count, 
       sum(if(b19.ranks is not null, 101-b19.ranks,0))/count(b19.ranks) g_rnk_res,
       dense_rank() OVER (ORDER BY sum(if(b19.ranks is not null, 101-b19.ranks,0))/count(b19.ranks) DESC) g_rnk_19
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2019) b19 GROUP BY 2;
      
#CREATE OR REPLACE VIEW book18 AS
SELECT b18.years, b18.genre, sum(if(b18.ranks is not null, 101-b18.ranks,0)) g_rnk_sum, 
	   count(b18.ranks) g_rnk_count, 
       sum(if(b18.ranks is not null, 101-b18.ranks,0))/count(b18.ranks) g_rnk_res,
       dense_rank() OVER (ORDER BY sum(if(b18.ranks is not null, 101-b18.ranks,0))/count(b18.ranks) DESC) g_rnk_18
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2018) b18 GROUP BY 2;

SELECT * FROM book20;
select * from genre_idx;

SELECT g.genre, concat('22',b22.genre) genre_22, b22.g_rnk_22
FROM genre_idx g LEFT JOIN book22 b22 ON g.genre = b22.genre;

# 장르별 가산점 랭킹
SELECT g.genre, b18.g_rnk_18, b19.g_rnk_19, b20.g_rnk_20, b21.g_rnk_21, b22.g_rnk_22
FROM genre_idx g LEFT JOIN book22 b22 ON g.genre = b22.genre
				 LEFT JOIN book21 b21 ON g.genre = b21.genre
                 LEFT JOIN book20 b20 ON g.genre = b20.genre
                 LEFT JOIN book19 b19 ON g.genre = b19.genre
                 LEFT JOIN book18 b18 ON g.genre = b18.genre
WHERE not(b22.g_rnk_22 is null and b21.g_rnk_21 is null and b20.g_rnk_20 is null
		  and b19.g_rnk_19 is null and b18.g_rnk_18 is null);

# 장르별 개수 비교
SELECT g.genre, b18.g_rnk_count count18, b19.g_rnk_count count19, b20.g_rnk_count count20, 
	   b21.g_rnk_count count21, b22.g_rnk_count count22
FROM genre_idx g LEFT JOIN book22 b22 ON g.genre = b22.genre
				 LEFT JOIN book21 b21 ON g.genre = b21.genre
                 LEFT JOIN book20 b20 ON g.genre = b20.genre
                 LEFT JOIN book19 b19 ON g.genre = b19.genre
                 LEFT JOIN book18 b18 ON g.genre = b18.genre
WHERE not(b22.g_rnk_count is null and b21.g_rnk_count is null and b20.g_rnk_count is null
		  and b19.g_rnk_count is null and b18.g_rnk_count is null)
ORDER BY 2 DESC LIMIT 5;

SELECT genre, likes, count(likes) comment_n FROM best_books_5years
WHERE years = 2022 AND genre in ('소설','시/에세이','인문','자기계발','경제/경영')
GROUP BY genre, likes ORDER BY genre;

with sub as (
	SELECT genre, count(*) c FROM best_books_5years
	WHERE years = 2022 GROUP BY genre)
select * from  sub a where a.c > 3
union
select concat('기타') genre, sum(b.c) c from sub b where b.c <= 3;