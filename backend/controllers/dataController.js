const pool = require('../config/db');

exports.insertData = (req, res) => {
    const newData = req.body;

    pool.query('INSERT INTO dummydata SET ?', newData, (err, results) => {
        if (err) {
            console.error('Error inserting data:', err);
            res.status(500).send('Error inserting data');
            return;
        }

        console.log('Inserted data successfully');
        res.send('Inserted data successfully');
    });
};

exports.getDbStatus = (req, res) => {
    if (pool._closed === false) {
        res.status(200).send('Database connection pool is active');
    } else {
        res.status(500).send('Database connection pool is not active');
    }
};
