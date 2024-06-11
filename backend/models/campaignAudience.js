const db = require('../config/db');

const CampaignAudience = {
    create: (newAudience, callback) => {
        const query = 'INSERT INTO campaign_audiences SET ?';
        db.query(query, newAudience, callback);
    },

    getAll: (callback) => {
        const query = 'SELECT * FROM campaign_audiences';
        db.query(query, callback);
    },

    getById: (id, callback) => {
        const query = 'SELECT * FROM campaign_audiences WHERE id = ?';
        db.query(query, [id], callback);
    },

    getCount: (callback) => {
            const query = 'SELECT COUNT(*) FROM customer';
            db.query(query, callback);
    }
};

module.exports = CampaignAudience;
