use Northwind--Northwind veritabanında sorgulamalar için.

select *
from Employees

select FirstName,LastName,Title,BirthDate
from Employees

select *
from [dbo].[Employees]--Sürükle bırak yöntemi ile tablolar getirebilirsiniz.

--Sütunların isimlendirilmesi

--1.Yöntem
select FirstName as Ad,LastName as Soyad,Title As Görev
from Employees

--2.Yöntem
select Ad = FirstName,Soyad=LastName,Görev = Title
from Employees

--3.Yöntem
select 'Ad' = FirstName,'Soyad' = LastName,[Doğum Tarihi]=BirthDate
from Employees

--Distinct => Sadece farklı değerleri getirir. Tekrarı engeller.
select City
from Employees

select distinct City
from Employees

--Veritabanı İşlemleri

--1)Insert=> Bir veritabanındaki tablolardan birine yeni bir kayıt eklemek için kullanılam komuttur.

INSERT INTO Categories
(CategoryName,
 Description
)
VALUES
('Baklagiller',
 'Vitaminlidir bunlar:)'
);

select * from Categories


--Yeni bir kargo şirketi oluşturunuz. Kargo şirket ismi ve telefon numarası giriniz.

insert into Shippers 
values ('MNG KARGO','(212)6742313')

select * from Shippers


--Update: Bir tablodaki kayıtları günncellemek için kullanılır. Hangi kaydı güncelleyeceğimiz açıkça belirtilmeli. Yoksa tüm kayıtlar güncellenecektir.

--Not:Tablo Kopyalama

select *
into Calisanlar
from Employees

select * from Calisanlar


update Calisanlar
set LastName='Çalışkan'

UPDATE Calisanlar
  SET
      FirstName = 'Cemal',
      LastName = 'Çalışkan'
WHERE EmployeeID = 9;

--Calisanlar tablounsda ingilterede çalışanları listeleyin.

select *
from Employees
where Country='UK'

--London şubesi çalışanlarını Manchester'a taşıyınız.
UPDATE Calisanlar
  SET
      City = 'Manchester'
WHERE City = 'London';

SELECT *
INTO Urunler
FROM Products;


SELECT *
FROM Urunler;

--Urunler tablosundaki her ürüne %5 zam yapılmış halini listeleyiniz.
UPDATE Urunler
  SET
      UnitPrice = UnitPrice + (UnitPrice * 0.05);

--3)Delete => Bir tablodan kayıt silmek için kullanılan komut.

delete from Calisanlar--Tablo altındaki tüm kayıtları siler. Istenmeyen bir durumdur.

delete from Calisanlar
where EmployeeID=8;

drop table Calisanlar--Tabloyu siler.

DELETE FROM Calisanlar
WHERE titleofCourtesy IN('Mr.', 'Dr.');

SELECT *
FROM Calisanlar;

select * from Employees
where EmployeeID>5

--1960 yılında doğanları listele

select FirstName,LastName,TitleOfCourtesy,BirthDate
from Employees
where YEAR(BirthDate)=1960
--Year fonksiyonu bizden datetime tipinde değer alır.
--Geriye içindeki yıl bilgisini döndürür.


--1950 ve 1961 aralığında doğmuş çalışanları ismi, soyismi ve doğum tarihleriyle listeleyin.

select FirstName,LastName,BirthDate
from Employees
where year(BirthDate)>=1950 and year(BirthDate)<=1961

--Ünvanı Mr. olan ve yaşı 60'tan büyük olanların listelenmesi.


SELECT(TitleOfCourtesy+' '+FirstName+' '+LastName) AS Isim
FROM Employees
WHERE TitleOfCourtesy = 'Mr.'
      AND (YEAR(GETDATE()) - YEAR(BirthDate)) > 60;


--Null verileri çıkarmak için

select region
from Employees

select Region
from Employees
where region is not null-- is null kelimesi de null olanları listeler.

--Sıralama tipleri

--ASC(artan=>ascending) ve DESC (azalan => descending)

select *
from Employees
where EmployeeID>2 and EmployeeID<=8
order by FirstName ASC--default olarak Asc işlemi yapılacaktır.

--Çalışanların ismi soyismi ve doğum tarihleri listelensin.
--Sıralama doğum tarihlerine göre artan şekilde gerçekleşsin.

SELECT FirstName,
       LastName,
       BirthDate
FROM Employees
ORDER BY BirthDate;

--İsim,soyisim,doğum tarihi ve işe alım tarihi listelensin


Select FirstName,LastName,BirthDate,HireDate,Title,TitleOfCourtesy
from Employees
order by 6,4 desc--Sorguda yazdığımız sütun sırasına göre sıralama işlemi yapabiliriz.


--Çalışanların firstname,lastname, titleofCourtesy ve age ekrana getirilsin.
--Yaşa göre azalan şekilde sıralansın.
--Title of courtesy null ise ekrana basılmasın.

select FirstName,LastName,TitleOfCourtesy,(YEAR(GETDATE())-YEAR(BirthDate)) as Age
from Employees
where TitleOfCourtesy is not null
order by Age desc,TitleOfCourtesy

--Between kullanımı
--1952 ve 1960 arası doğanları lisiteleyiniz.

select FirstName,LastName,YEAR(BirthDate)as [Doğum Yılı]
from Employees
where YEAR(BirthDate) between 1952 and 1960
order by [Doğum Yılı] desc

--Janet ile Robert arasındakileri sıralayınız.

select FirstName,lastname
from Employees
where FirstName between 'Janet' and 'Robert'
order by FirstName

--Ünvanı mr veya dr olanların listelenmesi


SELECT TitleOfCourtesy,
       FirstName,
       LastName
FROM Employees
WHERE TitleOfCourtesy = 'Mr.'
      OR TitleOfCourtesy = 'Dr.';


SELECT TitleOfCourtesy,
       FirstName,
       LastName
FROM Employees
WHERE TitleOfCourtesy IN('Dr.', 'Mr.');


--1950,1955 ve 1960 yıllarında doğanların listesi

select FirstName,LastName,YEAR(BirthDate) as [Doğum Yılı]
from Employees
where YEAR(BirthDate) in(1950,1955,1960)

