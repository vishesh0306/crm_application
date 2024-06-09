const db = require('../config/db');

const CommunicationsLog = {
    create: (newLog, callback) => {
        const query = 'INSERT INTO communications_log SET ?';
        db.query(query, newLog, callback);
    },

    getAll: (callback) => {
        const query = 'SELECT * FROM communications_log';
        db.query(query, callback);
    },

    getById: (id, callback) => {
        const query = 'SELECT * FROM communications_log WHERE id = ?';
        db.query(query, [id], callback);
    }
};

module.exports = CommunicationsLog;
