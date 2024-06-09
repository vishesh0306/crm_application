const express = require('express');
const router = express.Router();
const communicationsLogController = require('../controllers/communicationsLogControllers');
const authMiddleware = require('../middleware/authMiddleware');

router.post('/', authMiddleware.authenticateJWT, communicationsLogController.createLog);
router.get('/', authMiddleware.authenticateJWT, communicationsLogController.getAllLogs);
router.get('/:id', authMiddleware.authenticateJWT, communicationsLogController.getLogById);

module.exports = router;