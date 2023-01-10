-- vraag1

select first_name, last_name
from actor
where last_name like 'C%a%';

-- vraag2

select count(*) as aantal_acteurs_vraag1
from actor
where last_name like 'C%a%';

-- vraag3

select actor.first_name, actor.last_name, film.title
from actor join film_actor
on actor.actor_id = film_actor.actor_id
join film
on film.film_id = film_actor.film_id
where actor.last_name like 'C%a%';

-- vraag4

select actor.first_name, actor.last_name, count(film.film_id) as aantal_gespeelde_films
from actor join film_actor
on actor.actor_id = film_actor.actor_id
join film
on film.film_id = film_actor.film_id
where actor.last_name like 'C%a%'
group by actor.last_name, actor.first_name;

-- vraag5

select actor.first_name, actor.last_name, category.name, count(film.film_id)
from actor join film_actor
on actor.actor_id = film_actor.actor_id
join film
on film.film_id = film_actor.film_id
join film_category
on film.film_id = film_category.film_id
join category
on category.category_id = film_category.category_id
group by actor.last_name, actor.first_name, category.name
having count(film.film_id) > 5 and actor.last_name like 'C%a%'
order by category.name desc;

-- vraag6
--comment -> we kennen de acteurs van vorige oef (6)

select actor.first_name, actor.last_name, 
((count(film.film_id)*100)/(select count(film_id) from film)) as percent
from actor join film_actor
on actor.actor_id = film_actor.actor_id
join film
on film.film_id = film_actor.film_id
where actor.last_name='Chaplin'
or
actor.actor_id = (
    select actor.actor_id from actor
    where actor.last_name = 'Chase' and actor.first_name = 'Ed'
)
group by actor.last_name, actor.first_name;


-- vraag7
--klopt niet volgens controle ...
select film.title, count(inventory.film_id) as aantal_in_stock
from actor join film_actor
on actor.actor_id = film_actor.actor_id
join film
on film.film_id = film_actor.film_id
join inventory
on film.film_id = inventory.film_id
where actor.last_name like 'C%a%'
group by film.title
order by aantal_in_stock desc;

--controle
select film_id from film
where title = 'Velvet Terminator';

select count(*) from inventory
where film_id = (
    select film_id from film
    where title = 'Velvet Terminator'
);
select count(*) from inventory
where film_id = 938;



