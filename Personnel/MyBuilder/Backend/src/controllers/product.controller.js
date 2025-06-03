const productFunctions = require("../functions/product.function");
const Case = require("../models/Case");
const Cooler = require("../models/Cooler");
const Motherboard = require("../models/Motherboard");
const PowerSupply = require("../models/PowerSupply");
const Processor = require("../models/Processor");
const RAMBracket = require("../models/RAMBracket");
const StorageDrive = require("../models/StorageDrive");
const VideoCard = require("../models/VideoCard");

exports.getAll = function (req, res) {
  productFunctions.getAll(req.params.table, (err, products) => {
    if (err) throw err;
    
    let elements = [];

    products.forEach(product => {
      elements.push(CreateProduct(product, req.params.table));
    });

    res.json(elements);
  });
};

exports.getOne = function (req, res) {
  productFunctions.getOne(req.params.table, req.params.id, (err, product) => {
    if (err) throw err;
    res.json(CreateProduct(...product, req.params.table));
  });
};

exports.create = function (req, res) {
  const newProduct = CreateProduct(req.body, req.params.table);

  productFunctions.create(req.params.table, newProduct, (err, result) => {
    if (err) throw err;
    res.json({
      message: `The ${req.params.table} was created successfully.`,
    });
  });
};

exports.update = function (req, res) {
  const updatedProduct = CreateProduct(req.body, req.params.table);

  productFunctions.update(req.params.table, req.params.id, updatedProduct, (err, result) => {
    if (err) throw err;
    res.json({
      message: `The ${req.params.table} ${req.params.id} was updated successfully.`,
    });
  });
};

exports.delete = function (req, res) {
  productFunctions.delete(req.params.table, req.params.id, (err, result) => {
    if (err) throw err;
    res.json({
      message: `The ${req.params.table} ${req.params.id} was deleted successfully.`,
    });
  });
};

function CreateProduct(body, table) {
  let product;

  switch (table) {
    case 'cases':
      product = new Case(body.id, body.name, body.imageURL, body.productURL, body.price, body.manufacturer, body.type, body.powerSupply, body.sidePanel, body.frontPanelUSB, body.motherboardFormFactor, body.maximumVideoCardLength, body.dimensions);
      break;

    case 'coolers':
      product = new Cooler(body.id, body.name, body.imageURL, body.productURL, body.price, body.manufacturer, body.fanRPM, body.noiseLvl, body.height, body.waterCooled, body.fanless);
      break;

    case 'motherboards':
      product = new Motherboard(body.id, body.name, body.imageURL, body.productURL, body.price, body.manufacturer, body.socket, body.formFactor, body.chipset, body.memoryMax, body.memoryType, body.memorySlots, body.onboardEthernet, body.wirelessNetworking);
      break;

    case 'power_supplies':
      product = new PowerSupply(body.id, body.name, body.imageURL, body.productURL, body.price, body.manufacturer, body.type, body.rating, body.wattage, body.length);
      break;

    case 'processors':
      product = new Processor(body.id, body.name, body.imageURL, body.productURL, body.price, body.manufacturer, body.series, body.microarchitecture, body.socket, body.coreCount, body.clock, body.integratedGraphics);
      break;

    case 'ram_brackets':
      product = new RAMBracket(body.id, body.name, body.imageURL, body.productURL, body.price, body.manufacturer, body.speed, body.modules, body.voltage);
      break;

    case 'storage_drives':
      product = new StorageDrive(body.id, body.name, body.imageURL, body.productURL, body.price, body.manufacturer, body.capacity, body.type);
      break;

    case 'video_cards':
      product = new VideoCard(body.id, body.name, body.imageURL, body.productURL, body.price, body.manufacturer, body.chipset, body.memory, body.clock, body.frameSync);
      break;
  }

  return product;
}