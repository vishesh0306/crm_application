const Campaign = require('../models/Campaign');

exports.createCampaign = (req, res) => {
    const newCampaign = req.body;

    Campaign.create(newCampaign, (err, result) => {
        if (err) {
            console.error('Error creating campaign:', err);
            res.status(500).send('Error creating campaign.');
            return;
        }
        res.status(201).send('Campaign created successfully');
    });
};

exports.getAllCampaigns = (req, res) => {
    Campaign.getAll((err, campaigns) => {
        if (err) {
            console.error('Error retrieving campaigns:', err);
            res.status(500).send('Error retrieving campaigns.');
            return;
        }
        res.status(200).send(campaigns);
    });
};

exports.getCampaignById = (req, res) => {
    const campaignId = req.params.id;

    Campaign.getById(campaignId, (err, campaign) => {
        if (err) {
            console.error('Error retrieving campaign:', err);
            res.status(500).send('Error retrieving campaign.');
            return;
        }
        res.status(200).send(campaign);
    });
};

exports.getMoreThanTenK = (req, res) => {
    Campaign.getMoreThanTenK((err, campaign) => {
        if (err) {
            console.error('Error retrieving campaign:', err);
            res.status(500).send('Error retrieving campaign.');
            return;
        }
        res.status(200).send(campaign);
    });
};

exports.getMoreThanTenKnThreeV = (req, res) => {
    Campaign.getMoreThanTenKnThreeV((err, campaign) => {
        if (err) {
            console.error('Error retrieving campaign:', err);
            res.status(500).send('Error retrieving campaign.');
            return;
        }
        res.status(200).send(campaign);
    });
};