--Top# (Top 3 gibi) şeklindeki komut ilk kaç kaydın ekrana getirileceğini belirler.
--En son çalışan komuttur.

select top 3 *
from Employees

select top 3 firstname,lastname
from Employees
order by FirstName

--Yüzde ile kayıt getirecek isek( yüzde 70 gibi ) o zaman "top 70 percent" kodu ile bunu sağlayabiliriz. Ondalıklı ise(3,12) gibi
--O zaman 4 olarak alınacaktır.

select top 20 percent firstname,lastname,title,(YEAR(GETDATE())-YEAR(BirthDate)) as Age
from Employees
order by Age desc


--Like Kullanımı

select FirstName,LastName,Title
from Employees
where FirstName like 'Michael';

select FirstName,LastName,Title
from Employees
where FirstName like 'A%'--A ile başlayanlar.

--İsmi N ile bitenler?

select FirstName,LastName,Title
from Employees
where FirstName like '%N'

--İsmi içerisinde E hafi geçenler?

select FirstName,LastName,Title
from Employees
where FirstName like '%E%'

--İlk harfi A veya L olan çalışanlar?

select FirstName,LastName,Title
from Employees
where FirstName like '[AL]%'

--Adının içerisinde R veya T geçenler?

select FirstName,LastName,Title
from Employees
where FirstName like '%[RT]%'

--Adının ilk harfi alfabetik olarak J ve R aralığında olanlar?

select FirstName,LastName,Title
from Employees
where FirstName like '[J-R]%'

--İsminin ilk karakteri J üçüncü karakter N olan çalışanları listele

--"_" bir karakter anlamına gelir.

select FirstName,LastName,Title
from Employees
where FirstName like 'J_N%'

--Adı içerisinde A ile T olan ve bu iki harf arasında iki karakter içeren çalışanlar.


SELECT FirstName,
       LastName,
       Title
FROM Employees
WHERE FirstName LIKE '%A__T%';

--Adının ilk harfi M olmayanlar

select FirstName,LastName,Title
from Employees
where FirstName like '[^M]%'


select FirstName,LastName,Title
from Employees
where FirstName not like 'M%'

--Adı T ile bitmeyenler

select FirstName,LastName,Title
from Employees
where FirstName like '%[^T]'

--Adının ilk harfi A ile I aralığında bulunmayanlar.

select FirstName,LastName,Title
from Employees
where FirstName like '[^A-I]%'


--Adının ikinci harfi A veya T olmayanlar.

select FirstName,LastName,Title
from Employees
where FirstName like '_[^AT]%'


--ÖDEV===> Customers tablosundan CustomerID'sinin 2. Harfi A,4.harfi T olanların %20lik kısmını getiren sorguyu yazınız.

--String Fonksiyonları

--Select ile mutalaka bir tablo adı kullanmak zorunda değiliz.

select 5+9 as Toplam,
5-9 as Fark,
5*9 as Çarpım,
5/3 as Bölüm,
5%2 as [Mod]

select 'YMS5122 - Sql Server Dersleri' as Mesaj
Select ASCII('A') as [ASCII Kodu]
select char(65) as Karakter
select left('Bilge Adam',4) as [Soldan Karakter Sayısı]
select right('Bilge Adam',4) as [Sağdan Karakter Sayısı]
select Len('Bilge Adam') as [Karakter Sayısı]
select LOWER('Bilge ADAM') as [Hepsi Küçük Harf]
select UPPER('bilge adam') as [Hepsi Büyük Harf]
select LTRIM('           Bilge Adam') as [Soldaki boşlukları siler]
select RTRIM('Bilge Adam           ') as [Sağdaki boşlukları siler]

--ÖDEV => Iki taraftaki boşlukları silme

select REPLACE('birbirbirbirbirlerine','bir','üç') as [Metinlerin yerine yenilerini atar]
select SUBSTRING('Bilge Adam Bilişim Akademisi',4,6) as 'Alt Stringleri Oluşturur'
select 'Bilge Adam'+SPACE(30)+'Bilişim Akademisi' as [Belirtilen miktarda boşluk]
select REPLICATE('Bilge',5) as 'Belirtilen Metni, Belirtilen Adet kadar Çoğaltır.'


--Aggregate Functions

select COUNT(*) as [Toplam Kayıt sayısı]
from Employees

select COUNT(Region)
from Employees

select COUNT(distinct City)
from Employees

--SUM => Bir sütundaki değerlerin toplamını verir.

select sum(EmployeeID)
from Employees

--Çalışanların yaş toplamını bulunuz.

select SUM(DATEDIFF(year,BirthDate,getdate())) as [Yaşların Toplamı]
from Employees

--AVG => Ortalama alır.

select AVG(employeeID)
from Employees

select AVG(DATEDIFF(year,BirthDate,getdate())) as [Yaşların Toplamı]
from Employees

--Max, Min => Maximum ve minimum değeri bulmakta kullanılır.


SELECT MAX(EmployeeID)
FROM Employees;

SELECT MIN(EmployeeID)
FROM Employees;

SELECT MIN(DATEDIFF(year, BirthDate, GETDATE())) AS [Yaşların Toplamı]
FROM Employees;

SELECT MAX(DATEDIFF(year, BirthDate, GETDATE())) AS [Yaşların Toplamı]
FROM Employees;

--Case - When - Then


SELECT FirstName,
       LastName,
       CASE(Country)--Kontrol Edilecek Sütun İsmi
           WHEN 'USA'
           THEN 'Amerika Birleşik Devletleri'
           WHEN 'UK'
           THEN 'İngiltere Birleşik Krallığı'
           ELSE 'Ülke Belirtilmedi'
       END AS Country
FROM Employees;

--EmployeeID 5'ten büyük,5'ten küçük veya 5'e eşit şeklinde gösteriniz.

SELECT FirstName,
       CASE
           WHEN EmployeeID > 5
           THEN '5''ten büyük'
           WHEN employeeID < 5
           THEN '5''ten küçük'
           ELSE '5''e Eşit'
       END AS Durum
