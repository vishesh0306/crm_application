const db = require('../config/db');

const Campaign = {
    create: (newCampaign, callback) => {
        const query = 'INSERT INTO campaigns SET ?';
        db.query(query, newCampaign, callback);
    },

    getAll: (callback) => {
        const query = 'SELECT * FROM campaigns';
        db.query(query, callback);
    },

    getById: (id, callback) => {
        const query = 'SELECT * FROM campaigns WHERE id = ?';
        db.query(query, [id], callback);
    }
};

module.exports = Campaign;