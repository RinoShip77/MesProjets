require("dotenv").config();

const stripe = require('stripe')(process.env.STRIPE_KEY);

exports.checkout = async function (req, res) {
  const checkoutSession = await stripe.checkout.sessions.create({
    line_items: [
      {
        price_data: {
          unit_amount: (parseFloat(req.body.price) * 100),
          currency: "cad",
          product_data: {
            name: "MyBuilder"
          }
        },
        quantity: 1
      }
    ],
    customer_email: req.body.user,
    payment_method_types: ["card"],
    mode: "payment",
    success_url: `${req.protocol}://${req.get('host')}/orders/checkout/success?id={CHECKOUT_SESSION_ID}`,
    cancel_url: `${req.protocol}://${req.get('host')}/orders/checkout/error`
  });

  res.json(checkoutSession.url)
};

exports.checkoutSuccess = async function (req, res) {
  const checkoutSession = await stripe.checkout.sessions.retrieve(req.query.id);

  res.json(`Thanks ${checkoutSession.customer_details.name} for your order!`);
};

exports.checkoutError = async function (req, res) {
  res.json("Sorry, somethig went wrong with the payement");
};
