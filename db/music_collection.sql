DROP TABLE albums;
DROP TABLE artists;


CREATE TABLE artists(
id SERIAL PRIMARY KEY,
first_name VARCHAR(255),
last_name VARCHAR(255),
age INT
);

CREATE TABLE albums(
id SERIAL PRIMARY KEY,
title VARCHAR(255),
release_year INT,
artist_id INT REFERENCES artists(id)
);
