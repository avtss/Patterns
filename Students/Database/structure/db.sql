CREATE DATABASE student;
USE student;

CREATE TABLE student (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    surname TEXT NOT NULL,
    phone TEXT,
    email TEXT,
    telegram TEXT,
    github TEXT,
    birth_date DATE NOT NULL
);

ALTER TABLE student AUTO_INCREMENT = 1;

ALTER TABLE student ADD UNIQUE (telegram(255)), ADD UNIQUE (email(255)), ADD UNIQUE (github(255)), ADD UNIQUE (phone(255));