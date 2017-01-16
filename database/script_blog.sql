/*
authors:
    author_id,
    name,
    email,
    password

posts:
    post_id,
    author_id
    title,
    body,
    publication_date

comments:
    comment_id,
    name,
    email,
    comment_text

post_comments:
    post_id,
    comment_id


tags
    tag_id
    name

post_tags
    post_id
    tag_id
*/
/* ***** SELECT DE DATOS DE LA DB ******
--------SELECCIONAR TABLAS DE LA BASE DE DATOS------
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
--------SELECCIONAR FUNCIONES DE LA BASE DE DATOS------
SELECT NAME FROM SYSOBJECTS WHERE XTYPE = 'FN'
--------VER FUNCIONES DE LA BASE DE DATOS------
SELECT OBJECT_DEFINITION (OBJECT_ID('dbo.functionEncrypt')) AS ObjectDefinition;
*/
CREATE DATABASE dbblog
GO
USE dbblog
GO
CREATE TABLE authors(
    authorId INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50),
    email NVARCHAR(50),
    password VARBINARY(MAX)
)
GO
CREATE TABLE posts(
    postId INT IDENTITY(1,1) PRIMARY KEY,
    author_id INT,
    title NVARCHAR(50),
    body TEXT,
    publicationDate DATE,
    CONSTRAINT FK_authors_blogs FOREIGN KEY (author_id)
    REFERENCES authors (authorId)
)
GO
CREATE TABLE comments(
    commentId INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50),
    email NVARCHAR(50),
    comment_text TEXT
)
GO
CREATE TABLE tags (
    tagId INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50)
)
GO
CREATE TABLE post_comments(
    post_id INT,
    comment_id INT,
    CONSTRAINT FK_post_comments_post FOREIGN KEY (post_id)
    REFERENCES posts (postId),
    CONSTRAINT FK_post_comments_comments FOREIGN KEY (comment_id)
    REFERENCES comments (commentId)
)
GO
CREATE TABLE post_tags(
    post_id INT,
    tag_id INT,
    CONSTRAINT FK_post_tags_post FOREIGN KEY (post_id)
    REFERENCES posts (postId),
    CONSTRAINT FK_post_tags_tag FOREIGN KEY (tag_id)
    REFERENCES tags (tagId)
)
GO
--Funcion para desencriptar clave mediante fraceo
CREATE FUNCTION functionDecrypt(
@prmbinClave varbinary(max))
returns varchar(63)
AS
BEGIN

	DECLARE @strClave varchar(20)
	SET @strClave = DECRYPTBYPASSPHRASE('startprojectPostDemo__#05012017_by@Manuel', @prmbinClave)
	return @strClave

END
GO
--Funcion para encriptar clave mediante fraceo
CREATE FUNCTION functionEncrypt(
@prmstrClave varchar(63))
returns VarBinary(max)
AS
BEGIN
	DECLARE @binClave varbinary(8000)
	SET @binClave = ENCRYPTBYPASSPHRASE('startprojectPostDemo__#05012017_by@Manuel', @prmstrClave)
	return @binClave
END
GO
--Ingresando data a las tablas
INSERT authors (name, email, password)
VALUES ('Manuel Guarniz','cruzemg95@gmail.com',dbo.functionEncrypt('123456'))
INSERT authors (name, email, password)
VALUES ('Newton Guarniz','nguarniz@gmail.com',dbo.functionEncrypt('123456')),
('Vanessa Guarniz','vanessaguarniz@gmail.com',dbo.functionEncrypt('123456')),
('Juan Aguilar','jaguilar@gmail.com',dbo.functionEncrypt('123456')),
('Tomas Perez','tperez@gmail.com',dbo.functionEncrypt('123456'))
GO
SELECT authorId, name, email, dbo.functionDecrypt(password) [password] FROM authors