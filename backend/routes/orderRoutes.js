const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderControllers');
const authMiddleware = require('../middleware/authMiddleware');

router.post('/', authMiddleware.authenticateJWT, orderController.createOrder);
router.get('/', authMiddleware.authenticateJWT, orderController.getAllOrders);
router.get('/:id', authMiddleware.authenticateJWT, orderController.getOrderById);

module.exports = router;
