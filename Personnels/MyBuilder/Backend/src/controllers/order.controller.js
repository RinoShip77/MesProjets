require("dotenv").config();

const stripe = require('stripe')(process.env.STRIPE_KEY);
let statusURL = "";

exports.getAll = async function (req, res) {
  const orders = await stripe.checkout.sessions.list({
    limit: 100,
  });


  res.json(orders.data);
};

exports.getOne = async function (req, res) {
  const order = await stripe.checkout.sessions.retrieve(req.params.id);

  res.json(order);
};

exports.checkout = async function (req, res) {
  statusURL = req.body.statusURL;

  let data = {
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
  };

  if (req.body.user.length !== 0)
    data.customer_email = req.body.user;

  const checkout = await stripe.checkout.sessions.create(data);

  res.json(checkout.url)
};

exports.checkoutSuccess = async function (req, res) {
  const checkout = await stripe.checkout.sessions.retrieve(req.query.id);

  res.redirect(`${statusURL}${req._parsedUrl.pathname.slice(req._parsedUrl.pathname.lastIndexOf("/"))}Checkout.html?name=${checkout.customer_details.name}&order=${checkout.id}&total=${checkout.amount_total}&date=${checkout.created}`);
};
