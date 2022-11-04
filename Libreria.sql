DROP TABLE publicacion;
DROP TABLE revista;
DROP TABLE referencias;
DROP TABLE autoresxarticulo;
DROP TABLE autor;
DROP TABLE articuloxarea;
DROP TABLE articulo;
DROP TABLE area;
drop view v_numerodereferenciashaciaelarticulo;
drop view v_numerodeautores;
drop view v_numerodearticulosdereferencias;
drop view numeroacticulospublicados;
drop view numerodeautorespublicadosporanio;
drop view totalarticulosporanio;



CREATE TABLE area (
codigoarea NUMBER(6,0) PRIMARY KEY,
nombrearea VARCHAR2(15)
);



CREATE TABLE articulo (
codigoarticulo NUMBER(6,0) PRIMARY KEY,
nombrearticulo VARCHAR2(25),
fechapublicacion DATE
);



CREATE TABLE articuloxarea(
codigoarticulo NUMBER(6,0),
codigoarea NUMBER(6,0),
PRIMARY KEY(codigoarticulo,codigoarea)
);



CREATE TABLE autor(
codigoautor NUMBER(6,0) PRIMARY KEY,
nombresautor VARCHAR2(15),
apellidosautor VARCHAR2(15),
fechanacimientoautor DATE
);



CREATE TABLE autoresxarticulo(
fk_codigoarticulo_articulo NUMBER(6,0),
fk_codigoautor_autor NUMBER(6,0),
CONSTRAINT fk_codigoarticulo_articulo FOREIGN KEY (fk_codigoarticulo_articulo) REFERENCES articulo(codigoarticulo),
CONSTRAINT fk_codigoautor_autor FOREIGN KEY (fk_codigoautor_autor) REFERENCES autor(codigoautor),
PRIMARY KEY(fk_codigoarticulo_articulo,fk_codigoautor_autor)
);



CREATE TABLE referencias(
fk_codigoarticuloref1_articulo NUMBER(6,0),
fk_codigoarticuloref2_articulo NUMBER(6,0),
CONSTRAINT fk_codigoarticuloref1_articulo FOREIGN KEY (fk_codigoarticuloref1_articulo) REFERENCES articulo(codigoarticulo),
CONSTRAINT fk_codigoarticuloref2_articulo FOREIGN KEY (fk_codigoarticuloref2_articulo) REFERENCES articulo(codigoarticulo),
PRIMARY KEY(fk_codigoarticuloref1_articulo,fk_codigoarticuloref2_articulo)
);



CREATE TABLE revista(
codigorevista NUMBER(6,0) PRIMARY KEY,
nombrerevista VARCHAR2(15),
categoria VARCHAR2(2)
);



CREATE TABLE publicacion (
codigorevista NUMBER(6,0),
codigoarticulo NUMBER(6,0),
fechapublicacion DATE,
PRIMARY KEY(codigorevista,codigoarticulo)
);



-- inserts de todas las tablas
INSERT INTO area (codigoarea,nombrearea)
WITH area AS (



SELECT 101, 'Medicina' FROM dual UNION ALL
SELECT 102, 'Biologia' FROM dual UNION ALL
SELECT 103, 'Humanidades' FROM dual UNION ALL
SELECT 104, 'Sociales' FROM dual UNION ALL
SELECT 105,'ASTRONOMIA' FROM dual UNION ALL
SELECT 106, 'Sociologia' FROM dual UNION ALL
SELECT 107, 'INGENIERIA' FROM dual UNION ALL
SELECT 108, 'Sexualidad' FROM dual
)




SELECT * FROM area;

