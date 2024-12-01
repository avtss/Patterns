CREATE DATABASE student;

CREATE TABLE student (
	id SERIAL PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    surname TEXT NOT NULL,
    phone TEXT UNIQUE,
    email TEXT UNIQUE,
    telegram TEXT UNIQUE,
    github TEXT UNIQUE,
    birth_date DATE NOT NULL
);
