
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
     
/*___EJERCICIO 16___*/
-- Seleccionamos el nombre de la pelicula y filtamos el año de lanzamiento entre los años 2005 y 2010
SELECT `title` AS `Film_title`
FROM `film`
WHERE `release_year` BETWEEN 2005 AND 2010;

/*___EJERCICIO 17___*/    
-- Mostramos todas las peliculas que son de la misma categoria que "FAMILIA", para ello nos creamos una CTE (Tabla temporal) 
-- en la que buscamos el ID de la categoria que queremos 
-- Hacemos una union de tablas a traves de la columna que tienen en comun (utilizamos USING porque tienen el mismo nombre)
-- finalmente en vez de utilizar WHERE utilizamos un join para hacer un filtrado por la categoria seleccionada en la CTE
		
WITH `Categoria_CTE` AS (
						 SELECT `category`.`category_id`
                         FROM `category`
								WHERE `category`.`name` = "Family")

SELECT `film`.`title` AS `Film_Famiy_Category`
FROM `film`
	INNER JOIN `film_category`  AS `Categoria`
	USING (film_id)
		INNER JOIN `Categoria_CTE`
			ON `Categoria`.`category_id` = `Categoria_CTE`.`category_id`;
            
/*___EJERCICIO 18___*/	
-- Mostramos nombre y apellido de los actores que han aparecido en mas de 10 peliculas, unimos actores con la tabla intermedia a peliculas
-- Agrupamos por ID actor y filtamos por los actores que su recuento sea superior a 10 
SELECT `actor`.`first_name` AS `Actor_name`, `actor`.`last_name` AS `Actor_last_name`
FROM `actor`
	INNER JOIN `film_actor`
    USING (actor_id)
GROUP BY `film_actor`.`actor_id`
HAVING COUNT(`film_actor`.`film_id`) > 10;

/*___EJERCICIO 19___*/	
-- Mostramos los titutlos de las peliculas que tienen una duracion > 2 horas y son clasificadas como R
SELECT `film`.`title` AS `Film_Rating_"R"_&_Length > 2H`
FROM `film`
	WHERE `rating` = "R" AND `length` > 120;
    
/*___EJERCICIO 20___*/	    
-- Buscamos la duracion de las peliculas y lo unimos con el ID categoria
-- Unimos ID categoria con el la tabla donde se encuentra el nombre 
-- Agrupamos por nombre categoria y filtamos duracion media 
SELECT ROUND(AVG(`film`.`length`),2) AS `AVG_Length`, `category`.`name` AS `Category_Name` 
FROM `film`
	INNER JOIN `film_category`  		 -- Obtenemos ID categoria
	USING (film_id)             
	INNER JOIN `category`                -- Obtenemos NOMBRE categoria    
	USING (category_id)
GROUP BY `film_category`.`category_id`   -- Agrupamos por categoria 
HAVING AVG(`film`.`length`) > 120;       -- Filtramos por duracion


/*___EJERCICIO 21___*/	
-- Mostramos nombre y apellido de los actores que han aparecido en 5 o mas peliculas, unimos actores con la tabla intermedia a peliculas
-- Agrupamos por ID actor y filtamos por los actores que su recuento sea >= 5 
SELECT `actor`.`first_name` AS `Actor_name`, `actor`.`last_name` AS `Actor_last_name`, COUNT(`film_actor`.`film_id`) AS `N_Films`
FROM `actor`
	INNER JOIN `film_actor`
    USING (actor_id)
GROUP BY `film_actor`.`actor_id`
HAVING COUNT(`film_actor`.`film_id`) >= 5;

/*___EJERCICIO 22___*/	

SELECT DISTINCT`film`.`title` AS `Film_rent_>5days` -- Seleccionamos los titulos de las pelis, eliminando duplicados
FROM `film`
	INNER JOIN `inventory`									-- UNIMOS INVENTARIO CON PELICULAS CUANDO SE CUMPLA LA SUBQUERI
    ON `film`.`film_id` = `inventory`.`film_id`
		WHERE `inventory`.`inventory_id` IN (
											SELECT `rental`.`inventory_id`				-- SELECCIONAMOS LOS ID DE INVENTARIO HAN SIDO ALQUILADAS > 5 DIAS
											FROM `rental`
												WHERE DATEDIFF(return_date, rental_date) > 5);
                                                
/*___EJERCICIO 23___*/	
-- En la subqueri buscamos todos los actores que han participado en una pelicula de HORROR
-- En la Queri comparamos el ID y seleccionamos los que NO hayan participado en peliculas de HORROR
	
SELECT `actor`.`first_name` AS `NOMBRE`, `actor`.`last_name` AS `APELLIDO`  -- Seleccionamos el NOMBRE y Apellido de los actores que NO han participado en pelis del genero HORROR
FROM `actor`
    WHERE `actor`.`actor_id` NOT IN (
										SELECT `film_actor`.`actor_id`  -- Seleccionamos el ID de los actores que han participado en pelis del genero HORROR
										FROM  `film_actor`
											INNER JOIN `film` -- Unimos actor con pelicula
											USING (film_id)
											INNER JOIN `film_category` -- Unimos el ID de las peliculas del genero HORROR
											USING (film_id)
											INNER JOIN `category` -- Unimos obteneiendo el ID de la categoria
											USING (category_id)
											WHERE `category`.`name` = "Horror");   -- filtramos por ID de la categoria HORROR 
                                            
/*_________________________BONUS_____________________________*/	  
                                          
/*___EJERCICIO 24___*/
-- Nombre pelis duracion > 180 y genero COMEDIA
SELECT `film`.`title`AS `Comedy_Film_Length_>180_Min` 
FROM `film`
	INNER JOIN `film_category` 	-- Unimos para obtener el ID de las peliculas del genero COMEDY
	USING (film_id)
		WHERE `film`.`length` >180  AND `film_category`.`category_id` IN 
																	(SELECT `category`.`category_id` -- Seleccionamos el ID de la categoria COMEDY
																		FROM `category`
																		WHERE `category`.`name` = "Comedy"); 
                                                                        
 /*___EJERCICIO 25__*/	
-- Actores que han actuado juntos en al menos una película y numero de pelis
-- Valores duplicados porque cuando el nombre de actor 2 vuelva a la posicion 1, duplicara datos 
         
SELECT `ACT1`.`first_name` AS `Name_ACTOR1`, `ACT1`.`last_name` AS `Last_name_ACTOR1`,
		`ACT2`.`first_name` AS `Name_ACTOR2`, `ACT2`.`last_name` AS `Last_name_ACTOR2`, COUNT(*) AS `Common_Movies`
FROM `actor` AS `ACT1`
		INNER JOIN `film_actor` AS `FM1`                        -- Obtenemos las pelis en las que ha participado el actor
		ON `ACT1`.`actor_id` = `FM1`.`actor_id`
        INNER JOIN `film_actor` AS `FM2`     					-- Obtenemos los compañeros				
		ON `FM1`.`film_id` = `FM2`.`film_id` 
			AND `FM1`.`actor_id` <> `FM2`.`actor_id`
		INNER JOIN `actor` AS `ACT2`                       	   -- Obtenemos los valores del compañero
		ON `ACT2`.`actor_id` = `FM2`.`actor_id`
GROUP BY `ACT1`.`actor_id`, `ACT2`.`actor_id`;                                                                       
        
        
        