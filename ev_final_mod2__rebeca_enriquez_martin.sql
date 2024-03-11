
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

/*___EJERCICIO 11__*/ 
-- Revisamos el esquema y vemos como se unen las tablas de renta (donde figuran los alquileres) y categoria (para obtener el nombre de la categoria)
-- Buscamos los nexos para unir las tablas, y agrupamos por Nombre-categoria
SELECT `category`.`name` AS `Category`, COUNT(`rental`.`rental_id`) AS `Rented_movies`
FROM `category`
	INNER JOIN `film_category`
    USING (category_id)
    INNER JOIN `film`
    USING (film_id)
    INNER JOIN `inventory`
    USING (film_id)
    INNER JOIN `rental`
    USING (inventory_id)
GROUP BY `Category`;

/*___EJERCICIO 12__*/     
-- Agrupamos por calificacion y realizamos la media para cada grupo
SELECT `rating` AS `calificación rating`, ROUND(AVG(`length`)) AS `Length_AVG`
FROM `film`
GROUP BY `calificación rating`;

/*___EJERCICIO 13__*/
-- En la subconsulta buscamos el ID de la peli, para poder unirlo con el actor, como no tenemos conexion directa a su tabla, primero conectamos cn la tabla intermidia
SELECT `actor`.`first_name` AS `Actor_name`, `actor`.`last_name` AS `Actor_last_name`
FROM `actor`
	INNER JOIN `film_actor`
    ON `actor`.`actor_id` = `film_actor`.`actor_id` 
    INNER JOIN `film`
    ON `film_actor`.`film_id` = `film`.`film_id` 
		WHERE `film`.`title` = "Indian Love";


/*___EJERCICIO 14___*/
-- Mostramos los titulos filtrnado que contengan CAT o DOG en alguna parte de tu titulo
SELECT `title` AS `Film_title`
FROM `film`
WHERE `title` LIKE "%Dog%" OR "%Cat%";

/*___EJERCICIO 15___*/
-- Lo podemos hacer con un LEFT JOIN o con una SUBCONSULTA
-- Con la subconsulta pasamos una lista de numeros a la queri principal y si algun ID no esta en esa lista que nos lo muestre
SELECT `actor`.`first_name` AS `Actor_name`, `actor`.`last_name` AS `Actor_last_name`
FROM `actor`
WHERE `actor`.`actor_id` NOT IN ( SELECT `film_actor`.`actor_id`
									FROM `film_actor`);   


-- Con LEFT JOIN podemos poner a la "izquierda" la tabla de actores y que lo una con la tabla FILM ACTOR y si el valor es uno que nos lo muestre por pantalla
SELECT `actor`.`first_name` AS `Actor_name`, `actor`.`last_name` AS `Actor_last_name`
FROM `actor`
	LEFT JOIN `film_actor`
    ON `actor`.`actor_id` = `film_actor`.`actor_id`
        WHERE `film_actor`.`actor_id` IS NULL;
     
    