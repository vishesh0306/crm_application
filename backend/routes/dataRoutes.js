const express = require('express');
const router = express.Router();
const dataController = require('../controllers/dataController');

router.post('/insertData', dataController.insertData);
router.get('/dbStatus', dataController.getDbStatus);

module.exports = router;