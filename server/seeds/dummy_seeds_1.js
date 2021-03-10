exports.seed = function (knex) {
  return knex.raw(`
    INSERT INTO app.hospital VALUES
    (1, 'Antique Dummy Hospital', 'Antique'),
    (2, 'Iloilo Dummy Hospital', 'Iloilo City');


    INSERT INTO app.doctor VALUES
    (1, 'Jedro', 'Pagayonan', 'J', 'jed@gmail.com', 'jed', '1111', 'Neuro Surgeon', '09111111111'),
    (2, 'Elimjoyce', 'Abagat', 'E', 'darla@gmail.com', 'darla', '2222', 'Pediatrician', '09222222222'),
    (3, 'Alejandro', 'Jonela', 'A', 'al@gmail.com', 'al', '3333', 'Cardiologist', '09333333333');

    INSERT INTO app.hospital_doctor VALUES
    (1, 1),
    (1, 2),
    (2, 3);
  `);
};
