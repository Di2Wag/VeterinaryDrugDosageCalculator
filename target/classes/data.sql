/* DRUGS */
INSERT INTO drugs (generic_name, therapeutic_class) VALUES
('Amoxycillin/Clavulanic acid','Antibiotic'),
('Meloxicam','NSAID');

/* FORMULATIONS */
INSERT INTO formulations (drug_id, concentration, concentration_unit, denominator_value,denominator_unit, presentation_form) VALUES
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 312.5, 'mg', 5.0, 'ml', 'oral suspension'),
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 500, 'mg', 1.0, 'tablet', 'tablet'),
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 62.5, 'mg', 1.0, 'tablet', 'tablet'),
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 175, 'mg', 1.0, 'ml', 'injectable'),
((SELECT id FROM drugs WHERE generic_name = 'Meloxicam'), 1.5, 'mg', 1.0, 'ml', 'oral suspension'),
((SELECT id FROM drugs WHERE generic_name = 'Meloxicam'), 5, 'mg', 1.0, 'ml', 'injectable'),
((SELECT id FROM drugs WHERE generic_name = 'Meloxicam'), 1, 'mg', 1.0, 'tablet', 'tablet'),
((SELECT id FROM drugs WHERE generic_name = 'Meloxicam'), 2.5, 'mg', 1.0, 'tablet', 'tablet');

/* DOSES */
INSERT INTO recommended_dosages (drug_id, species, presentation_form, min_dose_kg, max_dose_kg, dose_unit, max_administration_frequency_hours, min_administration_frequency_hours, notes) VALUES
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 'dog', 'injectable', 8.75, 25, 'mg', 24, 24, 'SC'),
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 'cat', 'injectable', 8.75, 25, 'mg', 24, 24, 'SC'),
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 'dog', 'tablet', 12.5, 25, 'mg', 8, 12, 'Oral administration with food'),
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 'cat', 'tablet', 12.5, 25, 'mg', 8, 12, 'Oral administration with food'),
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 'dog', 'oral suspension', 12.5, 25, 'mg', 8, 12, 'Oral administration with food'),
((SELECT id FROM drugs WHERE generic_name = 'Amoxycillin/Clavulanic acid'), 'cat', 'oral suspension', 12.5, 25, 'mg', 8, 12, 'Oral administration with food'),
((SELECT id FROM drugs WHERE generic_name = 'Meloxicam'), 'dog', 'tablet', 0.1, 0.1, 'mg', 24, 24, 'Oral administration with food'),
((SELECT id FROM drugs WHERE generic_name = 'Meloxicam'), 'cat', 'tablet', 0.05, 0.05, 'mg', 24, 24, 'Oral administration with food'),
((SELECT id FROM drugs WHERE generic_name = 'Meloxicam'), 'dog', 'injectable', 0.1, 0.1, 'mg', 24, 24, 'SC'),
((SELECT id FROM drugs WHERE generic_name = 'Meloxicam'), 'cat', 'injectable', 0.05, 0.05, 'mg', 24, 24, 'SC');