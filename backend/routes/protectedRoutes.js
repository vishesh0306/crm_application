const express = require('express');
const router = express.Router();
const protectedController = require('../controllers/protectedControllers');
const authMiddleware = require('../middleware/authMiddleware');

router.get('/working', authMiddleware.authenticateJWT, protectedController.working);

module.exports = router;