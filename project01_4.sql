# 장르 인덱스 테이블 생성
use mywork;
CREATE TABLE IF NOT EXISTS genre_idx(
    genre varchar(20) NOT NULL,
    PRIMARY KEY(genre));
INSERT genre_idx VALUES
('소설'),('시/에세이'),('인문'),('가정/육아'),('요리'),('건강'),('취미/실용/스포츠'),('경제/경영'),
('자기계발'),('정치/사회'),('역사/문화'),('종교'),('예술/대중문화'),('중/고등참고서'),('기술/공학'),
('외국어'),('과학'),('취업/수험서'),('여행'),('컴퓨터/IT'),('잡지'),('청소년'),('초등참고'),
('유아(0~7세)'),('어린이(초등)'),('만화'),('대학교재'),('한국소개도서');

# 워드 클라우드, 원그래프(python에서 호출)
/*SELECT genre, count(*) FROM best_books_5years
WHERE years = {} GROUP BY genre;
with sub as (
    SELECT genre, count(*) c FROM best_books_5years
    WHERE years = {} GROUP BY genre)
    select * from  sub a where a.c > 3
    union
    select concat('기타') genre, sum(b.c) c from sub b where b.c <= 3;*/

# 상위 5 장르별 개수 비교(python에서 호출)
/*WITH book18 AS(SELECT genre, count(*) c 
	FROM best_books_5years WHERE years=2018 GROUP BY genre),
 book19 AS(SELECT genre, count(*) c 
	FROM best_books_5years WHERE years=2019 GROUP BY genre),
book20 AS(SELECT genre, count(*) c 
	FROM best_books_5years WHERE years=2020 GROUP BY genre),
book21 AS(SELECT genre, count(*) c 
	FROM best_books_5years WHERE years=2021 GROUP BY genre),
book22 AS(SELECT genre, count(*) c 
	FROM best_books_5years WHERE years=2022 GROUP BY genre)
SELECT g.genre, b18.c count18, b19.c count19, b20.c count20, 
	   b21.c count21, b22.c count22
FROM genre_idx g LEFT JOIN book22 b22 ON g.genre = b22.genre
				 LEFT JOIN book21 b21 ON g.genre = b21.genre
                 LEFT JOIN book20 b20 ON g.genre = b20.genre
                 LEFT JOIN book19 b19 ON g.genre = b19.genre
                 LEFT JOIN book18 b18 ON g.genre = b18.genre
WHERE not(b22.c is null and b21.c is null and b20.c is null
		  and b19.c is null and b18.c is null)
ORDER BY 2 DESC LIMIT 5;*/

# 상위 5 장르별 likes 경향 비교(python에서 호출)
/*SELECT genre, likes, count(likes) comment_n FROM best_books_5years
WHERE years = 2022 AND genre in ('소설','시/에세이','인문','자기계발','경제/경영')
GROUP BY genre, likes ORDER BY genre;*/

#장르 상위 5개  추출
SELECT genre, count(*) g_c FROM best_books_5years
GROUP BY genre HAVING count(*) > 30
ORDER BY g_c DESC;

#뷰_ 장르별 장당 가격 및 순위
CREATE OR REPLACE VIEW g_pr_p_r AS(
SELECT title, publisher, genre,	page, price, ranks,
    ifnull(round(price/page), 0) pr_per_p
FROM best_books_5years
GROUP BY genre, title, publisher, page, ranks, price, pr_per_p
ORDER BY genre, pr_per_p DESC, page DESC, ranks);

#장르별 장당가격 시각화
SELECT genre 장르, price, pr_per_p, ranks FROM g_pr_p_r
GROUP BY genre, title, publisher, page, price
ORDER BY genre, ranks_pr, page DESC ;

#합치기
WITH high_g AS(
	SELECT genre, count(*) g_c FROM best_books2
	GROUP BY genre HAVING count(*) >30 #상위 5장르
	ORDER BY g_c DESC)
SELECT 	b.genre, a.pr_per_p, a.ranks
FROM g_pr_p_r a
NATURAL JOIN high_g b;