FROM Employees;

--Group By
--Çalışanların ülkelere göre gruplanması


SELECT country AS Ülke,
       COUNT(*) AS [Kişi Sayısı]
FROM Employees
WHERE country IS NOT NULL
GROUP BY Country;


--Çalışanların yapmış olduğu sipariş adedi.

SELECT EmployeeID,
       COUNT(*) AS [Sipariş Adedi]
FROM Orders
GROUP BY EmployeeID;

select * from Orders

--Ürün bedeli 35$'dan az olan ürünlerin kategorilerine göre gruplanması..


SELECT CategoryID,
       COUNT(*) AS Adet
FROM Products
WHERE UnitPrice <= 35
GROUP BY CategoryID
ORDER BY Adet DESC;

--Baş harfi A-K aralığında olan ve stok miktarı 5 ile 50 arasında olan ürünleri kategorilerine göre gruplayınız.

select CategoryID,COUNT(*) as Adet
from Products
where (ProductName like '[A-K]%') AND (UnitsInStock between 5 and 50)
group by CategoryID
order by Adet desc

--Her siparişteki ürün sayısını bulunuz.

SELECT OrderID,
       Sum(Quantity) AS 'Satılan Ürün'
FROM [Order Details]
GROUP BY OrderID;

--Her bir siparişi tutarına göre listeleyiniz.

SELECT OrderID,
       SUM(UnitPrice * Quantity * (1 - Discount)) AS Tutar
FROM [Order Details]
GROUP BY OrderID
ORDER BY 2 DESC;

--Having Kullanımı => Sorgu sonucu gelen sonuç kümesi üzerinde aggregate fonksiyonlara bağlı oalcak şekilde bir filtreleme işlemi yapacak isek where yerine having kelimesi kullanılır.

--Toplam tutar 2500 ile 3500 arasında olan siparişlerin sıralanaması

SELECT OrderID AS [Sipariş Kodu],
       SUM(Quantity * UnitPrice * (1 - Discount)) AS Tutar
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity * UnitPrice * (1 - Discount)) BETWEEN 2500 AND 3500;

--Aggregate fonksiyonlar sorgumuzda yoksa where ile aynı filtreleme işini yapacaktır.
--Neden where kullanıyoruz?



--Her bir siparişteki toplam ürün sayısı 200'den fazla olanlar?

SELECT OrderID,
       SUM(Quantity) AS Adet
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) > 200
ORDER BY Adet DESC;

--Subquery Kullanımı

SELECT *
FROM Products
WHERE UnitPrice >
(
    SELECT AVG(UnitPrice)
    FROM Products
);

--Ürünler tablosundaki satılan ürünlerin listesi.

SELECT *
FROM Products
WHERE ProductID IN
(
    SELECT ProductID
    FROM [Order Details]
);


SELECT p.ProductName,
       p.UnitPrice,
       p.UnitsInStock,
(
    SELECT c.CategoryName
    FROM Categories c
    WHERE c.CategoryID = p.CategoryID
) AS Kategoriler
FROM Products p;

--Kargo şirketlerinin taşıdıkları sipariş sayısı?

SELECT
(
    SELECT CompanyName
    FROM Shippers s
    WHERE s.ShipperID = o.ShipVia
) AS [Kargo],
Shipvia,
COUNT(*) AS [Sipariş Sayısı]
FROM Orders o
GROUP BY ShipVia;

--Exists Kullanımı

--Sipariş alan çalışanlar

SELECT *
FROM Employees e
WHERE EXISTS
(
    SELECT EmployeeID
    FROM Orders o
    WHERE e.EmployeeID = o.EmployeeID
);

--Sipariş almayan çalışanlar

SELECT *
FROM Employees e
WHERE NOT EXISTS
(
    SELECT EmployeeID
    FROM Orders o
    WHERE e.EmployeeID = o.EmployeeID
);

--Join İşlemleri
--1)Inner Join - Bir tablodaki her bir kaydın diğer tabloda bir karşılığı olan kayıtlar listelenir.

SELECT ProductName,
       CategoryName
FROM Products
     INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;

--Products tablosundan ProductID,ProductName,CategoryID
--Category Tablosundan CategoryName,Description


SELECT ProductID,
       ProductName,
       p.CategoryID,
       CategoryName,
       Description
FROM Products p
     JOIN Categories c ON c.CategoryID = p.CategoryID;

--Hangi sipariş hangi çalışan tarafından hangi müşteriye yapılmış?

--Join yazarsanız otomatik inner join yapılacaktır.

SELECT OrderID AS [Sipariş No],
       OrderDate AS [Sipariş Tarihi],
       CompanyName AS [Şirket Adı],
       ContactName AS [Yetkili Kişi],
       (FirstName+' '+LastName) AS [Çalışan],
       Title AS Görev
FROM Customers c
     JOIN Orders o ON c.CustomerID = o.CustomerID
     JOIN Employees e ON e.EmployeeID = o.EmployeeID;

--Suppliers tablosundan companyName,ContactName,
--Products tablosundan productName,unitPrice,
--Categories tablosundan CategoryName,
--CompanyName sütununa göre artan sırada ekrana getirilsin.


SELECT CompanyName,
       ContactName,
       ProductName,
       UnitPrice,
       CategoryName
FROM Categories c
     JOIN products p ON c.CategoryID = p.CategoryID
     JOIN Suppliers s ON s.SupplierID = p.SupplierID
ORDER BY 1;

--Kategorilerine göre toplam stok miktarı?


SELECT CategoryName,
       SUM(UnitsInStock) AS Stock--,c.CategoryID
FROM Categories c
     JOIN Products p ON p.CategoryID = c.CategoryID
GROUP BY CategoryName--,c.CategoryID;
--order by 2 desc

--Her bir çalışan toplam ne kadarlık satış yapmıştır?

--Cast(sayi as decimal) => Ondalıksız hali ile gözükmesi için decimal'a cast edebilirsiniz.

SELECT(FirstName+' '+LastName) AS Çalışan,
    CAST(SUM(UnitPrice * Quantity * (1 - Discount)) as decimal) AS Toplam
