-- Pengujian Database

-- Menampilkan tabel mengenai total profit tiap jenis segmentasi dengan kondisi data yang tidak diskon.

SELECT
	s."segment",  				       -- Menampilkan data dari tabel segment
	SUM(f."profit") AS "total profit"  -- Menghitung total profit dari tabel finance
FROM finance AS f 					   -- Diambil dari data tabel finance
JOIN segment AS s 					   -- Di gabungkan kan dengan tabel segment
ON s.id = f."segment id" 		       -- Menghubungkan kolom id tabel segment dengan kolom segment id tabel finance
WHERE "discounts" !=0 			       -- Dengan kondisi tidak mengambil data yang diskon
GROUP BY s."segment"				   -- Dikelompokan berdasarkan tabel segment
ORDER BY SUM(f."profit") DESC;		   -- Di urutukan berdasarkan total profit terbesar


-- Menampilkan tabel mengenai nilai rata-rata, min, dan max dari sales masing-masing negara.
SELECT
	c."country", 						   -- Menampilkan data dari tabel country
	AVG(f."sales") AS "rata-rata sales",  -- Menghitung nilai rata-rata dari sales di tabel finance
	MIN(f."sales") AS "minimum sales",	   -- Menghitung nilai minimum dari sales di tabel finance
	MAX(f."sales") AS "maksimal sales"    -- Menghitung nilai maksimal dari sales di tabel finance
	FROM finance AS f 			          -- Diambil dari data tabel finance		
JOIN country AS c						  -- Di gabungkan kan dengan tabel country
ON c.id = f."country id"				  -- Menghubungkan kolom id tabel country dengan kolom country id tabel finance
GROUP BY c."country"					  -- Dikelompokan berdasarkan tabel country
ORDER BY 2 DESC;			  			  -- Di urutkan berdasarkan rata-rata sales terbesar