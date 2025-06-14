require("dotenv").config();

const stripe = require('stripe')(process.env.STRIPE_KEY);

exports.checkout = async function (req, res) {
  let checkout = {
    line_items: [
      {
        price_data: {
          unit_amount: req.body.price,
          currency: "cad",
          product_data: {
            name: "MyBuilder"
          }
        },
        quantity: 1
      }
    ],
    payment_method_types: ["card"],
    mode: "payment",
    success_url: `${req.protocol}://${req.get('host')}/orders/checkout/success?id={CHECKOUT_SESSION_ID}`,
    cancel_url: `${req.protocol}://${req.get('host')}/orders/checkout/error`
  };

  if(req.body.user.length !== 0)
    checkout.customer_email = req.body.user;
  
  const checkoutSession = await stripe.checkout.sessions.create(checkout);

  res.json(checkoutSession.url)
};

exports.checkoutSuccess = async function (req, res) {
  const checkoutSession = await stripe.checkout.sessions.retrieve(req.query.id);

  res.json(`Thanks ${checkoutSession.customer_details.name} for your order!`);
};

exports.checkoutError = async function (req, res) {
  res.json("Sorry, somethig went wrong with the payement");
};
