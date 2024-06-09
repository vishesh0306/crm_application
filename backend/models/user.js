const db = require('../config/db');

const User = {
    create: (newUser, callback) => {
        const query = 'INSERT INTO users SET ?';
        db.query(query, newUser, callback);
    },

    findByEmail: (email, callback) => {
        const query = 'SELECT * FROM users WHERE email = ?';
        db.query(query, [email], callback);
    },

    getAll: (callback) => {
        const query = 'SELECT * FROM users';
        db.query(query, callback);
    }
};

module.exports = User;