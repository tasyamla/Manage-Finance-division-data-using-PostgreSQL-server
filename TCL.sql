-- Membuat Database baru
-- CREATE DATABASE GC2_Tasya;

-- Transaction Control Language (TCL) diawali dengan Begin dan diakhiri oleh Commit
-- Di dalam proses TCL dilakukan pembuatan tabel dan input data dari data yang sudah di normalisasi
-- Selain itu, dilakukan proses pembuatan 2 user untuk melakukan pemberian akses query untuk command SELECT saja
-- User lainnya dapat mengaksesn command query karena dianggap sebagai admin

-- Memulai transaksi
BEGIN;
-- Membuat tabel segment 
-- Menambahkan if not exists untuk melakukan pengecekan terlebih dahulu apakah nama tabel sudah pernah dibuat atau belum
CREATE TABLE IF NOT EXISTS segment (
	"id" SERIAL primary key not null, -- membuat kolom id di tabel segment sebagai primary key 
	"segment" varchar(50)             -- membuat kolom segment di tabel segment beserta jenis data dan mengatur panjang karakter 
	);

-- Membuat tabel country 
CREATE TABLE IF NOT EXISTS country (
	"id" SERIAL primary key not null,  -- membuat kolom id di tabel country sebagai primary key
	"country" varchar(50)			    -- membuat kolom country di tabel country beserta jenis data dan mengatur panjang karakter
	);

-- Membuat tabel product 
CREATE TABLE IF NOT EXISTS product (
	"id" SERIAL primary key not null,  -- membuat kolom id di tabel product sebagai primary key
	"product" varchar(50)				-- membuat kolom product di tabel product beserta jenis data dan mengatur panjang karakter
	);

-- Membuat tabel discount band 
CREATE TABLE IF NOT EXISTS "discount band" (
	"id" SERIAL primary key not null,  -- membuat kolom id di tabel discount band sebagai primary key
	"discount band" varchar(50)			-- membuat kolom discount band di tabel discount band beserta jenis data dan mengatur panjang karakter
	);


-- Membuat tabel finance 
-- Memasukkan kolom-kolom yang terdapat di tabel finance dan menambahkan jenis data nya
CREATE TABLE IF NOT EXISTS finance (
	"segment id" integer,
	"country id" integer,
	"product id" integer,
	"discount band id" integer,
	"units sold" float,
	"manufacturing price" float,
	"sale price" float,
	"gross sales" float,
	"discounts" float,
	"sales" float,
	"cogs" float,
	"profit" float,
	"date" date,
	FOREIGN KEY("segment id") REFERENCES segment("id"),  -- membuat foreign key pada kolom segment id di dalam tabel finance
	FOREIGN KEY("country id") REFERENCES country("id"),  -- membuat foreign key pada kolom country id di dalam tabel finance
	FOREIGN KEY("product id") REFERENCES product("id"),  -- membuat foreign key pada kolom product id di dalam tabel finance
	FOREIGN KEY("discount band id") REFERENCES "discount band"("id") -- membuat foreign key pada kolom discount band id di dalam tabel finance
	);

-- Menginput data yang sudah diolah di pandas dan di simpan dalam format.csv
COPY segment("segment")
FROM 'C:\tmp\tabelsegmentnew.csv'
DELIMITER ','
CSV HEADER;

COPY country("country")
FROM 'C:\tmp\tabelcountrynew.csv'
DELIMITER ','
CSV HEADER;

COPY product("product")
FROM 'C:\tmp\tabelproductnew.csv'
DELIMITER ','
CSV HEADER;

COPY "discount band"("discount band")
FROM 'C:\tmp\tabeldiscountbandnew.csv'
DELIMITER ','
CSV HEADER;

COPY finance("segment id","country id","product id","discount band id","units sold","manufacturing price", "sale price", "gross sales", "discounts", "sales", "cogs", "profit", "date")
FROM 'C:\tmp\tabelfinance.csv'
DELIMITER ','
CSV HEADER;

-- Membuat User untuk bisa mengakses query
CREATE USER "UserA" WITH PASSWORD '1234';

CREATE USER "UserB" WITH PASSWORD '1234';

-- Memberikan akses UserA hanya bisa select
GRANT SELECT ON 
	ALL TABLES IN SCHEMA "public" to "UserA";

-- Memberikan akses UserB bisa mengakses semua command query karena dianggap sebagai admin
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA "public" to "UserB";

-- Menyimpan segala transaksi yg sudah dilakukan 
COMMIT;


-- untuk mengubah user/role yg active
-- SET ROLE "UserA";

-- untuk mengubah user/role yg active
-- SET ROLE "UserB";

-- untuk ubah role ke admin
-- SET ROLE "postgres";

-- cek user/role yang aktif
-- SELECT CURRENT_USER;