FROM Employees e
     JOIN orders o ON e.EmployeeID = o.EmployeeID
     JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY(FirstName+' '+LastName)
ORDER BY Toplam DESC;

--Left Outer Join=> Sorguda katılan tablolardan soldakinin tüm kayıtları getirilir. Sağdakinin sadece ilişkili olan kayıtları getirilir.

SELECT(e1.FirstName+' '+E1.LastName) AS Çalışan,
      (E2.FirstName+' '+e2.LastName) AS Müdür
FROM Employees E1
     LEFT OUTER JOIN Employees E2 ON E1.ReportsTo = e2.EmployeeID;

--Right outer join =>Sorguda katılan tablolardan sağdakinin tüm kayıtları getirilir. soldakinin sadece ilişkili olan kayıtları getirilir.

SELECT ProductName,
       CategoryName
FROM Categories
     LEFT OUTER JOIN Products ON Categories.CategoryID = Products.CategoryID;

--Full Join => Her iki tablodaki tüm kayıtlar getirilir.

SELECT ProductName,
       CategoryName
FROM Categories
     full JOIN Products ON Categories.CategoryID = Products.CategoryID;

--Cross Join => Bir tablodaki kaydın diğer tablodaki tüm kayıtlara eşleştirilmesini sağlar.

SELECT CategoryName,
       ProductName
FROM Categories
     CROSS JOIN Products;

--Stored Procedures(Saklı Yordamlar)
--TSQL komutları ile hazırladığımız işlemleri bütününün çalıştırılma anında derlenmesi ile size bir sonuç üreten sql server bileşenidir.
--Çalışma anı planlama sağlar ve tekrar tekrar kullanabiliriz.
--Querylerinizde otomatik parametrelendirme getirir.
--Uygulamalar arasında ortak kullanılabilir yapıdadır.
--Güvenli data modifikasyonu sağlar.
--Network bandwithinden tasarruf sağlar(daha az network bandwith kaynak kullanımı)
--Job olarak tanımlanabilir ve schedule edilebilir.
--Database objelerine güvenli erişim sağlar.

CREATE PROCEDURE sp_CalisanlariListele
AS
     BEGIN
         SELECT FirstName,
                LastName,
                title
         FROM Employees;
     END;

execute sp_CalisanlariListele--Procedure çalıştırmak için kullanılan metot.

exec sp_CalisanlariListele

drop procedure sp_CalisanlariListele--Procedure silme işlemi

--Tüm kategorilerle, bu kategorilere ait ürünleri getiren SP

CREATE PROC sp_UrunlerveKategoriler
AS
     BEGIN
         SELECT ProductName,
                CategoryName
         FROM Categories
              JOIN Products ON Products.CategoryID = Categories.CategoryID;
     END;

exec sp_UrunlerveKategoriler

--SP'lere parametre aktarma

CREATE PROC sp_UrunByKategori @id INT
AS
     BEGIN
         SELECT ProductName,
                CategoryName
         FROM Categories c
              JOIN Products p ON p.CategoryID = c.CategoryID
         WHERE c.CategoryID = @id;
     END;

EXEC sp_UrunByKategori 5;
EXEC sp_UrunByKategori @id = 2;

--Adına ve soyadına göre çalışanları listeleyen SP

CREATE PROC sp_Calisanlar @ad    NVARCHAR(10),
                          @soyad NVARCHAR(20)
AS
     BEGIN
         SELECT *
         FROM Employees
         WHERE FirstName = @ad
               AND LastName = @soyad;
     END;

exec sp_Calisanlar @ad='Nancy',@soyad='Davolio'

--Procedurelerde değişiklik için alter kelimesi kullanılır.


Alter PROC sp_Calisanlar @ad    NVARCHAR(10),
                          @soyad NVARCHAR(20)
AS
     BEGIN
         SELECT FirstName,LastName,Title
         FROM Employees
         WHERE FirstName = @ad
               AND LastName = @soyad;
     END;

--UDF => User defined functions

--KDV hesaplayan UDF

CREATE FUNCTION KDVHesapla
(@fiyat MONEY
)
RETURNS MONEY
     BEGIN
         RETURN @fiyat * 1.18;
     END;

--Sorguda fonksiyon kullanımı


SELECT ProductName AS [Ürün Adı],
       CategoryName AS [Kategori Adı],
       UnitPrice AS [Birim Fiyat],
       dbo.KDVHesapla(UnitPrice) AS [KDV Dahil Fiyat]
FROM Products
     JOIN Categories ON Products.CategoryID = Categories.CategoryID;

	--Kişilerin yaşlarını hesaplayan UDF?

CREATE FUNCTION YasHesap
(@dogumTarihi DATETIME
)
RETURNS INT
     BEGIN
         RETURN CAST(YEAR(GETDATE()) - YEAR(@dogumTarihi) AS INT);
     END;

select FirstName,dbo.YasHesap(BirthDate) as [Age]
from Employees

ALTER FUNCTION YasHesap(@dogumTarihi DATETIME)
RETURNS INT
     BEGIN
         DECLARE @yas INT;
         SET @yas = DATEDIFF(YY, @dogumTarihi, GETDATE());
         RETURN @yas;
     END;

/*
Tablo döndüren fonksiyonlar
-skaler fonksiyonlar gibi dışarıdan parametre alabilir.
-begin-end kullanılmaz
-Fonksiyon kullanımında şema kullanmaya gerek yoktur.
*/


ALTER FUNCTION CalisanBilgileriniGetir
(@employeeID INT
)
RETURNS TABLE
     RETURN
     SELECT *
     FROM Employees
     WHERE EmployeeID = @employeeID;


select *
from CalisanBilgileriniGetir(5)

--Çalışanların adını baş harfine göre listeleyen fonksiyon?

ALTER FUNCTION basHarfeGoreGetir(@basHarf NVARCHAR(1))
RETURNS TABLE
     RETURN
     SELECT *
     FROM Employees
     WHERE LEFT(FirstName, 1) = @basHarf; 


SELECT *
FROM basHarfeGoreGetir('A');


--Yeni veritabanı oluşturma

create database Test

