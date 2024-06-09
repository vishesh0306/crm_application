const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
require('dotenv').config();

exports.register = (req, res) => {
    const { name, email, password } = req.body;
    const hashedPassword = bcrypt.hashSync(password, 8);

    const newUser = {
        name,
        email,
        password: hashedPassword
    };

    User.create(newUser, (err, result) => {
        if (err) {
            console.error('Error registering user:', err);
            res.status(500).send('Error registering user.');
            return;
        }

        const token = jwt.sign({ id: result.insertId }, process.env.JWT_SECRET, {
            expiresIn: 86400 // 24 hours
        });

        res.status(201).send({ auth: true, token });
    });
};

exports.login = (req, res) => {
    const { email, password } = req.body;

    User.findByEmail(email, (err, users) => {
        if (err || users.length === 0) {
            return res.status(404).send('User not found.');
        }

        const user = users[0];
        const passwordIsValid = bcrypt.compareSync(password, user.password);

        if (!passwordIsValid) {
            return res.status(401).send('Invalid password.');
        }

        const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, {
            expiresIn: 86400 // 24 hours
        });

        res.status(200).send({ auth: true, token });
    });
};

exports.getAllUsers = (req, res) => {
    User.getAll((err, users) => {
        if (err) {
            console.error('Error retrieving users:', err);
            res.status(500).send('Error retrieving users.');
            return;
        }
        res.status(200).send(users);
    });
};
