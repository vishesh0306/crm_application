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
    },

    getMoreThanTenK: (callback) => {
        const query = `
            SELECT c.id, c.name, c.email, c.phone_no, SUM(o.total_amount) AS total_spend
            FROM customer c
            JOIN orders o ON c.id = o.customer_id
            WHERE o.status = 'completed'
            GROUP BY c.id, c.name, c.email, c.phone_no
            HAVING total_spend > 10000;
        `;
        db.query(query, callback);
    },

    getMoreThanTenKnThreeV: (callback) => {
        const query = `
            SELECT c.id, c.name, c.email, c.phone_no, SUM(o.total_amount) AS total_spend, c.no_of_visits
            FROM customer c
            JOIN orders o ON c.id = o.customer_id
            WHERE o.status = 'completed'
            GROUP BY c.id, c.name, c.email, c.phone_no, c.no_of_visits
            HAVING total_spend > 10000 AND c.no_of_visits < 3;
        `;
        db.query(query, callback);
    },

    getNotVisitedWithinThreeMonths: (callback) => {
        const query = `
            SELECT c.id, c.name, c.email, c.phone_no
            FROM customer c
            LEFT JOIN orders o ON c.id = o.customer_id
            WHERE o.order_date IS NULL OR o.order_date < DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
            GROUP BY c.id, c.name, c.email, c.phone_no;
        `;
        db.query(query, callback);
    }
};

module.exports = Campaign;