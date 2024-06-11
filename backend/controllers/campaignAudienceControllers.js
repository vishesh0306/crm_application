const CampaignAudience = require('../models/CampaignAudience');

exports.createAudience = (req, res) => {
    const newAudience = req.body;

    CampaignAudience.create(newAudience, (err, result) => {
        if (err) {
            console.error('Error creating audience:', err);
            res.status(500).send('Error creating audience.');
            return;
        }
        res.status(201).send('Audience created successfully');
    });
};

exports.getAllAudiences = (req, res) => {
    CampaignAudience.getAll((err, audiences) => {
        if (err) {
            console.error('Error retrieving audiences:', err);
            res.status(500).send('Error retrieving audiences.');
            return;
        }
        res.status(200).send(audiences);
    });
};


exports.getAllCount = (req, res) => {
    CampaignAudience.getCount((err, audiences) => {
        if (err) {
            console.error('Error retrieving audiences:', err);
            res.status(500).send('Error retrieving audiences.');
            return;
        }
        res.status(200).send(audiences);
    });
};




exports.getAudienceById = (req, res) => {
    const audienceId = req.params.id;

    CampaignAudience.getById(audienceId, (err, audience) => {
        if (err) {
            console.error('Error retrieving audience:', err);
            res.status(500).send('Error retrieving audience.');
            return;
        }
        res.status(200).send(audience);
    });
};
