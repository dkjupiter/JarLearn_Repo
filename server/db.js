const { Pool } = require("pg");

const pool = process.env.DATABASE_URL
  ? new Pool({
      connectionString: process.env.DATABASE_URL,
      ssl: { rejectUnauthorized: false },
    })
  : new Pool({
      host: "localhost",
      user: "postgres",
      password: "1234",
      database: "mydb",
      port: 5432,
    });

module.exports = pool;