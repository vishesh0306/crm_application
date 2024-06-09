const Order = require('../models/Order');

exports.createOrder = (req, res) => {
    const newOrder = req.body;

    Order.create(newOrder, (err, result) => {
        if (err) {
            console.error('Error creating order:', err);
            res.status(500).send('Error creating order.');
            return;
        }
        res.status(201).send('Order created successfully');
    });
};

exports.getAllOrders = (req, res) => {
    Order.getAll((err, orders) => {
        if (err) {
            console.error('Error retrieving orders:', err);
            res.status(500).send('Error retrieving orders.');
            return;
        }
        res.status(200).send(orders);
    });
};

exports.getOrderById = (req, res) => {
    const orderId = req.params.id;

    Order.getById(orderId, (err, order) => {
        if (err) {
            console.error('Error retrieving order:', err);
            res.status(500).send('Error retrieving order.');
            return;
        }
        res.status(200).send(order);
    });
};