use Test

--Yeni bir tablo oluşturmak

CREATE TABLE Kullanicilar
(ID           INT
 PRIMARY KEY IDENTITY(1, 1),
 Adi          NVARCHAR(50),
 Soyadi       NVARCHAR(50),
 KullaniciAdi NVARCHAR(50),
 Sifre        NVARCHAR(50),
 KayitTarihi  DATETIME DEFAULT(GETDATE()),
 Yasi         INT
);

alter table Kullanicilar--Tablo bilgileri değiştirme
add Email nvarchar(50)

select * from Kullanicilar

insert Kullanicilar(Adi,Soyadi,KullaniciAdi,Sifre,Yasi,Email)
values
('Osman','Osmanoğlu','OOsman','123',90,'ooglu@hotmail.com'),
('Ahmet','Ahmetoğlu','AAhmet','123',89,'AAoglu@gmail.com')

drop table Kullanicilar --Tablo Silme
drop database Test--Veritabanı Silme. Not:Seçili olan veritabanı silinemez.

--Trigger (Tetikleyici)

--Bir tablo üzerinde insert,updpate,delete işlemlerinden biri yapıldığında otomatik olarak devreye girmesini istediğiniz işlemleriniz varsa bunu trigger kullanarak gerçekleştirebilirsiniz.

--Bu işlemlerde bize yardımcı olacak iki tane sanal tablo vardır. Bunlar inserted ve deleted tablolarıdır.

--Bu tablolar üzerinde tanımlı olduğu base tablo ile birebir aynı yapıdadır. Yani böylece girilen kaydı inserted tablosunnda , silinen bir kaydı deleted tablosundan elde edebiliriz. güncellemek istediğimiz zaman (update işlemlerinde) inserted ve deleted tablolarından faydalanılır.Yani updated diye bir tablomuz yoktur.


--Iki tip Trigger var 
--DDL(Data definition language) ve DML (data manipulation şanguage) triggerları olmak üzere ikiye ayrılırlar.

--DML triggerlar after ve instead of olmak üzere ikiye ayrılırlar.

--After Trigger : Yaptığımız işlemden sonra (insert,update,delete) devreye girer.

CREATE TRIGGER trg_SiparisEklendi ON [order details]
AFTER INSERT
AS
     DECLARE @kacAdet INT, @hangiUrunID INT;
     SELECT @hangiUrunID = ProductID,
            @kacAdet = Quantity
     FROM inserted;
     UPDATE Products
       SET
           UnitsInStock-=@kacAdet
     WHERE ProductID = @hangiUrunID;

	select * from [Order Details]
	select * from Products
	--3 nolu product 10248 nolu siparişe eklenecek. 5 tane siparişe ekliyoruz.Başta 13 tane vardı.

INSERT INTO [Order Details]
(ProductID,
 Quantity,
 OrderID,
 UnitPrice
)
VALUES
(3,
 5,
 10248,
 10
);

--Sipairş siilinirse , silinen adet kadarını stoğa geri ekleyen trigger.

create trigger trg_SiparisSilindi on [Order Details]
after delete
as
declare @kacAdet int,@hangiUrunID int;

select @hangiUrunID=ProductID,@kacAdet=Quantity
from deleted

update Products
set
UnitsInStock+=@kacAdet
where ProductID=@hangiUrunID

delete from [Order Details] where OrderID=10248 and ProductID=3

drop trigger trg_SiparisEklendi--Trigger silme işlemi
drop trigger trg_SiparisSilindi

--Bir sipariş içerisindeki ürün adedi değiştiğinde stok miktarını ona göre güncelleyen trigger.

create trigger trg_SiparisGuncellendi on [order details]
after update
as
declare @eskiAdet int,@yeniAdet int,@urunID int

select @eskiAdet=Quantity
from deleted

select @yeniAdet=Quantity,@urunID=ProductID
from inserted

update Products
set
UnitsInStock+=@eskiAdet-@yeniAdet
where ProductID=@urunID

select * from [Order Details]
select * from Products

--10248 nolu siparişteki 11 idli üründe güncelleme

--Eski Adet	 Yeni Adet	  Eski Stok      Yeni Stok
--   12             15              22            19

update [Order Details] set Quantity=12 where OrderID=10248 and ProductID=11

--Instead of Trigger

--Employees tablosundan bir çalışanı sildiğimizde bu çalışanın id bilgisi diğer tablolarda da bulunduğu için silinmez. Zaten çalışanlalrı tablodan silmek çok doğru bir hareket olmaz çünkü bu çalışanın yapmış olduğu çeşitli satış bilgileri de diğer tablolarda yer almaktadır.

--Silme işlemi yerine employees tablousnda isDeleted isminde bir tablo oluşturuyoruz. Artık tablonda bir çalışanı sildiğimizde bu çalışanı silmek yerine isDeleted sütununu 1 olarak güncelleriz.



alter table Employees
add isDeleted int

CREATE TRIGGER trg_CalisanKovuldu ON employees
INSTEAD OF DELETE
AS
     DECLARE @kovulanID INT;
     SELECT @kovulanID = EmployeeID
     FROM deleted;
     UPDATE Employees
       SET
           isDeleted = 1
     WHERE EmployeeID = @kovulanID;

delete from Employees where EmployeeID=9

select * from Employees

--Shippers tablosuna insert edilirken kargo numarasını 02124445678 şeklinde girdiğimizde onu formatlı +90(212) 444-5678 haline getiren triggerı yazınız.

select * from Shippers

create trigger trg_KargoEkle on shippers
instead of insert
as
declare @kargoAdi nvarchar(50), @telefon nvarchar(50);

select @kargoAdi= CompanyName,@telefon=Phone
from inserted

declare @yeniTelefon nvarchar(50);

set @yeniTelefon='+9'+LEFT(@telefon,1)+'('+SUBSTRING(@telefon,2,3)+') '+SUBSTRING(@telefon,5,3)+'-'+RIGHT(@telefon,4)
insert into Shippers(CompanyName,Phone)
values(@kargoAdi,@yeniTelefon)

insert into Shippers values('Aras Kargo','02122345678')

