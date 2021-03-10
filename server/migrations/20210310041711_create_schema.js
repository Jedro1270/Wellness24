exports.up = function (knex) {
  return knex.raw(`
    CREATE SCHEMA app;
  `);
};

exports.down = function (knex) {
  return knex.raw(`
    DROP SCHEMA app;
  `);
};
