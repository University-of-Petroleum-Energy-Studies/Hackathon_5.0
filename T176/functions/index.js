const functions = require('firebase-functions')
const express = require('express');
const cors = require('cors');
const stripe = require('stripe')('sk_test_51HlsqsEJTBWipWhAVUiUirnSL62OcCqK9eQDdBoa9buXlSaM5lYNmGdMlnXsY5eSuX1tc1GLNLkHuJO9d6Ty08kz00O00xRgTM');

// App config
const app = express();

// Middlewares
app.use(cors({ origin: true }));

app.use(express.json());

// API Routes
app.get('/', (req, res) => res.status(200).send("Hello"));

app.post('/payments/create', async (req, res) => {
    const total = req.query.total;

    const paymentIntent = await stripe.paymentIntents.create({
        amount: total, //subunits
        currency: "INR"
    });

    res.status(201).send({
        clientSecret: paymentIntent.client_secret
    })
})
// Listen
// app.listen(5001)
exports.api = functions.https.onRequest(app);
// exports.api = app;



// http://localhost:5001/agrivend/us-central1/api