--Transaction
--Urunler tablosuna kategorisi 'yemekler' olan biir urun ekleyelım. ve ardından o urun için 10248 orderID'li bir ürün detayı olusturalım. Eğer ürün kategorisi veritabanında mevcut ise işlem gerçeklşsin. değilse bu iki işlem gerçekleşmesin.



select * from Categories

select * from Products

select * from [Order Details]

insert into Categories(CategoryName,Description)
values('yemekler','Aciktim');


begin try
begin tran trn
if exists(select * from categories where categoryName='Yemekler')--Eğer yemekler isminde bir kategori varsa
begin
declare @catID int
select @catID=CategoryID--Yemeklerin kategori ID'si yakalanır.
from Categories
where CategoryName='Yemekler'
--
insert into products(productName,Unitprice,UnitsInStock,CategoryID)
values('Kadınbudu Köfte',9,25,@catID)
----
----Raise Error('Hata Oluştu',16,1)
----
insert into [Order Details] (OrderID,ProductID,Quantity,UnitPrice,Discount)
values(10248,SCOPE_IDENTITY(),2,9,0)--Anlık olarak eklenen ürün ID'si yakalanır.(Kadınbudu köfte ID'si)
end;
else
begin
print 'Yemekler isminde bir kategori yoktur. Nereden bunu çıkarttınız?'
end
commit tran trn
end try
begin catch
rollback tran trn
select ERROR_MESSAGE() as 'Hata Mesajı', ERROR_LINE() as 'Hata Satırı',ERROR_NUMBER() as 'Hata Kodu'
end catch
--SQL SERVER 2016 YENİLİKLERİ

--Temporal Tables

/*
											TEMPORAL TABLE NEDİR
Temporal Tables => temel olarak dml(update,delete) işlemlerindeki değişiklikleri izlemek için sql server 2016 sürümü ile duyrulan bir özelliktir. Temporal tablolar system versioned table olarakda adlandırılır Temporal table verinin geçmişini kendisiyle birlikte oluşturulan history tablolar da saklarlar. veriyi değişiklik tarihine göre versiyonlar

 * Bir Temporal table iki adet tablodan oluşur. ilk tablomuz system-versioned tablosudur. İkinci tablomuz history table'dır
 * System Versioned table => gerçek verinin izlenmesi ve çağrılması üzerine tasarlanır. geçerli veri bu tabloda saklanır
 * History Table => veri üzerindeki yapılan değişikliği içerir. Yani system-versioned table'daki yapılan değişiklik history table'da depolanıyor.

 */

 create database TemporalDB
 use TemporalDB

CREATE TABLE Urun
(ID          INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
 Adi         NVARCHAR(50),
 Fiyati      MONEY,
 StokMiktari SMALLINT,
 RowStart    DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
 RowEnd      DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
 PERIOD FOR SYSTEM_TIME(RowStart, RowEnd)
) WITH(SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.UrunHistory));



 insert Urun(Adi,Fiyati,StokMiktari)
 values('A ürünü',750,10),('B Ürünü',750,20),('C Ürünü',750,30)

 select * from Urun
 select * from UrunHistory
 --select * from urunHistory where id = 1

 update Urun
 set StokMiktari=70
 where ID=1

 delete Urun
 where id=3

 --Live query statistics
 --Sql server 2016 ile gelen performans özelliklerinmden birisidir. Sorgumuzun çalışma planını Actual Execution Plan'dan farklı olarak bize canlı sunmasıdır. Bu özellik sayesinde sorgumuzu izleyebilir okunan satır sayısını görebilir, sorgunun ne kadarlık kısmının tamamlandığını izleyebiliriz.

 --Sorguyu çalıştırmadan önce sağ tık ile live query statistics işaretini seçerek bu ekrana ulaşabilirsiniz.

 select * from products

 select * from orders o join customers c on c.CustomerID=o.CustomerID

 select * from Orders cross join Customers


 --Dynamic Data Masking
 --Sql Server 2016 ile gelen güvenlik önlemlerinden birisidir. Maskeleme yöntemi veriyi bozmaksızın(şifreleme yapmadan) select kullanıcılarına veriyi maskeleyerek gösterir. Maskeleme yaparken 3 fonksiyon vardır.

 --1)Default
 --2)Email
 --3)Partial

 create database DynamicDataMaskingDB

 use DynamicDataMaskingDB

 create table Kullanicilar(
 ID int primary key identity(1,1),
 Adi nvarchar(50),
 Soyadi nvarchar(50),
 KullaniciAdi nvarchar(50),
 Sifre nvarchar(50),
 KayitTarihi datetime default(getdate()),
 Yasi int,
 Email nvarchar(50)
 
 )

 insert Kullanicilar(adi,soyadi,kullaniciadi,sifre,yasi,email)
 values('Osman','Keleş','OKELES','123',25,'okeles@keles.com'),('osman2','keles2','OKELES2','312',26,'okeles2@keles2.com'),('Ekrem','Türker','Eturker','1234',27,'eturker@turker.com'),('Test','Tesoglu','Toglu','12345',28,'tesoglu@test.com')

 select * from kullanicilar

 --Kullanıcı oluşturma işlemi

 create user Ali without login

 --select yetkisi verme

 grant select on Kullanicilar to Ali

 --Default yöntemi ile maskeleme
 --Default maskeleme yöntemi ile kolon maskelemede string alanlarda xxxx şeklinde, sayısal alanlarda ise 0 şeklinde görüntüleme gerçekleşir.
 alter table Kullanicilar
 alter column KullaniciAdi add masked with(function='default()')

 execute as user ='Ali'

 revert--Ali kullanıcısından çıkmak için

 select * from kullanicilar

 alter table Kullanicilar
 alter column Yasi add masked with (function='default()')

 --Email fonksiyonu ile maskeleme
 --Email fonksiyonu sadece metinsel alanlarda çalışır.

 alter table Kullanicilar
 alter column Email add masked with (function='Email()')

 --Partial Fonksiyonu ile maskeleme
 --Partial(A,B,C) a b c olarak adlandırdıgımız parametreleri alır.
 --A=> verinin ilk kaç karakterinin gösterileceğini belirtir.
 --B=> verinin maskelenen kısmının hangi karakterler ile ifade edileceğini gösterir. default olarak x kullanılır.
 --C=> verinin son kaç karakterinin görüneceğini belirtir.

 --Sadece metinsel alanlarda kullanılır.

 alter table Kullanicilar
 add Telefon nvarchar(11)

 alter table Kullanicilar
 add Telefon2 nvarchar(11)


 update kullanicilar set telefon = '05401111111'

  update kullanicilar set telefon2 = '05401111111'

  alter table Kullanicilar
  alter column Telefon add masked with (function='partial(5,"yy",4)')

  execute as user ='Ali'

  revert

  select * from kullanicilar

  alter table Kullanicilar
  alter column Telefon2 add masked with (function='partial(0,"xy",0)')

  --Maskeleme kaldırma
  alter table Kullanicilar
  alter column Telefon drop masked

  --Aliye maskesiz görme yetkisi

  grant unmask to Ali

  drop database DynamicDataMaskingDB


  --ÖRNEKLER--

  --1000'den fazla satılan ürünler hangileridir?


