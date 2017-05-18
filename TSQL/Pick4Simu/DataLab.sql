/*
   ���n��, ���ܧ�H�U�ⶵ�Ѽ�:

   declare @iDrawingDeviceCount int
   set @iDrawingDeviceCount = 12    -- ���]�C�մX���}����
   declare @iSimuCount int
   set @iSimuCount = 1000    -- �w�ƴ��զh�֦�
*/

set nocount on

use master
go

IF EXISTS (SELECT * FROM master..sysdatabases WHERE name = 'SimuLabDB')
  DROP DATABASE SimuLabDB
GO
CREATE DATABASE SimuLabDB
go

use SimuLabDB
go

Create Table SimuData
(
  SerialID int identity(1, 1) not null primary key,
  C0 int null,
  C1 int null,
  C2 int null,
  C3 int null,
  C4 int null,
  C5 int null,
  C6 int null,
  C7 int null,
  C8 int null,
  C9 int null,
  Data varchar(64) not null
)
go

Create Function CountChar(
  @Value varchar(64), 
  @CountWhat char(1)) 
returns int 
as
begin
  declare @Result int
  declare @iLen int
  declare @i int
  declare @sChar char(1)

  set @iLen = len(@Value)
  
  set @Result = 0
  set @i = 1
  while @i <= @iLen
  begin
    set @sChar = subString(@Value, @i, 1)
    if @sChar = @CountWhat
    begin
      set @Result = @Result + 1
    end
    set @i = @i + 1
  end
  return @Result
end
go

declare @iDrawingDeviceCount int
set @iDrawingDeviceCount = 12    -- ���]�C�մX���}����
declare @iSimuCount int
set @iSimuCount = 1000    -- �w�ƴ��զh�֦�

declare @iTh int
declare @sData varchar(64)
declare @sDigi char(1)

set @iTh = 1
set @sData = ''
while @iTh <= @iDrawingDeviceCount
begin
  set @sDigi = convert(char(1), FLOOR(RAND()*10))
  set @sData = @sData + @sDigi
  set @iTh = @iTh + 1
end

set @iTh = 1
while @iTh <= @iSimuCount
begin
  set @sDigi = convert(char(1), FLOOR(RAND()*10))
  set @sData = right(@sData, @iDrawingDeviceCount - 1) + @sDigi
  insert into SimuData (Data) values (@sData)
  set @iTh = @iTh +1
end

declare @sSQL varchar(256)
set @iTh = 0
while @iTh <= 9
begin
  -- update SimuData set C0 = dbo.CountChar(Data, '0')
  set @sSQL = 'update SimuData set C' + convert(char(1), @iTh) +
    ' = dbo.CountChar(Data, ''' + convert(char(1), @iTh) + ''')'
  execute (@sSQL)
  set @iTh = @iTh + 1
end
go


select * from SimuData
go

set nocount off
