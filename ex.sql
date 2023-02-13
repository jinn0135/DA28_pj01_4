use mywork;

DROP TABLE BEST_BOOKS;

SELECT * FROM BEST_BOOKS;
DESC best_books;

SELECT COUNT(*) FROM BEST_BOOKS;

SELECT years, genre, ranks, rate, likes FROM BEST_BOOKS;

SELECT years, genre FROM best_books GROUP BY 1,2;

WITH book2020 AS(
	SELECT years, genre, ranks FROM best_books
	WHERE years = 2020),
	 book2021 AS(
	SELECT years, genre, ranks FROM best_books
	WHERE years = 2021),
     book2022 AS(
	SELECT years, genre, ranks FROM best_books
	WHERE years = 2022)
SELECT b20.ranks, b20.years, b20.genre, b21.years, b21.genre, b22.years, b22.genre
FROM book2020 b20, book2021 b21, book2022 b22
WHERE b20.ranks = b21.ranks AND b20.ranks = b22.ranks;
