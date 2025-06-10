require("dotenv").config();

// TODO: Take the key from .env file
const stripe = require('stripe')(process.env.STRIPE_KEY);

exports.create = async function (req, res) {
  let product = await stripe.products.create({
    name: req.body.name,
    images: [`https:${req.body.imageURL}`],
    default_price_data: {
      currency: "cad",
      unit_amount: (parseFloat(req.body.price.slice(0, -2)) * 100)
    }
  });

  res.json({ priceID: product.default_price });
};

exports.checkout = async function (req, res) {
  let paymentLink = await stripe.paymentLinks.create({
    line_items: req.body.products
  });

  res.json(`${paymentLink.url}?prefilled_email=${req.body.user}`)
};
