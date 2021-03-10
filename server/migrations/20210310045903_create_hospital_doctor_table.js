exports.up = function (knex) {
  return knex.raw(`
    CREATE TABLE app.hospital_doctor (
      hospital_id integer REFERENCES app.hospital(hospital_id) NOT NULL,
      doctor_id integer REFERENCES app.doctor(doctor_id) NOT NULL,
      PRIMARY KEY (hospital_id, doctor_id)
    );

    CREATE INDEX hospital_doctor_hospital_id_fkey ON app.hospital_doctor(hospital_id);
    CREATE INDEX hospital_doctor_doctor_id_fkey ON app.hospital_doctor(doctor_id);
  `);
};

exports.down = function (knex) {
  return knex.raw(`
    DROP INDEX hospital_doctor_doctor_id_fkey;
    DROP INDEX hospital_doctor_hospital_id_fkey;
    
    DROP TABLE app.hospital_doctor;  
  `);
};