INSERT INTO articulo (codigoarticulo,nombrearticulo,fechapublicacion)
WITH articulo AS(
SELECT 201, 'Hipertemia', To_date('1995-06-01', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 202, 'Cancer', To_date('1996-07-02', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 203, 'Manati', To_date('1997-08-03', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 204, 'Etica del Hombre', To_date('1998-09-04', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 205, 'Capitalismo en la Ciudad', To_date('1999-10-05', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 206, 'Uribismo en la Ciudad', To_date('2000-11-06', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 207, 'Socialismo en la Ciudad', To_date('2001-12-07', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 208, 'La celula', To_date('2002-12-08', 'YYYY-MM-DD') FROM dual
)
SELECT * FROM articulo;



INSERT INTO articuloxarea (codigoarticulo,codigoarea)
WITH articuloxarea AS(
SELECT 201,103 FROM dual UNION ALL
SELECT 201,102 FROM dual UNION ALL
SELECT 202,103 FROM dual UNION ALL
SELECT 203,104 FROM dual UNION ALL
SELECT 205,104 FROM dual UNION ALL
SELECT 204,105 FROM dual UNION ALL
SELECT 204,106 FROM dual UNION ALL
SELECT 204,107 FROM dual
)
SELECT * FROM articuloxarea;



INSERT INTO autor (codigoautor,nombresautor,apellidosautor,fechanacimientoautor)
WITH autor AS(



SELECT 301, 'Nelson', 'Mandela', To_date('1980-01-08', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 302, 'Sebastian', 'Guarnizo', To_date('1981-02-09', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 303, 'Luz', 'Campos', To_date('1982-03-10', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 304, 'Fabian', 'Ordonez', To_date('1983-04-11', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 305, 'Jeronimo', 'Roncancio', To_date('1984-05-12', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 306, 'Fernanda', 'Sancriztan',To_date('1985-06-13', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 307, 'Hector', 'diaz', To_date('1986-07-14', 'YYYY-MM-DD') FROM dual UNION ALL
SELECT 308, 'Dimas', 'Andrade', To_date('1987-08-15', 'YYYY-MM-DD') FROM dual
)
SELECT * FROM autor;

INSERT INTO autoresxarticulo (fk_codigoautor_autor,fk_codigoarticulo_articulo)
WITH autoresxarticulos AS(
SELECT 301, 203 FROM dual UNION ALL
SELECT 301, 202 FROM dual UNION ALL
SELECT 302, 203 FROM dual UNION ALL
SELECT 302, 204 FROM dual UNION ALL
SELECT 303, 205 FROM dual UNION ALL
SELECT 304, 206 FROM dual UNION ALL
SELECT 305, 207 FROM dual UNION ALL
SELECT 305, 201 FROM dual UNION ALL
SELECT 301, 207 FROM dual
)
SELECT * FROM autoresxarticulos;

INSERT INTO referencias (fk_codigoarticuloref1_articulo,fk_codigoarticuloref2_articulo)
WITH referencia AS(
SELECT 201, 206 FROM dual UNION ALL
SELECT 201, 205 FROM dual UNION ALL
SELECT 202, 205 FROM dual UNION ALL
SELECT 202, 204 FROM dual UNION ALL
SELECT 202, 206 FROM dual UNION ALL
SELECT 203, 204 FROM dual UNION ALL
SELECT 203, 208 FROM dual UNION ALL
SELECT 203, 206 FROM dual UNION ALL
SELECT 204, 203 FROM dual UNION ALL
SELECT 204, 202 FROM dual UNION ALL
SELECT 204, 201 FROM dual UNION ALL
SELECT 204, 205 FROM dual UNION ALL
SELECT 204, 206 FROM dual UNION ALL
SELECT 205, 202 FROM dual UNION ALL
SELECT 205, 201 FROM dual UNION ALL
SELECT 205, 206 FROM dual UNION ALL
SELECT 206, 201 FROM dual UNION ALL
SELECT 207, 206 FROM dual UNION ALL
SELECT 207, 201 FROM dual UNION ALL
SELECT 207, 205 FROM dual UNION ALL
SELECT 207, 202 FROM dual UNION ALL
SELECT 207, 203 FROM dual UNION ALL
SELECT 207, 204 FROM dual UNION ALL
SELECT 208, 204 FROM dual UNION ALL
SELECT 208, 206 FROM dual UNION ALL
SELECT 208, 203 FROM dual UNION ALL
SELECT 208, 202 FROM dual UNION ALL
SELECT 208, 207 FROM dual UNION ALL
SELECT 206, 206 FROM dual
)
SELECT * FROM referencia;

INSERT INTO revista (nombrerevista,codigorevista,categoria)
WITH revistas AS(
SELECT 'New York Times',401, 'A1' FROM dual UNION ALL
SELECT 'El tiempo' ,402,'A1' FROM dual UNION ALL
SELECT 'Publish' ,403,'A2' FROM dual UNION ALL
SELECT 'Semana' ,404,'A1' FROM dual UNION ALL
SELECT 'Carrusel' ,405,'B' FROM dual UNION ALL
SELECT 'Teve Novedades',406,'B' FROM dual UNION ALL
SELECT 'El clarin' ,407,'B' FROM dual UNION ALL
SELECT 'Credencial' ,408,'C' FROM dual
)
SELECT * FROM revistas;

INSERT INTO publicacion (codigorevista,codigoarticulo,fechapublicacion)
WITH publicaciones AS(



SELECT 401, 201,to_date('2001-01-02','YYYY-MM-DD') FROM dual UNION ALL
SELECT 402, 202,to_date('2002-01-03','YYYY-MM-DD') FROM dual UNION ALL
SELECT 403, 203,to_date('2003-01-04','YYYY-MM-DD') FROM dual UNION ALL
SELECT 404, 204,to_date('2004-01-05','YYYY-MM-DD') FROM dual UNION ALL
SELECT 405, 205,to_date('2005-01-06','YYYY-MM-DD') FROM dual UNION ALL
SELECT 406, 206,to_date('2006-01-07','YYYY-MM-DD') FROM dual UNION ALL
SELECT 407, 207,to_date('2007-01-08','YYYY-MM-DD') FROM dual UNION ALL
SELECT 408, 208,to_date('2008-01-09','YYYY-MM-DD') FROM dual UNION ALL
SELECT 401, 202,to_date('2009-01-10','YYYY-MM-DD') FROM dual UNION ALL
SELECT 402, 201,to_date('2009-01-11','YYYY-MM-DD') FROM dual UNION ALL
SELECT 402, 203,to_date('2010-01-11','YYYY-MM-DD') FROM dual UNION ALL
SELECT 403, 204,to_date('2011-01-12','YYYY-MM-DD') FROM dual UNION ALL
SELECT 404, 205,to_date('2012-01-13','YYYY-MM-DD') FROM dual UNION ALL
SELECT 405, 206,to_date('2013-01-14','YYYY-MM-DD') FROM dual UNION ALL
SELECT 406, 207,to_date('2014-01-15','YYYY-MM-DD') FROM dual UNION ALL
SELECT 407, 208,to_date('2015-01-16','YYYY-MM-DD') FROM dual UNION ALL
SELECT 408, 201,to_date('2016-01-05','YYYY-MM-DD') FROM dual UNION ALL
SELECT 401, 203,to_date('2017-01-06','YYYY-MM-DD') FROM dual UNION ALL
SELECT 402, 204,to_date('2018-01-07','YYYY-MM-DD') FROM dual UNION ALL
SELECT 403, 205,to_date('2019-01-08','YYYY-MM-DD') FROM dual UNION ALL
SELECT 404, 206,to_date('2020-01-09','YYYY-MM-DD') FROM dual UNION ALL
SELECT 405, 207,to_date('2021-01-10','YYYY-MM-DD') FROM dual
)
SELECT * FROM publicaciones;

COMMIT;




--Consulta #1
WITH a AS(
SELECT autor.nombresautor nombre ,autor.apellidosautor apellido,Floor ((Trunc(SYSDATE)-Trunc(fechanacimientoautor))/365 ) AS Edad,fk_codigoarticulo_articulo AS codigo FROM autor left outer join autoresxarticulo ON
autor.codigoautor=autoresxarticulo.fk_codigoautor_autor),
b AS(
SELECT articulo.codigoarticulo codigo2, nombrearticulo articulos,articulo.fechapublicacion fechas
FROM articulo)
SELECT nombre,apellido,edad,Nvl(articulos,'No tiene')NombreArticul,Nvl(To_char(fechas),'Publicaiones')FechaPublicacion FROM a left outer join b
ON codigo=codigo2;




--Consulta #2
WITH num1(numero, codigo)
AS( SELECT Count(*) numero_articulos, auxar.fk_codigoautor_autor
FROM autoresxarticulo auxar GROUP BY auxar.fk_codigoautor_autor ),

nombres (nombres,codigo2) AS(
SELECT aux.nombresautor,aux.codigoautor FROM autor aux),

areas(codigo3,nombrea) AS (SELECT a.fk_codigoautor_autor, Listagg(a.nombrearea, '; ') within GROUP (ORDER BY nombrearea) AS LISTA_NOMBRES
FROM autoresxarticulo a, articuloxarea ax, area a
WHERE a.fk_codigoarticulo_articulo=ax.codigoarticulo
AND a.codigoarea=ax.codigoarea
GROUP BY a.fk_codigoautor_autor)

SELECT nombres, Initcap(numero) numero_articulos, Initcap(nombrea)Areas
FROM num1, nombres, areas
WHERE num1.codigo = nombres.codigo2
AND codigo3 = num1.codigo;




--consulta 3
create view v_numerodereferenciashaciaelarticulo (nombre,total) as(
select ar.nombrearticulo,count(*)
from articulo ar,referencias refe
where refe.fk_codigoarticuloref2_articulo = ar.codigoarticulo
group by ar.nombrearticulo
);


create view v_numerodearticulosdereferencias (nombre,total) as(
select ar.nombrearticulo,count(*)
from articulo ar,referencias refe
where refe.fk_codigoarticuloref1_articulo = ar.codigoarticulo
group by ar.nombrearticulo
);


create view v_numerodeautores (nombre,total) as(
select ar.nombrearticulo,count(*)
from autor au,autoresxarticulo ares,articulo ar
where ares.fk_codigoarticulo_articulo = ar.codigoarticulo and ares.FK_CodigoAutor_AUTOR = au.codigoautor
group by ar.nombrearticulo
);



select ar.nombrearticulo,(
select nvl(total,0)
from v_numerodereferenciashaciaelarticulo
where nombre = ar.nombrearticulo
)as "Articulos en los que es referenciado",(
select nvl(total,0)
from v_numerodearticulosdereferencias
where nombre = ar.nombrearticulo
)as"Articolos referenciados",(
select nvl(total,0)
from v_numerodeautores
where nombre = ar.nombrearticulo)as "numero de autores"


from articulo ar,v_numerodeautores vm
group by ar.nombrearticulo;




--consluta 4
WITH NumDifarticulos(NDA,codigo) as
(
select count(ar.codigoarticulo),ar.codigoarticulo
from articulo ar,referencias ref
where ar.codigoarticulo = ref.fk_codigoarticuloref2_articulo
group by ar.codigoarticulo
),


MAXIMO(NDA) as
(
select count(ar.codigoarticulo)
from articulo ar
)
select NA.codigo
FROM NumDifarticulos NA,MAXIMO M
where NA.NDA = m.NDA
group by NA.codigo;




--consulta #5
create view numeroacticulospublicados (yr,total) as(
select Extract(Year From P.fechapublicacion)As yr, count(*)
from publicacion P,articulo ar
where Extract(Year From P.fechapublicacion)>=1000 and P.codigoarticulo = ar.codigoarticulo
group by Extract(Year From P.fechapublicacion)
);


create view numerodeautorespublicadosporanio(yr,total) as(
select Extract(Year From P.fechapublicacion)As yr, count(distinct ar.fk_codigoautor_autor)
from publicacion P,autoresxarticulo ar
where Extract(Year From P.fechapublicacion)>=1000 and P.codigoarticulo = ar.fk_codigoarticulo_articulo
group by Extract(Year From P.fechapublicacion)
);


create view totalarticulosporanio (total) as(
select count(P.codigoarticulo)
from publicacion P
);


select EXTRACT(YEAR FROM P.fechapublicacion) as yrs,
(
select nvl(total,0)
from numeroacticulospublicados
where yr=EXTRACT(YEAR FROM P.fechapublicacion)
) as "Numeros de articulos publicados por year",
(
select nvl(total,0)
from numerodeautorespublicadosporanio
where yr=EXTRACT(YEAR FROM P.fechapublicacion)
) as "Numero de autores por year",
(
select sum((na.total / ta.total)*100)
from numeroacticulospublicados na,totalarticulosporanio ta
where na.yr=EXTRACT(YEAR FROM P.fechapublicacion)
) as "porcentaje de articulos publicados"
from publicacion P
group by EXTRACT(YEAR FROM P.fechapublicacion)

union all
--esta en 0 por que no se como convertirlo a string pero da el total de als filas
select 0,(select sum(total) from numeroacticulospublicados) ,(select sum(total) from numerodeautorespublicadosporanio),(select sum(total) from totalarticulosporanio)
from dual;




--Consulta #6
with data as(
select to_char(fechapublicacion,'yyyy') fechas,(LISTAGG(nombresautor||' '||apellidosautor , ',')
WITHIN GROUP (ORDER BY fechanacimientoautor)) as LISTA_EDAD from revista,publicacion,autoresxarticulo,autor
where
revista.codigoRevista=Publicacion.CodigoRevista and
autoresxarticulo.FK_CodigoArticulo_ARTICULO=publicacion.codigoarticulo and
autor.codigoautor=autoresxarticulo.FK_CodigoAutor_AUTOR
group by fechapublicacion),
Resultado as(
select fechas,LISTA_EDAD,NVL(substr(LISTA_EDAD,1,instr(LISTA_EDAD,',',1,1)-1),'Solo un autor publico en revista ese anio')
Autor_Mas_Joven_En_Publicar_En_Revista,
substr(LISTA_EDAD,instr(LISTA_EDAD,',',-1,1)+1) Autor_Menos_Joven_En_Publicar_En_Revista
FROM data)
select FECHAS anio, Autor_Mas_Joven_En_Publicar_En_Revista, Autor_Menos_Joven_En_Publicar_En_Revista
from Resultado;




--consulta 7
/**
create view encontrarautorsinpuclicacion (nombreautor) as (
select
);




DELETE
FROM
autores au,publicacion p,articulo ar
WHERE
order_id = 1
AND item_id = 1;*/