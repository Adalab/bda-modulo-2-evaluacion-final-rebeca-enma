
-- Trabajamos con la BBDD de Sakila, para ello lo primero que hacemos es seleccionarla.
USE sakila;

/*___EJERCICIO 1__*/
-- Seleccionamos todos los nombres de la tabla films con la clausula DISTINCT para evitar duplicados
SELECT DISTINCT `title` AS `Film_title`
FROM `film`;

/*___EJERCICIO 2__*/
-- Seleccionamos todos los nombres de peliculas y filtamos por la clasificacion "PG-13"
SELECT `title` AS `FILM_RATING_PG-13`
FROM `film`
	WHERE `rating` = "PG-13";
    
/*___EJERCICIO 3__*/
-- Seleccionamos todos los nombres de peliculas y filtamos porque en la descripcion tenga la palabra amazing en cualquier posicion
SELECT  `title` AS `Film`, `description` AS `Sinopsis`
FROM `film`
	WHERE `description` LIKE "%amazing%";
    

/*___EJERCICIO 4__*/
-- Seleccionamos el nombres de peliculas y filtamos porque en la duracion sea superior a 120 min
SELECT `title` AS `Film`
FROM `film`
	WHERE `length` > 120;
    
/*___EJERCICIO 5__*/
-- Seleccionamos el nombres de los actores
SELECT `first_name` AS `Name_actor`
FROM `actor`;

-- Seleccionamos el nombres de los actores SIN DUPLICADOS
SELECT DISTINCT`first_name` AS `Name_actor`
FROM `actor`;

/*___EJERCICIO 6__*/
-- Seleccionamos el nombres y apellido de los actores filtrando si contiene "GIBSON" en el apellido
SELECT `first_name` AS `Name`, `last_name` AS `Last_name`
FROM `actor`
	WHERE `last_name` LIKE "%Gibson%";
    
    
/*___EJERCICIO 7__*/
-- Seleccionamos el nombres de los actores que tienen un ID entre 10 y 20
SELECT `first_name` AS `Name`,`actor_id`
FROM `actor`
	WHERE `actor_id` BETWEEN 10 AND 20;

-- Tambien podriamos hacerlo con un limit y offset     
SELECT `first_name` AS `Name`,`actor_id`
FROM `actor`
	ORDER BY `actor_id` ASC
    LIMIT 11
    OFFSET 9;
    
    
/*___EJERCICIO 8__*/
-- Seleccionamos el titulo de las peliculas que su calificacion sea diferente a ""PG-13" y "R"
SELECT `title` AS `Film_title` 
FROM `film`    
	WHERE `rating` NOT IN ("PG-13", "R");
 
 
/*___EJERCICIO 9__*/  
-- Selecionamos el nombre y la calificacion, agrupamos por las calificaciones que hay en la tabla y hacemos el recuento de peliculas por cada agrupacion  
SELECT `rating` AS `Classification`, COUNT(`rating`) AS `Film_Count`
FROM `Film`
GROUP BY `Classification`;


/*___EJERCICIO 10__*/ 
-- Seleccinamos nombre y apellido de la tabla clientes lo unimos con la tabla de alquiler a traves del ID y contamos las peliculas alquiladas por cliente 
SELECT `customer`.`customer_id` AS `ID_Customer`, `customer`.`first_name` AS `Customer_name`, `customer`.`last_name` AS `Customer_last_Name`,
		COUNT(`rental`.`rental_id`) AS `Rented_movies`
FROM `customer`
	INNER JOIN `rental`
    USING (customer_id)
GROUP BY `rental`.`customer_id`;