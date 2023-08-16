/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name::text LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '01/01/2016' AND '31/12/2019';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM  animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Setting species column to unspecified
-- Verifying changes and roll back the change
-- Verifying that species went back to previous state

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE ;
SELECT COUNT(*) FROM ANIMALS;
ROLLBACK;
SELECT COUNT(*) FROM ANIMALS;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT save_point1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO save_point1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- Animals' Number
SELECT COUNT(*) FROM animals;

-- Animals that never tried to escape
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- Average weight of animals
SELECT AVG(weight_kg) FROM animals;

-- Animals that escapes the most,  the ones neutered or not
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- The minimum and maximum weight of each type of animal
SELECT species, MIN(weight_kg), MAX(weight_kg) 
FROM animals GROUP BY species;

-- The average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species, AVG(escape_attempts) 
FROM animals WHERE date_of_birth BETWEEN 
'1990-01-01' AND '2000-12-31' GROUP BY species;

-- Animals who belong to Melody Pond
SELECT * FROM animals JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

-- All the animals that are pokemon
SELECT * FROM animals JOIN species ON 
animals.species_id = species.id 
WHERE species.name = 'Pokemon';

-- All owners and their animals,including those that don't own any animal
SELECT * FROM owners LEFT JOIN animals 
ON owners.id = animals.owner_id;


-- Animals per species
SELECT species.name, COUNT(*) FROM species 
JOIN animals ON species.id = animals.species_id 
GROUP BY species.name;

-- All digimon owned by jennifer
SELECT * FROM animals JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Jennifer Orwell' 
AND animals.species_id = 2;

-- All the animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' 
AND animals.escape_attempts = 0;

-- The one who owns the most animals
SELECT owners.full_name, COUNT(animals.owner_id) FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.owner_id) DESC LIMIT 1;