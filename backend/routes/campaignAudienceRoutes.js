const express = require('express');
const router = express.Router();
const campaignAudienceController = require('../controllers/campaignAudienceControllers');
const authMiddleware = require('../middleware/authMiddleware');

router.post('/', authMiddleware.authenticateJWT, campaignAudienceController.createAudience);
router.get('/', authMiddleware.authenticateJWT, campaignAudienceController.getAllAudiences);
router.get('/customercount', authMiddleware.authenticateJWT, campaignAudienceController.getAllCount);
router.get('/:id', authMiddleware.authenticateJWT, campaignAudienceController.getAudienceById);

module.exports = router;
