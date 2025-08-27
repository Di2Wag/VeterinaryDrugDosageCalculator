DROP TABLE IF EXISTS drug_interactions;
DROP TABLE IF EXISTS recommended_dosages;
DROP TABLE IF EXISTS formulations;
DROP TABLE IF EXISTS drugs;
DROP TYPE IF EXISTS pet_species;
DROP TYPE IF EXISTS drug_presentation_form;

CREATE TYPE pet_species AS ENUM ('dog', 'cat');
CREATE TYPE drug_presentation_form AS ENUM ('tablet', 'oral suspension', 'injectable');

CREATE TABLE drugs (
    id SERIAL PRIMARY KEY,
    generic_name VARCHAR(100) NOT NULL UNIQUE,
    therapeutic_class VARCHAR (100) NOT NULL
);

CREATE TABLE formulations (
    id SERIAL PRIMARY KEY,
    drug_id INT NOT NULL,
    concentration NUMERIC(10,4) NOT NULL,
    concentration_unit VARCHAR(50) NOT NULL,
    denominator_value NUMERIC(10,4) NOT NULL,
    denominator_unit VARCHAR(50) NOT NULL,
    presentation_form drug_presentation_form NOT NULL,
    FOREIGN KEY(drug_id) REFERENCES drugs(id) ON DELETE CASCADE
);

CREATE TABLE recommended_dosages (
    id SERIAL PRIMARY KEY,
    drug_id INT NOT NULL,
    species pet_species NOT NULL,
    presentation_form drug_presentation_form NOT NULL,
    min_dose_kg NUMERIC(10,4) NOT NULL,
    max_dose_kg NUMERIC(10,4) NOT NULL,
    dose_unit VARCHAR(50) NOT NULL,
    max_administration_frequency_hours INT NOT NULL,
    min_administration_frequency_hours INT NOT NULL,
    notes TEXT,
    UNIQUE (drug_id, species, presentation_form),
    FOREIGN KEY(drug_id) REFERENCES drugs(id) ON DELETE CASCADE
);

/*linking table  --  many-to-many*/
CREATE TABLE drug_interactions (
    drug_id_1 INT NOT NULL,
    drug_id_2 INT NOT NULL,
    notes TEXT,
    PRIMARY KEY (drug_id_1, drug_id_2),
    FOREIGN KEY(drug_id_1) REFERENCES drugs(id) ON DELETE CASCADE,
    FOREIGN KEY(drug_id_2) REFERENCES drugs(id) ON DELETE CASCADE,
    CHECK (drug_id_1 < drug_id_2)
);