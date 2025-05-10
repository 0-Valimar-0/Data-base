USE University;

DECLARE @BackupPath NVARCHAR(255) = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\University.bak';

BACKUP DATABASE University
TO DISK = @BackupPath
WITH INIT, STATS = 10;


IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'ADMIN' AND type = 'R')
    EXEC sp_addrole 'ADMIN';
    
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'TEACHER' AND type = 'R')
    EXEC sp_addrole 'TEACHER';
    
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'SECRETARY' AND type = 'R')
    EXEC sp_addrole 'SECRETARY';

GRANT SELECT, INSERT, UPDATE, DELETE ON Discuplinu TO ADMIN;
GRANT EXECUTE TO ADMIN;

GRANT SELECT, UPDATE ON Discuplinu TO TEACHER;
GRANT EXECUTE TO TEACHER;

GRANT SELECT, INSERT ON Discuplinu TO SECRETARY;

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'Antonov_Tea')
BEGIN
    EXEC sp_addlogin 'Antonov_Tea', 'Antonov', 'University';
    USE University;
    EXEC sp_adduser 'Antonov_Tea', 'Antonov_Tea';
    EXEC sp_addrolemember 'TEACHER', 'Antonov_Tea';
END

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'Vasnecov_Sec')
BEGIN
    EXEC sp_addlogin 'Vasnecov_Sec', 'Vasnecov', 'University';
    USE University;
    EXEC sp_adduser 'Vasnecov_Sec', 'Vasnecov_Sec';
    EXEC sp_addrolemember 'SECRETARY', 'Vasnecov_Sec';
END

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'Pavlov_Adm')
BEGIN
    EXEC sp_addlogin 'Pavlov_Adm', 'Pavlov', 'University';
    USE University;
    EXEC sp_adduser 'Pavlov_Adm', 'Pavlov_Adm';
    EXEC sp_addrolemember 'ADMIN', 'Pavlov_Adm';
END