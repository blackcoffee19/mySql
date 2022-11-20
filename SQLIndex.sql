USE StudentDB2

--tbStudent-> PRIMARY KEY st_id  (clustered index)

--tao 1 clustered index tren cot st_name

CREATE CLUSTERED INDEX ix_Name ON tbStudent(st_name)
GO

--vi tren bang stStudent da ton tai 1 clustered index tren cot khoa chinh
--vi vay muon tao 1 clustered index moi tren cot khac
--thi chung ta phai xoa PRIMARY KEY truoc sau do moi tao dc

ALTER TABLE tbStudent
DROP CONSTRAINT PK__tbStuden__A85E81CFEDADBFDE
---> Vi dinh khoa ngoai nen ko drop dc 
-->muon drop khoa chinh thi phai drop khoa ngoai truoc

ALTER TABLE tbMark
DROP CONSTRAINT FK__tbMark__student__29572725
GO

ALTER TABLE tbStudent 
DROP CONSTRAINT FK__tbStudent__mento__25869641
GO
SELECT * FROM tbMark
ALTER TABLE tbMark
ADD CONSTRAINT fk_mark_student FOREIGN KEY (student) references tbStudent(st_id)
GO
ALTER TABLE tbStudent
ADD CONSTRAINT fk_mentor FOREIGN KEY (mentor) references tbStudent(st_id)
GO
SELECT * FROM tbStudent
ALTER TABLE tbStudent
ADD CONSTRAINT pk_student PRIMARY KEY (st_id)
GO