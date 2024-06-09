const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.json());

const dataRoutes = require('./routes/dataRoutes');
const authRoutes = require('./routes/authRoutes');
const protectedRoutes = require('./routes/protectedRoutes');
const userRoutes = require('./routes/userRoutes');
const orderRoutes = require('./routes/orderRoutes');
const communicationsLogRoutes = require('./routes/communicationsLogRoutes');
const campaignRoutes = require('./routes/campaignRoutes');
const campaignAudienceRoutes = require('./routes/campaignAudienceRoutes');

app.use('/api', dataRoutes);
app.use('/auth', authRoutes);
app.use('/protected', protectedRoutes);
app.use('/users', userRoutes);
app.use('/orders', orderRoutes);
app.use('/logs', communicationsLogRoutes);
app.use('/campaigns', campaignRoutes);
app.use('/audiences', campaignAudienceRoutes);

app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});