const express = require('express');
const router = express.Router();
const campaignController = require('../controllers/campaignControllers');
const authMiddleware = require('../middleware/authMiddleware');

router.post('/create', authMiddleware.authenticateJWT, campaignController.createCampaign);
router.get('/getall', authMiddleware.authenticateJWT, campaignController.getAllCampaigns);
router.get('/getmorethanten', authMiddleware.authenticateJWT, campaignController.getMoreThanTenK);
router.get('/getmorethantenthreev', authMiddleware.authenticateJWT, campaignController.getMoreThanTenKnThreeV);
router.get('/:id', authMiddleware.authenticateJWT, campaignController.getCampaignById);

module.exports = router;