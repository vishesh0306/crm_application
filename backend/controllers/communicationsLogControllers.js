const CommunicationsLog = require('../models/CommunicationLog');

exports.createLog = (req, res) => {
    const newLog = req.body;

    CommunicationsLog.create(newLog, (err, result) => {
        if (err) {
            console.error('Error creating log:', err);
            res.status(500).send('Error creating log.');
            return;
        }
        res.status(201).send('Log created successfully');
    });
};

exports.getAllLogs = (req, res) => {
    CommunicationsLog.getAll((err, logs) => {
        if (err) {
            console.error('Error retrieving logs:', err);
            res.status(500).send('Error retrieving logs.');
            return;
        }
        res.status(200).send(logs);
    });
};

exports.getLogById = (req, res) => {
    const logId = req.params.id;

    CommunicationsLog.getById(logId, (err, log) => {
        if (err) {
            console.error('Error retrieving log:', err);
            res.status(500).send('Error retrieving log.');
            return;
        }
        res.status(200).send(log);
    });
};
