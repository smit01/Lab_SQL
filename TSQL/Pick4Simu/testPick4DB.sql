-- drop database testPick4DB
Create Database testPick4DB
go

use testPick4DB
go

-- digitals ��ƪ� ���t 0-9 �Q�ӼƦr
create table digitals 
  (digi char(1) not null)
go

declare @iDigi int
set @iDigi = 0
while @iDigi <= 9
begin
  insert into digitals (digi) values (@iDigi)
  set @iDigi = @iDigi + 1
end
go
-- select * from digitals

-- �H digitals ��ƪ� �s�զ� pair ��ƪ�
-- pair �� 00-99 �@�@�ʭӹ�m�Ʀr
select r.digi as A, l.digi as B 
   into Pair 
   from digitals l cross join digitals r 
   order by A, B
go
-- select * from pair

-- �H pair ��ƪ� �s�զ� AllNumber ��ƪ�
-- AllNumbers ���t 0000-9999 �@�@�U�ӼƦr
select r.A as A, r.B as B, l.A as C, l.B as D 
  into AllNumbers 
  from Pair l cross join Pair r 
  order by A, B, C, D
-- drop table AllNumbers

-- drop table SimuData
-- �����}?���
Create Table SimuData
(
  Period varchar(6) not null primary key,
  Draw char(4) not null,
  Kind int null,
  BigSmall nchar(4) null,
  OddEven nchar(4) null,
  NumSum int null
)
go

declare @iCount int
declare @sPeriod varchar(6)
declare @sDraw varchar(4)

set @iCount = 1
while @iCount < 1000
begin
  set @sPeriod = substring(convert(varchar(4), @iCount + 1000), 2, 3)
  set @sDraw = convert(char(1), FLOOR(RAND()*10)) 
    + convert(char(1), FLOOR(RAND()*10))
    + convert(char(1), FLOOR(RAND()*10))
    + convert(char(1), FLOOR(RAND()*10))

  insert into SimuData (Period, Draw) values (@sPeriod, @sDraw)
  -- print @sDraw

  set @iCount = @iCount + 1
end
Go
-- select * from SimuData

