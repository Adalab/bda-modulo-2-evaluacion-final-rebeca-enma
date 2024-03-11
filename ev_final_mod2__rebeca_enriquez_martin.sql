
-- Trabajamos con la BBDD de Sakila, para ello lo primero que hacemos es seleccionarla.
USE sakila;

/*___EJERCICIO 1__*/
-- Seleccionamos todos los nombres de la tabla films con la clausula DISTINCT para evitar duplicados

SELECT DISTINCT `title` AS `Titulos_peliculas`
FROM `film`;

/*___EJERCICIO 2__*/
-- Seleccionamos todos los nombres de peliculas y filtamos por la clasificacion "PG-13"

SELECT `title` AS `Peliculas_calificadas_PG-13`
FROM `film`
	WHERE `rating` = "PG-13";
    
/*___EJERCICIO 3__*/
-- Seleccionamos todos los nombres de peliculas y filtamos porque en la descripcion tenga la palabra amazing en cualquier posicion

SELECT  `title` AS `Pelicula`, `description` AS `Sinopsis`
FROM `film`
	WHERE `description` LIKE "%amazing%";
    

/*___EJERCICIO 4__*/
-- Seleccionamos el nombres de peliculas y filtamos porque en la duracion sea superior a 120 min

SELECT `title` AS `Pelicula`
FROM `film`
	WHERE `length` > 120;
    
/*___EJERCICIO 5__*/
-- Seleccionamos el nombres de los actores
SELECT `first_name` AS `Name_actor`
FROM `actor`;

-- Seleccionamos el nombres de los actores SIN DUPLICADOS
SELECT DISTINCT`first_name` AS `Name_actor`
FROM `actor`;