SELECT ProductName,
       SUM(od.Quantity) AS [Satılan Ürün]
FROM [Order Details] od
     JOIN Products p ON od.ProductID = p.ProductID
GROUP BY ProductName
HAVING SUM(od.Quantity) > 1000
ORDER BY SUM(od.Quantity) DESC;

--Her bir siparişin sahibi kim ve bu müşteriler hangi ürünü almışlar?

select c.CompanyName,p.ProductName,(od.Quantity*od.UnitPrice) as Tutar
from Customers c join Orders o on c.CustomerID=o.CustomerID join [Order Details] od on o.OrderID=od.OrderID join Products p on od.ProductID= p.ProductID

--Her bir müşterinin sipariş bazında fatura tutarını hesaplayınız.


SELECT c.CompanyName,
       od.OrderID,
       SUM(od.Quantity * od.UnitPrice) AS Total
FROM Customers c
     JOIN orders o ON c.CustomerID = o.CustomerID
     JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.CompanyName,
         od.OrderID;

--Hangi tedarikçi hangi ürünü sağlıyor?

SELECT s.CompanyName,
       p.ProductName
FROM Suppliers s
     JOIN Products p ON s.SupplierID = p.SupplierID;

--Hangi Siparişi
--Hangi müşteri vermiş,
--Hangi çalışan almış?
--Hangi tarihte?
--Hangi kargo şirketi tarafından gönderilmiş
--Hangi üründen kaç adet alınmış?
--Hangi fiyattan alınmış?
--Ürün hangi kategoridenmiş?
--Bu ürünü hangi tedarikçi sağlamış?

select o.OrderID,
c.CompanyName,e.FirstName+' '+e.LastName as Employee,
o.OrderDate,
s.CompanyName,
p.ProductName,
od.Quantity,
od.Quantity*od.UnitPrice*(1-od.Discount) as Total,
ca.CategoryName,
su.CompanyName
from Employees e join orders o on o.EmployeeID=e.EmployeeID
join Customers c on c.CustomerID=o.CustomerID
join Shippers s on s.ShipperID=o.ShipVia
join [Order Details] od on od.OrderID=o.OrderID
join Products p on p.ProductID=od.ProductID
join Categories ca on ca.CategoryID=p.CategoryID
join Suppliers su on su.SupplierID=p.SupplierID


--View ile üretilmiş hali.

SELECT dbo.Orders.OrderID,
       dbo.Customers.CompanyName,
       dbo.Employees.FirstName+' '+dbo.Employees.LastName,
       dbo.Orders.OrderDate,
       dbo.Suppliers.CompanyName AS Expr1,
       dbo.[Order Details].Quantity,
       dbo.Shippers.CompanyName AS Expr2,
       dbo.Categories.CategoryName,
       dbo.Products.ProductName
FROM dbo.Suppliers
     INNER JOIN dbo.Products
     INNER JOIN dbo.Categories ON dbo.Products.CategoryID = dbo.Categories.CategoryID ON dbo.Suppliers.SupplierID = dbo.Products.SupplierID
     INNER JOIN dbo.[Order Details] ON dbo.Products.ProductID = dbo.[Order Details].ProductID
     INNER JOIN dbo.Shippers
     INNER JOIN dbo.Orders
     INNER JOIN dbo.Customers ON dbo.Orders.CustomerID = dbo.Customers.CustomerID
     INNER JOIN dbo.Employees ON dbo.Orders.EmployeeID = dbo.Employees.EmployeeID ON dbo.Shippers.ShipperID = dbo.Orders.ShipVia ON dbo.[Order Details].OrderID = dbo.Orders.OrderID;

	select * from test_View

	--Sipariş vermeyen müşteriler?

SELECT CompanyName,
       Address,
       OrderID
FROM Customers c
     LEFT JOIN orders o ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL;

--Çalışanlarım ne kadarlık satış yapmıştır?

SELECT(e.FirstName+' '+e.LastName) AS Çalışan,
      CAST(SUM(UnitPrice * Quantity * (1 - Discount)) AS DECIMAL) AS Tutar
FROM Employees e
     JOIN orders o ON o.EmployeeID = e.EmployeeID
     JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY e.FirstName+' '+e.LastName;


--Ürünlere göre satışım nasıl?

SELECT p.ProductName AS [Ürün Adı],
       SUM(od.Quantity) AS Adet,
       CAST(SUM(od.UnitPrice * Quantity * (1 - Discount)) AS DECIMAL) AS Gelir
FROM Products p
     JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY 3 DESC;

--Ürün kategorilerine göre satışlarımız nasıl?

SELECT c.CategoryName,
       CAST(SUM(od.UnitPrice * Quantity * (1 - Discount)) AS DECIMAL) AS Gelir
FROM Categories c
     JOIN products p ON c.CategoryID = p.CategoryID
     JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY 2 DESC;

--Hangi kargo şirketine toplam ne kadar ödeme yapılıyor?

SELECT s.CompanyName,
       SUM(o.Freight) AS [Ödenen Ücret]
