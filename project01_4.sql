# 연도별 장르별 책 권수 view 만들기
CREATE OR REPLACE VIEW book22 AS
SELECT b22.years, b22.genre, count(b22.ranks) g_count
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2022) b22 GROUP BY 2;
CREATE OR REPLACE VIEW book21 AS
SELECT b21.years, b21.genre, count(b21.ranks) g_count
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2021) b21 GROUP BY 2;
CREATE OR REPLACE VIEW book20 AS
SELECT b20.years, b20.genre, count(b20.ranks) g_count
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2020) b20 GROUP BY 2;
CREATE OR REPLACE VIEW book19 AS
SELECT b19.years, b19.genre, count(b19.ranks) g_count
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2019) b19 GROUP BY 2;
CREATE OR REPLACE VIEW book18 AS
SELECT b18.years, b18.genre, count(b18.ranks) g_count
FROM (SELECT years, genre, ranks FROM best_books_5years
	  WHERE years = 2018) b18 GROUP BY 2;

# 장르별 개수 비교 -> 상위 5장르 선택
SELECT g.genre, b18.g_count count18, b19.g_count count19, b20.g_count count20, 
	   b21.g_count count21, b22.g_count count22
FROM genre_idx g LEFT JOIN book22 b22 ON g.genre = b22.genre
				 LEFT JOIN book21 b21 ON g.genre = b21.genre
                 LEFT JOIN book20 b20 ON g.genre = b20.genre
                 LEFT JOIN book19 b19 ON g.genre = b19.genre
                 LEFT JOIN book18 b18 ON g.genre = b18.genre
WHERE not(b22.g_count is null and b21.g_count is null and b20.g_count is null
		  and b19.g_count is null and b18.g_count is null)
ORDER BY 2;

# 상위 5 장르별 개수 비교(python에서 호출)
/*SELECT g.genre, b18.g_count count18, b19.g_count count19, b20.g_count count20, 
	   b21.g_count count21, b22.g_count count22
FROM genre_idx g LEFT JOIN book22 b22 ON g.genre = b22.genre
				 LEFT JOIN book21 b21 ON g.genre = b21.genre
                 LEFT JOIN book20 b20 ON g.genre = b20.genre
                 LEFT JOIN book19 b19 ON g.genre = b19.genre
                 LEFT JOIN book18 b18 ON g.genre = b18.genre
WHERE not(b22.g_count is null and b21.g_count is null and b20.g_count is null
		  and b19.g_count is null and b18.g_count is null)
ORDER BY 2 DESC LIMIT 5;*/

# 상위 5 장르별 likes 경향 비교(python에서 호출)
/*SELECT genre, likes, count(likes) comment_n FROM best_books_5years
WHERE years = 2022 AND genre in ('소설','시/에세이','인문','자기계발','경제/경영')
GROUP BY genre, likes ORDER BY genre;*/
