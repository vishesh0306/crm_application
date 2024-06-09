const db = require('../config/db');

const Order = {
    create: (newOrder, callback) => {
        const query = 'INSERT INTO orders SET ?';
        db.query(query, newOrder, callback);
    },

    getAll: (callback) => {
        const query = 'SELECT * FROM orders';
        db.query(query, callback);
    },

    getById: (id, callback) => {
        const query = 'SELECT * FROM orders WHERE id = ?';
        db.query(query, [id], callback);
    }
};

module.exports = Order;
