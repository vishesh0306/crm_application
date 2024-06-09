const mysql = require('mysql2');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

// Listen for the 'connection' event to check if the connection is successful
pool.on('connection', () => {
    console.log('Connected to MySQL server');
});

// Listen for the 'error' event to handle connection errors
pool.on('error', (err) => {
    console.error('Error connecting to MySQL server:', err);
});

module.exports = pool;