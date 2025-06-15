require("dotenv").config();

const stripe = require('stripe')(process.env.STRIPE_KEY);
let statusURL = "";

exports.checkout = async function (req, res) {  
  statusURL = req.body.statusURL;

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
    cancel_url: `${req.protocol}://${req.get('host')}/orders/checkout/cancel`
  };
  
  if(req.body.user.length !== 0)
    checkout.customer_email = req.body.user;
  
  const checkoutSession = await stripe.checkout.sessions.create(checkout);
  
  res.json(checkoutSession.url)
};

exports.checkoutSuccess = async function (req, res) {
  const checkoutSession = await stripe.checkout.sessions.retrieve(req.query.id);
  
  res.redirect(`${statusURL}${req._parsedUrl.pathname.slice(req._parsedUrl.pathname.lastIndexOf("/"))}Checkout.html?name=${checkoutSession.customer_details.name}&total=${checkoutSession.amount_total}`);
  // res.send(`Thanks ${checkoutSession.customer_details.name} for your order!`);
};

exports.checkoutCancel = async function (req, res) {
  res.redirect(`${statusURL}${req._parsedUrl.pathname.slice(req._parsedUrl.pathname.lastIndexOf("/"))}Checkout.html`);
  // res.send("Sorry, somethig went wrong with the payement.");
};
