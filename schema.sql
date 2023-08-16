/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);