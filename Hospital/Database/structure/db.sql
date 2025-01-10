CREATE DATABASE "Hospital"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE Doctor (
    Doctor_id SERIAL PRIMARY KEY,
    lastname VARCHAR(50),
    firstname VARCHAR(50),
    surname VARCHAR(50),
    specialization VARCHAR(100)
);

CREATE TABLE Patient (
    Patient_id SERIAL PRIMARY KEY,
    lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    surname VARCHAR(50),
    phone VARCHAR(15),
    card_number VARCHAR(20) UNIQUE,
    diagnosis VARCHAR(255),
    doctor_id INT,
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES Doctor(Doctor_id) ON DELETE SET NULL
);