FROM Shippers s
     JOIN orders o ON o.ShipVia = s.ShipperID
GROUP BY s.CompanyName;

--Tost seven çalışan kimdir?

select (FirstName+' '+LastName) as [Tostçu Arkadaş]
from Employees
where Notes like '%Toast%'

--Hangi tedarikçiden aldığım ürünlerden ne kadar satmışım?

SELECT s.CompanyName,
       p.ProductName,
       SUM(od.Quantity) AS Adet,
       SUM(od.Quantity * od.UnitPrice) AS Gelir
FROM Suppliers s
     JOIN Products p ON p.SupplierID = s.SupplierID
     JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY s.CompanyName,
         p.ProductName
ORDER BY 3 DESC;


--En değerli müşterim kimdir?

SELECT TOP 1 c.CompanyName,
             SUM(Quantity) AS Adet,
             SUM(od.Quantity * od.UnitPrice) AS Gelir
FROM customers c
     JOIN orders o ON c.CustomerID = o.CustomerID
     JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.CompanyName
ORDER BY 3 DESC;

--Zamanında teslim edemediğim sipairş idlerim nelerdir? kaç gün geç göndermişim?

select OrderID,DATEDIFF(day,RequiredDate,ShippedDate) as DT
from Orders
where DATEDIFF(day,RequiredDate,ShippedDate)>0
order by 2 desc

--Ortalama satış miktarının üzerine çıkan satışlar?

SELECT *
FROM [Order Details] od
WHERE Quantity >
(
    SELECT AVG(Quantity)
    FROM [Order Details]
)
ORDER BY od.Quantity DESC;


--ID'si verilen müşterinin toplam ne kadarlık alışveriş yaptığını bulan procedure

CREATE PROC AlisverisMiktari @ID NCHAR(5)
AS
     SELECT SUM(od.UnitPrice * Quantity * (1 - od.Discount)) AS [Indirimli alışveriş miktarı]
     FROM [Order Details] od
          JOIN orders o ON o.OrderID = od.OrderID
          JOIN Customers c ON c.CustomerID = o.CustomerID
     WHERE c.CustomerID = @ID;

alisverisMiktari 'Ocean'


--Dışarıdan girilen iki tarih aralığında bulunan siparişleri listeleyelen sp.
create proc TariheGoreSiparis
@tarih1 datetime,
@tarih2 datetime
as
select OrderID,OrderDate,ShipAddress
from Orders
where OrderDate between @tarih1 and @tarih2

TariheGoreSiparis '01/01/1997','12/31/1997'


--ÖDEV!!!!

--ID'si verilen müşteri en son hangi ürün almış?
--ID'si verilen kategorinin içinde en çok satan 5 ürün?
--ID'si verilen tedarikçi bana hangi ürünleri sağlıyor?


---SQL PUANLI ÖDEV!!--
-- Tablo Adı = " Country ", Parametreler = Id, CountryName,Code
-- Tablo Adı = " City",     Parametreler = Id, CityName, CountryId,Code
-- Tablo Adı = " District", Parametreler = Id, DistrictName, CountryId, CityId,Code
-- Tablo Adı = " Town",     Parametreler = Id, TownName, CountryId, CityId, DistrictId,code

/*

  NOT : Yeni bir veri tabanı kod ile oluşturulacak :)

  1) Yukarıdaki tablolar Code ile oluşturulacak ve kod ile ılişkilendirilecektir.
  2) Bir adet StoreProcedure yazılacak ve bu procedure içerisine parametre olarak, Ülke Adı, şehir Adı, ılçe Adı ve Mahalle Adı alacak.
  3) Ülkeler tablosunda parametrede gönderilen ülke var mı yok mu kontrol edilece. 
    3.1) Eğer Ülke Yok ise Eklenecek. Var ise kullanıcıya mesaj ile bildirilecek
  4) şehirler tablosunda parametrede gönderilen Ülke Kontol edilecek ve Bu ülkeye ait böyle bir şehir olup olmadığı kontrol edilecek. 
    4.1) Eğer şehir yok ise eklenecek. Var ise O ülkenin Id paramtresi yakalanacak ve o Id paramteresine göre şehirler tablosuna kayıt eklenecek.
  5) ılçeler tablosunda parametrede gönderilen Ülke o ülkeye bağlı şehir ve o şehire bağlı ılçe varmı yok mu kontrol edilecek.
    5.1) Eğer Ülke Yok ise, Ülke eklenecek. Sonra eklenen ülkenin Id parametresine göre ıl eklenecek. Sonrasında ise, ülke Id ve ıl Id parametreleri yakalanıp ilçe eklenecek.
    5.2) Eğer Ülke var şehir yok ise, parametrede gönderilen ülke Id yakalanıp şehir eklenecek ve Ulke Id ile şehir Id parametrelerini kullanarak ılçeyi Eklenecek.
  6) Mahalle tablosunda parametrede gönderilen Ülke, o ülkeye bağlı şehir, o şehire bağlı ilçe varmı yok mu kontrol edilecek.
    6.1) Eğer Ülke yok ise; Önce Ülke eklenecek ve o ülkenin Id parametresine göre ıl, Ülke ve ıl Id parametrelerine göre ilçe, Ulke ıl ve ılçe Id parametrelerine göre de Mahalle eklenecek.
    6.2) Eğer ülke var ise ve şehir yok  ise O ülke Id parametresine göre şehir,, Ülke ve şehir Id parametresine göre ılçe, Ülke  şehir ilçe Id parametrelerine göre Mahalle eklenecek.
    6.3) Eğer ülke ıl var ama ilçe yok ise, Ülke şehir Id parametreleri yakalanacak ve ılçe eklenecek. Sonrasında Ülke şehir ve ılçe Id parametreleri yakalnarak Mahalle Eklenecek
    6.4) Eğer ülke il ilçe var ama mahalle yok ise, Ülke ıl ılçe Id parametreleri kullanılarak Mahalle eklenecektir.

	NOT : ıl ve şehir Aynı Anlama Gelir :) her blok içerisinde mesaj verilecek
*/