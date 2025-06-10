-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 08 juin 2025 à 14:14
-- Version du serveur : 9.1.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `my_builder`
--

-- --------------------------------------------------------

--
-- Structure de la table `cases`
--

DROP TABLE IF EXISTS `cases`;
CREATE TABLE IF NOT EXISTS `cases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(147) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `imageURL` varchar(99) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `productURL` varchar(221) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `manufacturer` varchar(19) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantityInStock` int DEFAULT '0',
  `rating` float DEFAULT NULL,
  `type` varchar(19) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `powerSupply` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `sidePanel` varchar(21) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `frontPanelUSB` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `motherboardFormFactor` varchar(59) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `maximumVideoCardLength` varchar(73) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `dimensions` varchar(62) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COMMENT='productsTable';

--
-- Déchargement des données de la table `cases`
--

INSERT INTO `cases` (`id`, `name`, `imageURL`, `productURL`, `price`, `manufacturer`, `quantityInStock`, `rating`, `type`, `powerSupply`, `sidePanel`, `frontPanelUSB`, `motherboardFormFactor`, `maximumVideoCardLength`, `dimensions`) VALUES
(1, 'Corsair 4000D Airflow', '//cdna.pcpartpicker.com/static/forever/images/product/bc6e987da3fe22c616898d1d7fa3d227.256p.jpg', 'https://pcpartpicker.com/product/bCYQzy/corsair-4000d-airflow-atx-mid-tower-case-cc-9011200-ww', '$104.99 ', 'Corsair', 1, 3.6, 'ATX Mid Tower', 'None', 'Tinted Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, EATX, Micro ATX, Mini ITX', '360 mm / 14.173\"', '453 mm x 230 mm x 466 mm, 17.835\" x 9.055\" x 18.346\"'),
(2, 'NZXT H5 Flow', '//cdna.pcpartpicker.com/static/forever/images/product/84cb77175187296029f50f8bf6ca6960.256p.jpg', 'https://pcpartpicker.com/product/RY4Ycf/nzxt-h5-flow-atx-mid-tower-case-cc-h51fb-01', '$94.99 ', 'NZXT', 9, 2.6, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, EATX, Micro ATX, Mini ITX', '365 mm / 14.37\"', '446 mm x 227 mm x 464 mm, 17.559\" x 8.937\" x 18.268\"'),
(3, 'NZXT H9 Flow', '//cdna.pcpartpicker.com/static/forever/images/product/61eb5534e35ce8af07f25ff28197862b.256p.jpg', 'https://pcpartpicker.com/product/7ZBG3C/nzxt-h9-flow-atx-mid-tower-case-cm-h91fw-01', '$159.99 ', 'NZXT', 44, 2.2, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, Micro ATX, Mini ITX', '435 mm / 17.126\"', '466 mm x 290 mm x 495 mm, 18.346\" x 11.417\" x 19.488\"'),
(4, 'NZXT H9 Flow', '//cdna.pcpartpicker.com/static/forever/images/product/15fb785fb4d0995e7cc7e28a6f2271d9.256p.jpg', 'https://pcpartpicker.com/product/VCpzK8/nzxt-h9-flow-atx-mid-tower-case-cm-h91fb-01', '$154.99 ', 'NZXT', 44, 3.4, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, Micro ATX, Mini ITX', '435 mm / 17.126\"', '466 mm x 290 mm x 495 mm, 18.346\" x 11.417\" x 19.488\"'),
(5, 'Montech AIR 903 MAX', 'https://m.media-amazon.com/images/I/519WrOWiOhL.jpg', 'https://pcpartpicker.com/product/2MwmP6/montech-air-903-max-atx-mid-tower-case-air-903-max-b', '$75.00 ', 'Montech', 38, 0.2, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, EATX, Micro ATX, Mini ITX', '400 mm / 15.748\"', '478 mm x 230 mm x 493 mm, 18.819\" x 9.055\" x 19.409\"'),
(6, 'NZXT H6 Flow', '//cdna.pcpartpicker.com/static/forever/images/product/f0363dfe4d946330b9b5f65a3b38722f.256p.jpg', 'https://pcpartpicker.com/product/8QMMnQ/nzxt-h6-flow-atx-mid-tower-case-cc-h61fw-01', '$109.99 ', 'NZXT', 9, 0.7, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, Micro ATX, Mini ITX', '365 mm / 14.37\"', '415 mm x 287 mm x 435 mm, 16.339\" x 11.299\" x 17.126\"'),
(7, 'Cooler Master MasterBox Q300L', '//cdna.pcpartpicker.com/static/forever/images/product/ec48e16ee4d6629045cfc4d71c649746.256p.jpg', 'https://pcpartpicker.com/product/rnGxFT/cooler-master-masterbox-q300l-microatx-mini-tower-case-mcb-q300l-kann-s00', '$46.98 ', 'Cooler Master', 32, 3, 'MicroATX Mini Tower', 'None', 'Acrylic', 'USB 3.2 Gen 1 Type-A', 'Micro ATX, Mini ITX', '360 mm / 14.173\"', '387 mm x 230 mm x 378 mm, 15.236\" x 9.055\" x 14.882\"'),
(8, 'NZXT H6 Flow', '//cdna.pcpartpicker.com/static/forever/images/product/0ff9e0317d9c4b1e99938a2f02ccb165.256p.jpg', 'https://pcpartpicker.com/product/xgKscf/nzxt-h6-flow-atx-mid-tower-case-cc-h61fb-01', '$101.29 ', 'NZXT', 31, 2.8, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, Micro ATX, Mini ITX', '365 mm / 14.37\"', '415 mm x 287 mm x 435 mm, 16.339\" x 11.299\" x 17.126\"'),
(9, 'Montech X3 Mesh', '//cdna.pcpartpicker.com/static/forever/images/product/9e7790ee9397346b4c023cc04296fb5e.256p.jpg', 'https://pcpartpicker.com/product/HRH7YJ/montech-x3-mesh-atx-mid-tower-case-x3-mesh-black', '$64.98 ', 'Montech', 10, 0.3, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 1 Type-A, USB 2.0 Type-A', 'ATX, Micro ATX, Mini ITX', '305 mm / 12.008\"', ''),
(10, 'Montech AIR 100 ARGB', '//cdna.pcpartpicker.com/static/forever/images/product/24adca630b5c708e106099fc958825a1.256p.jpg', 'https://pcpartpicker.com/product/M7Z9TW/montech-air-100-argb-microatx-mid-tower-case-air-100-argb-black', '', 'Montech', 10, 2.9, 'MicroATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 1 Type-A, USB 2.0 Type-A', 'Micro ATX, Mini ITX', '330 mm / 12.992\"', '405 mm x 210 mm x 425 mm, 15.945\" x 8.268\" x 16.732\"'),
(11, 'Fractal Design North', '//cdna.pcpartpicker.com/static/forever/images/product/1977a3a3f6f1238d12ea2a555be4d7ce.256p.jpg', 'https://pcpartpicker.com/product/ybNxFT/fractal-design-north-atx-mid-tower-case-fd-c-nor1c-02', '$139.99 ', 'Fractal Design', 17, 3.6, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, Micro ATX, Mini ITX', '300 mm / 11.811\" With Drive Cages, 355 mm / 13.976\" Without Drive Cages', '447 mm x 215 mm x 469 mm, 17.598\" x 8.465\" x 18.465\"'),
(12, 'NZXT H6 Flow RGB', '//cdna.pcpartpicker.com/static/forever/images/product/21f390a2caf255ac942d9f4d4899adee.256p.jpg', 'https://pcpartpicker.com/product/kfRwrH/nzxt-h6-flow-rgb-atx-mid-tower-case-cc-h61fw-r1', '$132.99 ', 'NZXT', 8, 4.4, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, Micro ATX, Mini ITX', '365 mm / 14.37\"', '415 mm x 287 mm x 435 mm, 16.339\" x 11.299\" x 17.126\"'),
(13, 'Phanteks XT PRO', '//cdna.pcpartpicker.com/static/forever/images/product/4beb27272519c97f098ceab48df1e12c.256p.jpg', 'https://pcpartpicker.com/product/zJWJ7P/phanteks-xt-pro-atx-mid-tower-case-ph-xt523p1-bk01', '$49.99 ', 'Phanteks', 38, 1, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 1 Type-A', 'ATX, EATX, Micro ATX, Mini ITX', '415 mm / 16.339\"', '450 mm x 230 mm x 500 mm, 17.717\" x 9.055\" x 19.685\"'),
(14, 'Lian Li O11 Dynamic EVO', '//cdna.pcpartpicker.com/static/forever/images/product/ea0dee3c3376cc6326ca2f4a73a054ac.256p.jpg', 'https://pcpartpicker.com/product/4cPQzy/lian-li-o11-dynamic-evo-atx-mid-tower-case-pc-o11dew', '$234.15 ', 'Lian Li', 15, 2, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, EATX, Micro ATX, Mini ITX', '422 mm / 16.614\"', '465 mm x 285 mm x 459 mm, 18.307\" x 11.22\" x 18.071\"'),
(15, 'Phanteks XT PRO ULTRA', '//cdna.pcpartpicker.com/static/forever/images/product/b799e3113602fc415370943709415190.256p.jpg', 'https://pcpartpicker.com/product/BXtLrH/phanteks-xt-pro-ultra-atx-mid-tower-case-ph-xt523p1-dbk01', '$69.99 ', 'Phanteks', 15, 2, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, EATX, Micro ATX, Mini ITX', '415 mm / 16.339\"', '450 mm x 230 mm x 500 mm, 17.717\" x 9.055\" x 19.685\"'),
(16, 'Lian Li LANCOOL 216', '//cdna.pcpartpicker.com/static/forever/images/product/372a584cebeca5f57266bf0f07e6831c.256p.jpg', 'https://pcpartpicker.com/product/KKytt6/lian-li-lancool-216-atx-mid-tower-case-lancool-216rx', '$99.99 ', 'Lian Li', 28, 3.7, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, EATX, Micro ATX, Mini ITX', '392 mm / 15.433\"', '480.9 mm x 235 mm x 491.7 mm, 18.933\" x 9.252\" x 19.358\"'),
(17, 'Deepcool CH370', '//cdna.pcpartpicker.com/static/forever/images/product/2fad46b6561866155338a1cd7afa4712.256p.jpg', 'https://pcpartpicker.com/product/mhC48d/deepcool-ch370-microatx-mid-tower-case-r-ch370-bknam1-g-1', '$59.41 ', 'Deepcool', 44, 2.9, 'MicroATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 1 Type-A', 'Micro ATX, Mini ITX', '320 mm / 12.598\"', '413 mm x 215 mm x 431 mm, 16.26\" x 8.465\" x 16.969\"'),
(18, 'Silverstone ALTA F2', '//cdna.pcpartpicker.com/static/forever/images/product/4ff42fa090d41392739d099e28baf56f.256p.jpg', 'https://pcpartpicker.com/product/wsvD4D/silverstone-alta-f2-atx-full-tower-case-sst-alf2b-g', '$999.99 ', 'Silverstone', 40, 3.1, 'ATX Full Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, EATX, Micro ATX, Mini ITX, SSI CEB, SSI EEB, XL ATX', '604 mm / 23.78\"', '658 mm x 261 mm x 576 mm, 25.906\" x 10.276\" x 22.677\"'),
(19, 'Deepcool CC560 V2', '//cdna.pcpartpicker.com/static/forever/images/product/b4eee8314bb582edeb59eef06376bf4c.256p.jpg', 'https://pcpartpicker.com/product/tHLdnQ/deepcool-cc560-v2-atx-mid-tower-case-r-cc560-bkgaa4-g-2', '$59.99 ', 'Deepcool', 16, 2.1, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 1 Type-A, USB 2.0 Type-A', 'ATX, Micro ATX, Mini ITX', '370 mm / 14.567\"', '432 mm x 215 mm x 483 mm, 17.008\" x 8.465\" x 19.016\"'),
(20, 'Deepcool MATREXX 40', '//cdna.pcpartpicker.com/static/forever/images/product/b32fb28bca9fb6780a07e11767da9f38.256p.jpg', 'https://pcpartpicker.com/product/LqPQzy/deepcool-matrexx-40-microatx-mini-tower-case-dp-matx-matrexx40', '$54.99 ', 'Deepcool', 12, 0.9, 'MicroATX Mini Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 1 Type-A, USB 2.0 Type-A', 'Micro ATX, Mini ITX', '320 mm / 12.598\"', ''),
(21, 'NZXT H5 Flow', '//cdna.pcpartpicker.com/static/forever/images/product/6c58fbf47cba2aca9c9a56ff028fe5d9.256p.jpg', 'https://pcpartpicker.com/product/92pzK8/nzxt-h5-flow-atx-mid-tower-case-cc-h51fw-01', '$92.99 ', 'NZXT', 12, 3.5, 'ATX Mid Tower', 'None', 'Tempered Glass', 'USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A', 'ATX, EATX, Micro ATX, Mini ITX', '365 mm / 14.37\"', '446 mm x 227 mm x 464 mm, 17.559\" x 8.937\" x 18.268\"');

-- --------------------------------------------------------

--
-- Structure de la table `coolers`
--

DROP TABLE IF EXISTS `coolers`;
CREATE TABLE IF NOT EXISTS `coolers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(62) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `imageURL` varchar(99) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `productURL` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `manufacturer` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantityInStock` int DEFAULT '0',
  `rating` float DEFAULT NULL,
  `fanRPM` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `noiseLvl` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `height` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `waterCooled` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `fanless` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COMMENT='productsTable';

--
-- Déchargement des données de la table `coolers`
--

INSERT INTO `coolers` (`id`, `name`, `imageURL`, `productURL`, `price`, `manufacturer`, `quantityInStock`, `rating`, `fanRPM`, `noiseLvl`, `height`, `waterCooled`, `fanless`) VALUES
(1, 'Thermalright Peerless Assassin 120 SE', 'https://m.media-amazon.com/images/I/41hFTmi5aUL.jpg', 'https://pcpartpicker.com/product/hYxRsY/thermalright-peerless-assassin-120-se-6617-cfm-cpu-cooler-pa120-se-d3', '$33.90 ', 'Thermalright', 5, 5, '1550 RPM', '25.6 dB', '155 mm', 'No', 'No'),
(2, 'NZXT Kraken Elite 360 RGB', '//cdna.pcpartpicker.com/static/forever/images/product/49ed312d967c71e5bf866285deee9f9c.256p.jpg', 'https://pcpartpicker.com/product/pbKscf/nzxt-kraken-elite-360-rgb-7802-cfm-liquid-cpu-cooler-rl-kr36e-w1', '$271.99 ', 'NZXT', 26, 2.4, '500 - 1800 RPM', '17.9 - 30.6 dB', '60 mm', 'Yes - 360 mm', 'No'),
(3, 'Cooler Master MASTERLIQUID ML240L RGB V2', '//cdna.pcpartpicker.com/static/forever/images/product/5b6a5e7f4cf456ccf6415235cf7adc99.256p.jpg', 'https://pcpartpicker.com/product/fLFKHx/cooler-master-masterliquid-ml240l-rgb-v2-6559-cfm-liquid-cpu-cooler-mlw-d24m-a18pc-r2', '$104.99 ', 'Cooler Master', 17, 2.2, '650 - 1800 RPM', '6 - 27 dB', 'N/A', 'Yes - 240 mm', 'No'),
(4, 'Deepcool GAMMAXX AG400 ARGB', '//cdna.pcpartpicker.com/static/forever/images/product/9464a59a8e91c8203397a01ab96d0ec7.256p.jpg', 'https://pcpartpicker.com/product/WKWzK8/deepcool-gammaxx-ag400-argb-7589-cfm-cpu-cooler-r-ag400-bkanmc-g-2', '$28.98 ', 'Deepcool', 5, 3.9, '500 - 2000 RPM', '31.6 dB', '150 mm', 'No', 'No'),
(5, 'Corsair iCUE H150i ELITE CAPELLIX XT', '//cdna.pcpartpicker.com/static/forever/images/product/12bfecb3325a384ef35e38ada6b8bca3.256p.jpg', 'https://pcpartpicker.com/product/hxrqqs/corsair-icue-h150i-elite-capellix-xt-6557-cfm-liquid-cpu-cooler-cw-9060070-ww', '$189.99 ', 'Corsair', 26, 2.9, '550 - 2100 RPM', '5 - 34.1 dB', 'N/A', 'Yes - 360 mm', 'No'),
(6, 'Noctua NH-D15 chromax.black', 'https://m.media-amazon.com/images/I/51kgqhkUNuL.jpg', 'https://pcpartpicker.com/product/84MTwP/noctua-nh-d15-chromaxblack-8252-cfm-cpu-cooler-nh-d15-chromaxblack', '$119.95 ', 'Noctua', 15, 2.8, '300 - 1500 RPM', '19.2 - 24.6 dB', '165 mm', 'No', 'No'),
(7, 'NZXT Kraken 240', '//cdna.pcpartpicker.com/static/forever/images/product/157afeba59d05304fe181106745e6177.256p.jpg', 'https://pcpartpicker.com/product/LDqrxr/nzxt-kraken-240-7802-cfm-liquid-cpu-cooler-rl-kn240-b1', '$120.99 ', 'NZXT', 47, 0.2, '500 - 1800 RPM', '17.9 - 30.6 dB', '56 mm', 'Yes - 240 mm', 'No'),
(8, 'Thermalright Phantom Spirit 120 SE', 'https://m.media-amazon.com/images/I/51kJe8EOqjL.jpg', 'https://pcpartpicker.com/product/GpbRsY/thermalright-phantom-spirit-120-se-6617-cfm-cpu-cooler-ps120se', '$35.90 ', 'Thermalright', 42, 2.6, '1500 RPM', '25.6 dB', '154 mm', 'No', 'No'),
(9, 'Deepcool AK620 ZERO DARK', '//cdna.pcpartpicker.com/static/forever/images/product/048ee8d7e1ab67674cc0aac0e4e0e281.256p.jpg', 'https://pcpartpicker.com/product/7J6p99/deepcool-ak620-zero-dark-6899-cfm-cpu-cooler-r-ak620-bknnmt-g-1', '$61.98 ', 'Deepcool', 18, 2.4, '500 - 1850 RPM', '28 dB', '160 mm', 'No', 'No'),
(10, 'Deepcool LS720 SE WH', 'https://m.media-amazon.com/images/I/31cc4omxokL.jpg', 'https://pcpartpicker.com/product/dWGhP6/deepcool-ls720-se-wh-8585-cfm-liquid-cpu-cooler-ls720-se-wh', '$99.99 ', 'Deepcool', 15, 4.4, '500 - 2250 RPM', '28.2 - 32.9 dB', 'N/A', 'Yes - 360 mm', 'No'),
(11, 'ARCTIC Liquid Freezer III', 'https://m.media-amazon.com/images/I/31C4DlmScnL.jpg', 'https://pcpartpicker.com/product/XgyH99/arctic-liquid-freezer-iii-563-cfm-liquid-cpu-cooler-acfre00136a', '$116.99 ', 'ARCTIC', 22, 4.5, '200 - 1800 RPM', 'N/A', 'N/A', 'Yes - 360 mm', 'No'),
(12, 'NZXT Kraken Elite 360 RGB', '//cdna.pcpartpicker.com/static/forever/images/product/00f3005287758516d8b319cefd625a13.256p.jpg', 'https://pcpartpicker.com/product/3bKscf/nzxt-kraken-elite-360-rgb-7802-cfm-liquid-cpu-cooler-rl-kr36e-b1', '$276.37 ', 'NZXT', 15, 4.5, '500 - 1800 RPM', '17.9 - 30.6 dB', '60 mm', 'Yes - 360 mm', 'No'),
(13, 'Cooler Master Hyper 212 Black Edition', '//cdna.pcpartpicker.com/static/forever/images/product/716d4c601ae190184020710e098e7b36.256p.jpg', 'https://pcpartpicker.com/product/HyTPxr/cooler-master-hyper-212-black-edition-42-cfm-cpu-cooler-rr-212s-20pk-r1', '$29.99 ', 'Cooler Master', 11, 3.9, '650 - 2000 RPM', '6.5 - 26 dB', '159 mm', 'No', 'No'),
(14, 'Thermalright Assassin X 120 Refined SE', 'https://m.media-amazon.com/images/I/41aJwdGRuAL.jpg', 'https://pcpartpicker.com/product/q6H7YJ/thermalright-assassin-x-120-refined-se-6617-cfm-cpu-cooler-ax120-se-d3', '$17.89 ', 'Thermalright', 9, 1.1, '1550 RPM', '25.6 dB', '148 mm', 'No', 'No'),
(15, 'Deepcool LS720 SE', 'https://m.media-amazon.com/images/I/41lhOsw+ACL.jpg', 'https://pcpartpicker.com/product/yBDQzy/deepcool-ls720-se-8585-cfm-liquid-cpu-cooler-ls720-se', '$89.99 ', 'Deepcool', 13, 3.8, '500 - 2250 RPM', '28.2 - 32.9 dB', 'N/A', 'Yes - 360 mm', 'No'),
(16, 'Thermalright Peerless Assassin 120 SE WHITE ARGB', '//cdna.pcpartpicker.com/static/forever/images/product/c09b33bf4c2452bbc71fac7691860f4a.256p.jpg', 'https://pcpartpicker.com/product/xMLFf7/thermalright-peerless-assassin-120-se-white-argb-6617-cfm-cpu-cooler-pa120-se-white-argb', '$36.99 ', 'Thermalright', 39, 0.8, '1550 RPM', '25.6 dB', '155 mm', 'No', 'No'),
(17, 'NZXT Kraken 360', '//cdna.pcpartpicker.com/static/forever/images/product/e71bea262e634ec0decd5847c6e4d0a1.256p.jpg', 'https://pcpartpicker.com/product/D8rqqs/nzxt-kraken-360-7802-cfm-liquid-cpu-cooler-rl-kn360-b1', '', 'NZXT', 6, 2.4, '500 - 1800 RPM', '17.9 - 30.6 dB', '56 mm', 'Yes - 360 mm', 'No'),
(18, 'Noctua NH-D15', '//cdna.pcpartpicker.com/static/forever/images/product/ca16d42d3e187f96c728c09183df14a7.med.256p.jpg', 'https://pcpartpicker.com/product/4vzv6h/noctua-nh-d15-825-cfm-cpu-cooler-nh-d15', '$109.95 ', 'Noctua', 13, 4.9, '300 - 1500 RPM', '19.2 - 24.6 dB', '165 mm', 'No', 'No'),
(19, 'Thermalright Phantom Spirit 120 SE ARGB', 'https://m.media-amazon.com/images/I/51KizlEeQZL.jpg', 'https://pcpartpicker.com/product/MzMMnQ/thermalright-phantom-spirit-120-se-argb-6617-cfm-cpu-cooler-ps120se-argb', '$35.90 ', 'Thermalright', 47, 2, '1500 RPM', '25.6 dB', '154 mm', 'No', 'No'),
(20, 'Corsair iCUE H100i RGB ELITE', '//cdna.pcpartpicker.com/static/forever/images/product/076dcbc1ba5e06eafb25c91e17dbef75.256p.jpg', 'https://pcpartpicker.com/product/scstt6/corsair-icue-h100i-rgb-elite-591-cfm-liquid-cpu-cooler-cw-9060058-ww', '$119.99 ', 'Corsair', 48, 0.3, '400 - 1850 RPM', '5 - 28.9 dB', 'N/A', 'Yes - 240 mm', 'No'),
(21, 'Corsair iCUE H100x RGB ELITE', '//cdna.pcpartpicker.com/static/forever/images/product/910431067172593d99eb5c6c6f6ca70e.256p.jpg', 'https://pcpartpicker.com/product/2RBzK8/corsair-icue-h100x-rgb-elite-4773-cfm-liquid-cpu-cooler-cw-9060065-ww', '$99.99 ', 'Corsair', 0, 0.7, '1500 RPM', '7 - 28 dB', 'N/A', 'Yes - 240 mm', 'No'),
(22, 'Deepcool AK400', '//cdna.pcpartpicker.com/static/forever/images/product/f11e54d5a812379d28e34bc51143332b.256p.jpg', 'https://pcpartpicker.com/product/QPkWGX/deepcool-ak400-6647-cfm-cpu-cooler-r-ak400-bknnmn-g-1', '$33.98 ', 'Deepcool', 4, 2.3, '500 - 1850 RPM', '29 dB', '155 mm', 'No', 'No'),
(23, 'NZXT Kraken 240 RGB', '//cdna.pcpartpicker.com/static/forever/images/product/ebd0dcafaf707dc2d772c44585ea8e10.256p.jpg', 'https://pcpartpicker.com/product/sJMMnQ/nzxt-kraken-240-rgb-7802-cfm-liquid-cpu-cooler-rl-kr240-w1', '$172.99 ', 'NZXT', 23, 4.7, '500 - 1800 RPM', '17.9 - 30.6 dB', '56 mm', 'Yes - 240 mm', 'No');

-- --------------------------------------------------------

--
-- Structure de la table `motherboards`
--

DROP TABLE IF EXISTS `motherboards`;
CREATE TABLE IF NOT EXISTS `motherboards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `imageURL` varchar(95) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `productURL` varchar(132) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `manufacturer` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantityInStock` int DEFAULT '0',
  `rating` float DEFAULT NULL,
  `socket` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `formFactor` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `chipset` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `memoryMax` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `memoryType` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `memorySlots` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `onboardEthernet` varchar(66) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `wirelessNetworking` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COMMENT='productsTable';

--
-- Déchargement des données de la table `motherboards`
--

INSERT INTO `motherboards` (`id`, `name`, `imageURL`, `productURL`, `price`, `manufacturer`, `quantityInStock`, `rating`, `socket`, `formFactor`, `chipset`, `memoryMax`, `memoryType`, `memorySlots`, `onboardEthernet`, `wirelessNetworking`) VALUES
(1, 'MSI B650 GAMING PLUS WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/ca980d24c4cc99996e802092f9590bcf.256p.jpg', 'https://pcpartpicker.com/product/szfxFT/msi-b650-gaming-plus-wifi-atx-am5-motherboard-b650-gaming-plus-wifi', '$169.99 ', '\nMSI\n', 49, 0, '\nAM5\n', '\nATX\n', '\nAMD B650\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Realtek 8125BG)', 'Wi-Fi 6E'),
(2, 'Asus ROG STRIX B650-A GAMING WIFI', 'https://m.media-amazon.com/images/I/51W9XJLDRlL.jpg', 'https://pcpartpicker.com/product/Gjt9TW/asus-rog-strix-b650-a-gaming-wifi-atx-am5-motherboard-rog-strix-b650-a-gaming-wifi', '$229.99 ', '\nAsus\n', 23, 3.9, '\nAM5\n', '\nATX\n', '\nAMD B650\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Intel)', 'Wi-Fi 6E'),
(3, 'MSI B760 GAMING PLUS WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/f22d681ccfd01238e756443a474f400b.256p.jpg', 'https://pcpartpicker.com/product/TxcgXL/msi-b760-gaming-plus-wifi-atx-lga1700-motherboard-b760-gaming-plus-wifi', '$159.99 ', '\nMSI\n', 22, 4.3, '\nLGA1700\n', '\nATX\n', '\nIntel B760\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Realtek RTL8125BG)', 'Wi-Fi 6E'),
(4, 'MSI B550 GAMING GEN3', '//cdna.pcpartpicker.com/static/forever/images/product/cbc52effd345bd5e9d66b5f7d198f8b4.256p.jpg', 'https://pcpartpicker.com/product/JVJgXL/msi-b550-gaming-gen3-atx-am4-motherboard-b550-gaming-gen3', '$99.99 ', '\nMSI\n', 40, 4.7, '\nAM4\n', '\nATX\n', '\nAMD B550\n', '\n128 GB\n', '\nDDR4\n', '\n4\n', '1 x 1 Gb/s (Realtek RTL8111H)', 'None'),
(5, 'MSI PRO Z790-A MAX WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/55e781311c4d62e83df9ac297a64c01a.256p.jpg', 'https://pcpartpicker.com/product/CsvD4D/msi-pro-z790-a-max-wifi-atx-lga1700-motherboard-pro-z790-a-max-wifi', '$239.99 ', '\nMSI\n', 35, 0.6, '\nLGA1700\n', '\nATX\n', '\nIntel Z790\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Intel)', 'Wi-Fi 7'),
(6, 'Gigabyte B650 GAMING X AX', '//cdna.pcpartpicker.com/static/forever/images/product/40037fa5f1c2c2b92273f1a5547ed181.256p.jpg', 'https://pcpartpicker.com/product/YZgFf7/gigabyte-b650-gaming-x-ax-atx-am5-motherboard-b650-gaming-x-ax', '$189.15 ', '\nGigabyte\n', 5, 3.9, '\nAM5\n', '\nATX\n', '\nAMD B650\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Realtek)', 'Wi-Fi 6E'),
(7, 'MSI MAG B650 TOMAHAWK WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/dc9235e0d8052745493eb900bb9df6f6.256p.jpg', 'https://pcpartpicker.com/product/LwNxFT/msi-mag-b650-tomahawk-wifi-atx-am5-motherboard-mag-b650-tomahawk-wifi', '$199.99 ', '\nMSI\n', 19, 2.6, '\nAM5\n', '\nATX\n', '\nAMD B650\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Realtek RTL8125B)', 'Wi-Fi 6E'),
(8, 'MSI B450M-A PRO MAX II', '//cdna.pcpartpicker.com/static/forever/images/product/a1a4552c218bc30c1738a3642c5691dd.256p.jpg', 'https://pcpartpicker.com/product/w4BzK8/msi-b450m-a-pro-max-ii-micro-atx-am4-motherboard-b450m-a-pro-max-ii', '$69.98 ', '\nMSI\n', 31, 1.4, '\nAM4\n', '\nMicro ATX\n', '\nAMD B450\n', '\n64 GB\n', '\nDDR4\n', '\n2\n', '1 x 2.5 Gb/s (Realtek 8125)', 'None'),
(9, 'ASRock B650M Pro RS WiFi', '//cdna.pcpartpicker.com/static/forever/images/product/d7893755609db1feb833c99ad9d243bf.256p.jpg', 'https://pcpartpicker.com/product/qcbRsY/asrock-b650m-pro-rs-wifi-micro-atx-am5-motherboard-b650m-pro-rs-wifi', '$206.70 ', '\nASRock\n', 49, 4.2, '\nAM5\n', '\nMicro ATX\n', '\nAMD B650\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Realtek Dragon RTL8125BG)', 'Wi-Fi 6E'),
(10, 'Asus PRIME B550M-A WIFI II', '//cdna.pcpartpicker.com/static/forever/images/product/ff4b4e2c7f72b014f39f1864b19e7250.256p.jpg', 'https://pcpartpicker.com/product/jQrRsY/asus-prime-b550m-a-wifi-ii-micro-atx-am4-motherboard-prime-b550m-a-wifi-ii', '$104.99 ', '\nAsus\n', 3, 1.9, '\nAM4\n', '\nMicro ATX\n', '\nAMD B550\n', '\n128 GB\n', '\nDDR4\n', '\n4\n', '1 x 1 Gb/s (Realtek)', 'Wi-Fi 6'),
(11, 'ASRock B660M Pro RS', '//cdna.pcpartpicker.com/static/forever/images/product/5602839ae99179798119982f3d94a277.256p.jpg', 'https://pcpartpicker.com/product/TZPQzy/asrock-b660m-pro-rs-micro-atx-lga1700-motherboard-b660m-pro-rs', '$94.99 ', '\nASRock\n', 17, 1.8, '\nLGA1700\n', '\nMicro ATX\n', '\nIntel B660\n', '\n128 GB\n', '\nDDR4\n', '\n4\n', '1 x 1 Gb/s (Intel I219-V)', 'None'),
(12, 'MSI PRO B650M-P', '//cdna.pcpartpicker.com/static/forever/images/product/f03f1d667284f39b3eaf208a50cdbb68.256p.jpg', 'https://pcpartpicker.com/product/LdHqqs/msi-pro-b650m-p-micro-atx-am5-motherboard-pro-b650m-p', '$119.99 ', '\nMSI\n', 28, 3.3, '\nAM5\n', '\nMicro ATX\n', '\nAMD B650\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Realtek RTL8125BG)', 'None'),
(13, 'MSI PRO Z790-P WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/70392ffdd327f8c69ec493d66a257742.256p.jpg', 'https://pcpartpicker.com/product/k7mmP6/msi-pro-z790-p-wifi-atx-lga1700-motherboard-pro-z790-p-wifi', '$193.65 ', '\nMSI\n', 37, 1, '\nLGA1700\n', '\nATX\n', '\nIntel Z790\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Intel)', 'Wi-Fi 6E'),
(14, 'MSI PRO B650M-A WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/a7ffc5ab34c099836bb0ff9f9dfcab6d.256p.jpg', 'https://pcpartpicker.com/product/cRQcCJ/msi-pro-b650m-a-wifi-micro-atx-am5-motherboard-pro-b650m-a-wifi', '$144.99 ', '\nMSI\n', 3, 0.2, '\nAM5\n', '\nMicro ATX\n', '\nAMD B650\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Realtek 8125BG)', 'Wi-Fi 6E'),
(15, 'MSI MAG X670E TOMAHAWK WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/c4516e2f81a19d4c9045028a3bae013b.256p.jpg', 'https://pcpartpicker.com/product/bGfxFT/msi-mag-x670e-tomahawk-wifi-atx-am5-motherboard-mag-x670e-tomahawk-wifi', '$259.99 ', '\nMSI\n', 6, 3, '\nAM5\n', '\nATX\n', '\nAMD X670E\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Realtek RTL8125BG)', 'Wi-Fi 6E'),
(16, 'Asus TUF GAMING Z790-PRO WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/d31f8288903c781a94e963b0a3eeb4b4.256p.jpg', 'https://pcpartpicker.com/product/skqrxr/asus-tuf-gaming-z790-pro-wifi-atx-lga1700-motherboard-tuf-gaming-z790-pro-wifi', '$244.99 ', '\nAsus\n', 21, 4.2, '\nLGA1700\n', '\nATX\n', '\nIntel Z790\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Intel)', 'Wi-Fi 6E'),
(17, 'Asus ROG STRIX B550-F GAMING WIFI II', '//cdna.pcpartpicker.com/static/forever/images/product/923cae0c8159c98aaf91541a20f95dc9.256p.jpg', 'https://pcpartpicker.com/product/K4LFf7/asus-rog-strix-b550-f-gaming-wifi-ii-atx-am4-motherboard-strix-b550-f-gaming-wifi-ii', '$159.99 ', '\nAsus\n', 38, 2.1, '\nAM4\n', '\nATX\n', '\nAMD B550\n', '\n128 GB\n', '\nDDR4\n', '\n4\n', '1 x 2.5 Gb/s (Intel I225-V)', 'Wi-Fi 6'),
(18, 'MSI MAG B550 TOMAHAWK MAX WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/cf20560e7e4a9e474fcb4c88238e4ffd.256p.jpg', 'https://pcpartpicker.com/product/MfZ9TW/msi-mag-b550-tomahawk-max-wifi-atx-am4-motherboard-mag-b550-tomahawk-max-wifi', '$169.99 ', '\nMSI\n', 26, 2.8, '\nAM4\n', '\nATX\n', '\nAMD B550\n', '\n128 GB\n', '\nDDR4\n', '\n4\n', '1 x 2.5 Gb/s (Realtek RTL8125B)', 'Wi-Fi 6'),
(19, 'Gigabyte B550M K', '//cdna.pcpartpicker.com/static/forever/images/product/f52a9a0b2a28f096b5b1e5bf02707224.256p.jpg', 'https://pcpartpicker.com/product/RH9wrH/gigabyte-b550m-k-micro-atx-am4-motherboard-b550m-k', '$94.99 ', '\nGigabyte\n', 17, 2.7, '\nAM4\n', '\nMicro ATX\n', '\nAMD B550\n', '\n128 GB\n', '\nDDR4\n', '\n4\n', '1 x 1 Gb/s (Realtek)', 'None'),
(20, 'ASRock B650I Lightning Wifi', '//cdna.pcpartpicker.com/static/forever/images/product/40e47e0c22c38ba2269880dd81c305f3.256p.jpg', 'https://pcpartpicker.com/product/rVfxFT/asrock-b650i-lightning-wifi-mini-itx-am5-motherboard-b650i-lightning-wifi', '$199.99 ', '\nASRock\n', 9, 0.1, '\nAM5\n', '\nMini ITX\n', '\nAMD B650\n', '\n96 GB\n', '\nDDR5\n', '\n2\n', '1 x 2.5 Gb/s (Realtek Dragon RTL8125BG)', 'Wi-Fi 6E'),
(21, 'MSI B550M PRO-VDH WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/57b4a5399dc626e9c5786f786aeb94ac.256p.jpg', 'https://pcpartpicker.com/product/PDsnTW/msi-b550m-pro-vdh-wifi-micro-atx-am4-motherboard-b550m-pro-vdh-wifi', '$99.99 ', '\nMSI\n', 45, 2.3, '\nAM4\n', '\nMicro ATX\n', '\nAMD B550\n', '\n128 GB\n', '\nDDR4\n', '\n4\n', '1 x 1 Gb/s (Realtek RTL8111HN)', 'Wi-Fi 5'),
(22, 'Asus ROG STRIX B650E-F GAMING WIFI', '//cdna.pcpartpicker.com/static/forever/images/product/b950287e2f141caa4638fc93dc99a6ba.256p.jpg', 'https://pcpartpicker.com/product/s8nypg/asus-rog-strix-b650e-f-gaming-wifi-atx-am5-motherboard-rog-strix-b650e-f-gaming-wifi', '$256.95 ', '\nAsus\n', 46, 1.4, '\nAM5\n', '\nATX\n', '\nAMD B650E\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Intel I225-V)', 'Wi-Fi 6E'),
(23, 'Gigabyte B650 AORUS ELITE AX ICE', '//cdna.pcpartpicker.com/static/forever/images/product/7352b7865a2e77e70371d5c81a01f5a7.256p.jpg', 'https://pcpartpicker.com/product/CwjRsY/gigabyte-b650-aorus-elite-ax-ice-atx-am5-motherboard-b650-aorus-elite-ax-ice', '$229.99 ', '\nGigabyte\n', 47, 0.1, '\nAM5\n', '\nATX\n', '\nAMD B650\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 2.5 Gb/s (Realtek)', 'Wi-Fi 6E'),
(24, 'Gigabyte B650 EAGLE AX', 'https://m.media-amazon.com/images/I/51BdjazabVL.jpg', 'https://pcpartpicker.com/product/CvcgXL/gigabyte-b650-eagle-ax-atx-am5-motherboard-b650-eagle-ax', '$149.99 ', '\nGigabyte\n', 45, 1.5, '\nAM5\n', '\nATX\n', '\nAMD B650\n', '\n192 GB\n', '\nDDR5\n', '\n4\n', '1 x 1 Gb/s (Realtek)', 'Wi-Fi 6E');

-- --------------------------------------------------------

--
-- Structure de la table `power_supplies`
--

DROP TABLE IF EXISTS `power_supplies`;
CREATE TABLE IF NOT EXISTS `power_supplies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(79) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `imageURL` varchar(99) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `productURL` varchar(171) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `manufacturer` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantityInStock` int DEFAULT '0',
  `rating` float DEFAULT NULL,
  `type` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `wattage` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `length` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COMMENT='productsTable';

--
-- Déchargement des données de la table `power_supplies`
--

INSERT INTO `power_supplies` (`id`, `name`, `imageURL`, `productURL`, `price`, `manufacturer`, `quantityInStock`, `rating`, `type`, `wattage`, `length`) VALUES
(1, 'Corsair RM750e (2023)', '//cdna.pcpartpicker.com/static/forever/images/product/336c7955df0312d04655dd3a13973c95.256p.jpg', 'https://pcpartpicker.com/product/YRJp99/corsair-rm750e-2023-750-w-80-gold-certified-fully-modular-atx-power-supply-cp-9020262-na', '$99.99 ', 'Corsair', 24, 1.3, 'ATX', '750 W', '140 mm'),
(2, 'Corsair RM850e (2023)', '//cdna.pcpartpicker.com/static/forever/images/product/74e6caafd69bcc53d6e5060a3249248d.256p.jpg', 'https://pcpartpicker.com/product/4ZRwrH/corsair-rm850e-2023-850-w-80-gold-certified-fully-modular-atx-power-supply-cp-9020263-na', '$129.99 ', 'Corsair', 30, 0.6, 'ATX', '850 W', '140 mm'),
(3, 'Corsair RM1000e (2023)', '//cdna.pcpartpicker.com/static/forever/images/product/ce27e414f67e9e8786401e4260bb85fa.256p.jpg', 'https://pcpartpicker.com/product/fxGhP6/corsair-rm1000e-2023-1000-w-80-gold-certified-fully-modular-atx-power-supply-cp-9020264-na', '$179.99 ', 'Corsair', 28, 4.2, 'ATX', '1000 W', '140 mm'),
(4, 'Corsair RM650 (2023)', '//cdna.pcpartpicker.com/static/forever/images/product/4c2a36634803871ec36077cba6cbac4f.256p.jpg', 'https://pcpartpicker.com/product/GdwmP6/corsair-rm650-2023-650-w-80-gold-certified-fully-modular-atx-power-supply-cp-9020280-na', '$89.99 ', 'Corsair', 1, 3.9, 'ATX', '650 W', '140 mm'),
(5, 'MSI MAG A650BN', '//cdna.pcpartpicker.com/static/forever/images/product/3148f884b77b2d7abee3a3e0ad72cf73.256p.jpg', 'https://pcpartpicker.com/product/8LNxFT/msi-mag-a-bn-650-w-80-bronze-certified-atx-power-supply-mag-a650bn', '$59.00 ', 'MSI', 24, 1.8, 'ATX', '650 W', '140 mm'),
(6, 'Corsair CX650M (2021)', '//cdna.pcpartpicker.com/static/forever/images/product/cd1c62429bd8d83e6d8dc273f0cc179c.256p.jpg', 'https://pcpartpicker.com/product/x96p99/corsair-cx650m-2021-650-w-80-bronze-certified-semi-modular-atx-power-supply-cp-9020221-na', '$79.99 ', 'Corsair', 16, 2.6, 'ATX', '650 W', '140 mm'),
(7, 'MSI MAG A850GL PCIE5', '//cdna.pcpartpicker.com/static/forever/images/product/79be60ce3783b8918a1c0940d3e4ff19.256p.jpg', 'https://pcpartpicker.com/product/zF4Zxr/msi-mag-a850gl-pcie5-850-w-80-gold-certified-fully-modular-atx-power-supply-mag-a850gl-pcie5', '$89.99 ', 'MSI', 7, 2.5, 'ATX', '850 W', '140 mm'),
(8, 'MSI MAG A550BN', 'https://m.media-amazon.com/images/I/51VZJ8DVX-L.jpg', 'https://pcpartpicker.com/product/mnVmP6/msi-mag-a550bn-550-w-80-bronze-certified-atx-power-supply-mag-a550bn', '$49.00 ', 'MSI', 37, 4.5, 'ATX', '550 W', '140 mm'),
(9, 'Corsair SF750', 'https://m.media-amazon.com/images/I/41XA+O8OFNL.jpg', 'https://pcpartpicker.com/product/nJrmP6/corsair-750-w-80-platinum-certified-fully-modular-sfx-power-supply-cp-9020186-na', '$184.99 ', 'Corsair', 14, 0.1, 'SFX', '750 W', '100 mm'),
(10, 'Corsair RM850', '//cdna.pcpartpicker.com/static/forever/images/product/1752baa3ddb162df098cf33b0b6eeae3.256p.jpg', 'https://pcpartpicker.com/product/9KGbt6/corsair-rm850-850-w-80-gold-certified-fully-modular-atx-power-supply-cp-9020232-na', '$124.99 ', 'Corsair', 13, 1.9, 'ATX', '850 W', '160 mm'),
(11, 'Corsair RM850x (2021)', '//cdna.pcpartpicker.com/static/forever/images/product/4f19c6453ce4ebe67091e6d9735f3a19.256p.jpg', 'https://pcpartpicker.com/product/26rRsY/corsair-rm850x-2021-850-w-80-gold-certified-fully-modular-atx-power-supply-cp-9020200-na', '$124.99 ', 'Corsair', 20, 4.4, 'ATX', '850 W', '160 mm'),
(12, 'Thermaltake Smart', 'https://m.media-amazon.com/images/I/41TubKs3apL.jpg', 'https://pcpartpicker.com/product/Wbhj4D/thermaltake-smart-500w-80-certified-atx-power-supply-ps-spd-0500npcwus-w', '$39.06 ', 'Thermaltake', 14, 1.1, 'ATX', '500 W', '140 mm'),
(13, 'Cooler Master MWE Gold 850 - V2', '//cdna.pcpartpicker.com/static/forever/images/product/01c5294aaa030cd889e3923906b92a10.256p.jpg', 'https://pcpartpicker.com/product/tWMTwP/cooler-master-mwe-gold-850-v2-850-w-80-gold-certified-fully-modular-atx-power-supply-mpe-8501-afaag-us', '$89.99 ', 'Cooler Master', 11, 2.5, 'ATX', '850 W', '160 mm'),
(14, 'Corsair RM1000x (2021)', '//cdna.pcpartpicker.com/static/forever/images/product/2e9c1e7ffca723f2acf802efc7f4e331.256p.jpg', 'https://pcpartpicker.com/product/jRvdnQ/corsair-rm1000x-2021-1000-w-80-gold-certified-fully-modular-atx-power-supply-cp-9020201-na', '$159.99 ', 'Corsair', 14, 4.2, 'ATX', '1000 W', '180 mm'),
(15, 'Thermaltake Smart', 'https://images-eu.ssl-images-amazon.com/images/I/51Ih1TB6nFL.jpg', 'https://pcpartpicker.com/product/6RTrxr/thermaltake-smart-600w-80-certified-semi-modular-atx-power-supply-ps-spd-0600npcwus-w', '$40.99 ', 'Thermaltake', 38, 3.3, 'ATX', '600 W', '140 mm'),
(16, 'Asus ROG THOR 1600T Gaming', '//cdna.pcpartpicker.com/static/forever/images/product/b22fb9713e4ad5dd4245dbec30740766.256p.jpg', 'https://pcpartpicker.com/product/7m6p99/asus-rog-thor-1600t-gaming-1600-w-80-titanium-certified-fully-modular-atx-power-supply-90ye00k0-b0na00', '$697.32 ', 'Asus', 49, 4.2, 'ATX', '1600 W', '190 mm'),
(17, 'MSI MAG A650GL', '//cdna.pcpartpicker.com/static/forever/images/product/9fd701005a49816e85072d6ed79c2951.256p.jpg', 'https://pcpartpicker.com/product/xfV2FT/msi-mag-a650gl-650-w-80-gold-certified-fully-modular-atx-power-supply-mag-a650gl', '$79.98 ', 'MSI', 32, 0.9, 'ATX', '650 W', '140 mm'),
(18, 'MSI MAG A750GL PCIE5', '//cdna.pcpartpicker.com/static/forever/images/product/d8f4d13ba49891eb3929bdddc3d87b4b.256p.jpg', 'https://pcpartpicker.com/product/dbCZxr/msi-mag-a750gl-pcie5-750-w-80-gold-certified-fully-modular-atx-power-supply-mag-a750gl-pcie5', '$89.00 ', 'MSI', 12, 2.1, 'ATX', '750 W', '140 mm'),
(19, 'Corsair SF850L', '//cdna.pcpartpicker.com/static/forever/images/product/d5e4643306487f67e242fb7fc484f7b8.256p.jpg', 'https://pcpartpicker.com/product/LxsV3C/corsair-sf850l-850-w-80-gold-certified-fully-modular-sfx-power-supply-cp-9020245-na', '$149.99 ', 'Corsair', 14, 2.8, 'SFX', '850 W', '130 mm'),
(20, 'Apevia Galaxy', 'https://m.media-amazon.com/images/I/41tTcSFPOyS.jpg', 'https://pcpartpicker.com/product/cN26Mp/apevia-galaxy-650-w-80-gold-certified-semi-modular-atx-power-supply-atx-gx650w', '$54.99 ', 'Apevia', 33, 2.5, 'ATX', '650 W', '160 mm'),
(21, 'Corsair HX1500i (2023)', 'https://m.media-amazon.com/images/I/51KR9mokksL.jpg', 'https://pcpartpicker.com/product/fFbRsY/corsair-hx1500i-2023-1500-w-80-platinum-certified-fully-modular-atx-power-supply-cp-9020261-na', '$359.99 ', 'Corsair', 26, 4.3, 'ATX', '1500 W', '180 mm'),
(22, 'SeaSonic FOCUS Plus 650 Gold', '//cdna.pcpartpicker.com/static/forever/images/product/84b3aab42651adcad9a0b05ac262ea53.256p.jpg', 'https://pcpartpicker.com/product/WrNypg/seasonic-focus-plus-gold-650w-80-gold-certified-fully-modular-atx-power-supply-ssr-650fx', '$103.61 ', 'SeaSonic', 29, 3.9, 'ATX', '650 W', '140 mm');

-- --------------------------------------------------------

--
-- Structure de la table `processors`
--

DROP TABLE IF EXISTS `processors`;
CREATE TABLE IF NOT EXISTS `processors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(49) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `imageURL` varchar(99) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `productURL` varchar(127) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `manufacturer` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantityInStock` int DEFAULT '0',
  `rating` float DEFAULT NULL,
  `series` varchar(21) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `microarchitecture` varchar(19) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `socket` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `coreCount` int DEFAULT NULL,
  `clock` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `integratedGraphics` varchar(23) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COMMENT='productsTable';

--
-- Déchargement des données de la table `processors`
--

INSERT INTO `processors` (`id`, `name`, `imageURL`, `productURL`, `price`, `manufacturer`, `quantityInStock`, `rating`, `series`, `microarchitecture`, `socket`, `coreCount`, `clock`, `integratedGraphics`) VALUES
(1, 'AMD Ryzen 7 7800X3D', '//cdna.pcpartpicker.com/static/forever/images/product/f0e0e59d75066ec825667b71c31e3c83.256p.jpg', 'https://pcpartpicker.com/product/3hyH99/amd-ryzen-7-7800x3d-42-ghz-8-core-processor-100-100000910wof', '$269.00 ', 'AMD', 0, 4, 'AMD Ryzen 7', 'Zen 4', 'AM5', 8, '4.2 GHz', 'Radeon'),
(2, 'AMD Ryzen 5 7600X', '//cdna.pcpartpicker.com/static/forever/images/product/fd6305088c9d16d59017b380fb9c408a.256p.jpg', 'https://pcpartpicker.com/product/66C48d/amd-ryzen-5-7600x-47-ghz-6-core-processor-100-100000593wof', '$159.00 ', 'AMD', 29, 4, 'AMD Ryzen 5', 'Zen 4', 'AM5', 6, '4.7 GHz', 'Radeon'),
(3, 'AMD Ryzen 5 5600X', '//cdna.pcpartpicker.com/static/forever/images/product/3ef757133d38ac40afe75da691ba7d60.256p.jpg', 'https://pcpartpicker.com/product/g94BD3/amd-ryzen-5-5600x-37-ghz-6-core-processor-100-100000065box', '$129.99 ', 'AMD', 46, 3.2, 'AMD Ryzen 5', 'Zen 3', 'AM4', 6, '3.7 GHz', 'None'),
(4, 'AMD Ryzen 5 7600', '//cdna.pcpartpicker.com/static/forever/images/product/4a9bfe0a3f46152eea8bea46c54e1775.256p.jpg', 'https://pcpartpicker.com/product/yXmmP6/amd-ryzen-5-7600-38-ghz-6-core-processor-100-100001015box', '$189.00 ', 'AMD', 43, 4.1, 'AMD Ryzen 5', 'Zen 4', 'AM5', 6, '3.8 GHz', 'Radeon'),
(5, 'Intel Core i9-14900K', '//cdna.pcpartpicker.com/static/forever/images/product/c9117c605854e9387e57cd69ebca2415.256p.jpg', 'https://pcpartpicker.com/product/ZLjRsY/intel-core-i9-14900k-32-ghz-24-core-processor-bx8071514900k', '$534.99 ', 'Intel', 30, 0.7, 'Intel Core i9', 'Raptor Lake Refresh', 'LGA1700', 24, '3.2 GHz', 'Intel UHD Graphics 770'),
(6, 'Intel Core i7-14700K', '//cdna.pcpartpicker.com/static/forever/images/product/c3e5d01cec2fa20b6f47fe8a400c08d6.256p.jpg', 'https://pcpartpicker.com/product/BmWJ7P/intel-core-i7-14700k-34-ghz-20-core-processor-bx8071514700k', '$389.99 ', 'Intel', 19, 1.1, 'Intel Core i7', 'Raptor Lake Refresh', 'LGA1700', 20, '3.4 GHz', 'Intel UHD Graphics 770'),
(7, 'Intel Core i5-12400F', '//cdna.pcpartpicker.com/static/forever/images/product/5fe3c9cc8cbaaa4aa52aed7389d2cc10.256p.jpg', 'https://pcpartpicker.com/product/pQNxFT/intel-core-i5-12400f-25-ghz-6-core-processor-bx8071512400f', '$128.33 ', 'Intel', 4, 3.6, 'Intel Core i5', 'Alder Lake', 'LGA1700', 6, '2.5 GHz', 'None'),
(8, 'AMD Ryzen 5 3600', '//cdna.pcpartpicker.com/static/forever/images/product/c7baf2c9c9cc15ae23adb24c2f4316fc.256p.jpg', 'https://pcpartpicker.com/product/9nm323/amd-ryzen-5-3600-36-thz-6-core-processor-100-100000031box', '$84.00 ', 'AMD', 15, 4.6, 'AMD Ryzen 5', 'Zen 2', 'AM4', 6, '3.6 GHz', 'None'),
(9, 'AMD Ryzen 7 7700X', '//cdna.pcpartpicker.com/static/forever/images/product/6d3fb7600f26fb1e94e8b0c1a99e0bfa.256p.jpg', 'https://pcpartpicker.com/product/WfqPxr/amd-ryzen-7-7700x-45-ghz-8-core-processor-100-100000591wof', '$287.00 ', 'AMD', 15, 2.4, 'AMD Ryzen 7', 'Zen 4', 'AM5', 8, '4.5 GHz', 'Radeon'),
(10, 'AMD Ryzen 9 7950X3D', '//cdna.pcpartpicker.com/static/forever/images/product/4f8b13807b9b9e2ab921ddb6e6e81afb.256p.jpg', 'https://pcpartpicker.com/product/X6XV3C/amd-ryzen-9-7950x3d-42-ghz-16-core-processor-100-100000908wof', '$567.00 ', 'AMD', 30, 3.2, 'AMD Ryzen 9', 'Zen 4', 'AM5', 16, '4.2 GHz', 'Radeon'),
(11, 'AMD Ryzen 5 5600', '//cdna.pcpartpicker.com/static/forever/images/product/49fca908d8863ded4df790bd3af6bc12.256p.jpg', 'https://pcpartpicker.com/product/PgcG3C/amd-ryzen-5-5600-36-ghz-6-core-processor-100-100000927box', '$139.00 ', 'AMD', 7, 3.8, 'AMD Ryzen 5', 'Zen 3', 'AM4', 6, '3.5 GHz', 'None'),
(12, 'AMD Ryzen 7 5800X', '//cdna.pcpartpicker.com/static/forever/images/product/9b4cefb2e43f2c358f3a97a31e1be90b.256p.jpg', 'https://pcpartpicker.com/product/qtvqqs/amd-ryzen-7-5800x-38-ghz-8-core-processor-100-100000063wof', '$159.00 ', 'AMD', 43, 4.3, 'AMD Ryzen 7', 'Zen 3', 'AM4', 8, '3.8 GHz', 'None'),
(13, 'AMD Ryzen 5 5500', '//cdna.pcpartpicker.com/static/forever/images/product/49fca908d8863ded4df790bd3af6bc12.256p.jpg', 'https://pcpartpicker.com/product/yq2WGX/amd-ryzen-5-5500-36-ghz-6-core-processor-100-100000457box', '$92.99 ', 'AMD', 47, 0.2, 'AMD Ryzen 5', 'Zen 3', 'AM4', 6, '3.6 GHz', 'None'),
(14, 'Intel Core i5-12600KF', '//cdna.pcpartpicker.com/static/forever/images/product/01163d618db9518d03041c9997e23bb1.256p.jpg', 'https://pcpartpicker.com/product/Tk8bt6/intel-core-i5-12600kf-37-ghz-6-core-processor-bx8071512600kf', '$150.00 ', 'Intel', 4, 3, 'Intel Core i5', 'Alder Lake', 'LGA1700', 10, '3.7 GHz', 'None'),
(15, 'Intel Core i7-12700K', '//cdna.pcpartpicker.com/static/forever/images/product/3f7037db801def4db8418df8e7498e6a.256p.jpg', 'https://pcpartpicker.com/product/ZbddnQ/intel-core-i7-12700k-36-ghz-8-core-processor-bx8071512700k', '$214.98 ', 'Intel', 30, 4.5, 'Intel Core i7', 'Alder Lake', 'LGA1700', 12, '3.6 GHz', 'Intel UHD Graphics 770'),
(16, 'AMD Ryzen 7 5700X', '//cdna.pcpartpicker.com/static/forever/images/product/a0931f2db7bb9c37a199429c85a0d2e1.256p.jpg', 'https://pcpartpicker.com/product/JmhFf7/amd-ryzen-7-5700x-34-ghz-8-core-processor-100-100000926wof', '$149.00 ', 'AMD', 40, 3.5, 'AMD Ryzen 7', 'Zen 3', 'AM4', 8, '3.4 GHz', 'None'),
(17, 'Intel Core i7-13700K', '//cdna.pcpartpicker.com/static/forever/images/product/2f3405387f23ab827695d966ea9f9682.256p.jpg', 'https://pcpartpicker.com/product/Mm6p99/intel-core-i7-13700k-34-ghz-16-core-processor-bx8071513700k', '$359.00 ', 'Intel', 8, 4, 'Intel Core i7', 'Raptor Lake', 'LGA1700', 16, '3.4 GHz', 'Intel UHD Graphics 770'),
(18, 'Intel Core i5-12600K', '//cdna.pcpartpicker.com/static/forever/images/product/3f727799b9fc5e83f0e8953759946bd2.256p.jpg', 'https://pcpartpicker.com/product/BB4Ycf/intel-core-i5-12600k-37-ghz-6-core-processor-bx8071512600k', '$175.34 ', 'Intel', 23, 4.5, 'Intel Core i5', 'Alder Lake', 'LGA1700', 10, '3.7 GHz', 'Intel UHD Graphics 770'),
(19, 'AMD Ryzen 7 5800X3D', '//cdna.pcpartpicker.com/static/forever/images/product/f83c6c4ee8cb5a6801f35aae5fc5d018.256p.jpg', 'https://pcpartpicker.com/product/CZ3gXL/amd-ryzen-7-5800x3d-34-ghz-8-core-processor-100-100000651wof', '$317.91 ', 'AMD', 41, 0.3, 'AMD Ryzen 7', 'Zen 3', 'AM4', 8, '3.4 GHz', 'None'),
(20, 'AMD Ryzen 9 7900X', '//cdna.pcpartpicker.com/static/forever/images/product/8de723005cfc1b85071c4abf4d76bd4e.256p.jpg', 'https://pcpartpicker.com/product/bwxRsY/amd-ryzen-9-7900x-47-ghz-12-core-processor-100-100000589wof', '$396.58 ', 'AMD', 37, 3, 'AMD Ryzen 9', 'Zen 4', 'AM5', 12, '4.7 GHz', 'Radeon'),
(21, 'AMD Ryzen 5 5600G', '//cdna.pcpartpicker.com/static/forever/images/product/1dd09dfdc581be6224a323d49d714c7f.256p.jpg', 'https://pcpartpicker.com/product/sYmmP6/amd-ryzen-5-5600g-39-ghz-6-core-processor-100-100000252box', '$132.99 ', 'AMD', 10, 4.2, 'AMD Ryzen 5', 'Zen 3', 'AM4', 6, '3.9 GHz', 'Radeon Vega 7'),
(22, 'AMD Ryzen 9 5900X', '//cdna.pcpartpicker.com/static/forever/images/product/1d7073a2deda3bd22963a7e248bbe3e4.256p.jpg', 'https://pcpartpicker.com/product/KwLwrH/amd-ryzen-9-5900x-37-ghz-12-core-processor-100-100000061wof', '$261.99 ', 'AMD', 41, 2, 'AMD Ryzen 9', 'Zen 3', 'AM4', 12, '3.7 GHz', 'None'),
(23, 'Intel Core i5-13600K', '//cdna.pcpartpicker.com/static/forever/images/product/535b5631a223b77657804c8144c1277e.256p.jpg', 'https://pcpartpicker.com/product/LfNxFT/intel-core-i5-13600k-35-ghz-14-core-processor-bx8071513600k', '$268.98 ', 'Intel', 28, 2.4, 'Intel Core i5', 'Raptor Lake', 'LGA1700', 14, '3.5 GHz', 'Intel UHD Graphics 770'),
(24, 'Intel Core i7-12700KF', '//cdna.pcpartpicker.com/static/forever/images/product/b69e4a2d3dd9f8fac9ed6bf1b631b0ce.256p.jpg', 'https://pcpartpicker.com/product/YDM48d/intel-core-i7-12700kf-36-ghz-8-core-processor-bx8071512700kf', '$228.90 ', 'Intel', 14, 1.1, 'Intel Core i7', 'Alder Lake', 'LGA1700', 12, '3.6 GHz', 'None'),
(25, 'Intel Core i9-14900KS', '//cdna.pcpartpicker.com/static/forever/images/product/7f03744e2c593edbbf711b21d85c59b3.256p.jpg', 'https://pcpartpicker.com/product/3ZmNnQ/intel-core-i9-14900ks-32-ghz-24-core-processor-bx8071514900ks', '$662.95 ', 'Intel', 36, 3.4, 'Intel Core i9', 'Raptor Lake Refresh', 'LGA1700', 24, '3.2 GHz', 'None');

-- --------------------------------------------------------

--
-- Structure de la table `ram_brackets`
--

DROP TABLE IF EXISTS `ram_brackets`;
CREATE TABLE IF NOT EXISTS `ram_brackets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(146) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `imageURL` varchar(99) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `productURL` varchar(147) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `manufacturer` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantityInStock` int DEFAULT '0',
  `rating` float DEFAULT NULL,
  `speed` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `modules` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `voltage` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COMMENT='productsTable';

--
-- Déchargement des données de la table `ram_brackets`
--

INSERT INTO `ram_brackets` (`id`, `name`, `imageURL`, `productURL`, `price`, `manufacturer`, `quantityInStock`, `rating`, `speed`, `modules`, `voltage`) VALUES
(1, 'Corsair Vengeance LPX 16 GB', '//cdna.pcpartpicker.com/static/forever/images/product/835ab3efad1be13bbe53beef3e3c6f96.256p.jpg', 'https://pcpartpicker.com/product/p6RFf7/corsair-memory-cmk16gx4m2b3200c16', '$44.99 ', '\nCorsair\n', 15, 1, '\nDDR4-3200\n', '\n2 x 8GB\n', '\n1.35 V\n'),
(2, 'Corsair Vengeance 32 GB', 'https://m.media-amazon.com/images/I/41jJSPS8W7L.jpg', 'https://pcpartpicker.com/product/4kmmP6/corsair-vengeance-32-gb-2-x-16-gb-ddr5-5600-cl36-memory-cmk32gx5m2b5600c36', '$113.99 ', '\nCorsair\n', 18, 2.1, '\nDDR5-5600\n', '\n2 x 16GB\n', '\n1.25 V\n'),
(3, 'G.Skill Trident Z5 RGB 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/e8d573bd2eac864d427645f0d2f7cad8.256p.jpg', 'https://pcpartpicker.com/product/mhJgXL/gskill-trident-z5-rgb-32-gb-2-x-16-gb-ddr5-6000-cl36-memory-f5-6000j3636f16gx2-tz5rk', '$117.99 ', '\nG.Skill\n', 46, 2.5, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(4, 'Corsair Vengeance 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/fe414d3559a9bbb2e092ba5374f6e1ed.256p.jpg', 'https://pcpartpicker.com/product/JkfxFT/corsair-vengeance-32-gb-2-x-16-gb-ddr5-6000-cl30-memory-cmk32gx5m2b6000c30', '$114.99 ', '\nCorsair\n', 25, 1.3, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.4 V\n'),
(5, 'Corsair Vengeance RGB Pro 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/5f09867b54e9ad932b4dd1bc767f6238.256p.jpg', 'https://pcpartpicker.com/product/khmFf7/corsair-vengeance-rgb-pro-32-gb-2-x-16-gb-ddr4-3600-memory-cmw32gx4m2z3600c18', '$94.99 ', '\nCorsair\n', 37, 3.7, '\nDDR4-3600\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(6, 'G.Skill Trident Z5 RGB 64 GB', '//cdna.pcpartpicker.com/static/forever/images/product/e5d0d71b07fa16cc1ac7eb3c676a7831.256p.jpg', 'https://pcpartpicker.com/product/636p99/gskill-trident-z5-rgb-64-gb-2-x-32-gb-ddr5-6400-cl32-memory-f5-6400j3239g32gx2-tz5rk', '$217.99 ', '\nG.Skill\n', 9, 4.8, '\nDDR5-6400\n', '\n2 x 32GB\n', '\n1.4 V\n'),
(7, 'Corsair Vengeance LPX 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/11742fd6eec55fde4e3ee3a79529a111.256p.jpg', 'https://pcpartpicker.com/product/Yg3mP6/corsair-vengeance-lpx-32-gb-2-x-16-gb-ddr4-3600-memory-cmk32gx4m2d3600c18', '$81.99 ', '\nCorsair\n', 38, 3, '\nDDR4-3600\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(8, 'Corsair Vengeance RGB 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/ebca1cc55cb7829ce3ed0b8a13efce7e.256p.jpg', 'https://pcpartpicker.com/product/QTLFf7/corsair-vengeance-rgb-32-gb-2-x-16-gb-ddr5-6000-cl36-memory-cmh32gx5m2d6000c36w', '$127.99 ', '\nCorsair\n', 12, 0.5, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(9, 'TEAMGROUP T-Force Delta RGB 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/09e373465295e5629efd7959a7147a3b.256p.jpg', 'https://pcpartpicker.com/product/WFVmP6/teamgroup-t-force-delta-rgb-32-gb-2-x-16-gb-ddr5-6000-cl30-memory-ff4d532g6000hc30dc01', '$106.99 ', '\nTEAMGROUP\n', 49, 3.6, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(10, 'TEAMGROUP T-Force Delta RGB 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/d2e3f9b94f541ad51a19011026245df2.256p.jpg', 'https://pcpartpicker.com/product/2JLFf7/teamgroup-t-force-delta-rgb-32-gb-2-x-16-gb-ddr5-6000-cl30-memory-ff3d532g6000hc30dc01', '$104.21 ', '\nTEAMGROUP\n', 6, 1.6, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(11, 'Corsair Vengeance RGB Pro 16 GB', '//cdna.pcpartpicker.com/static/forever/images/product/87cd8e9d02ffb0997769f4a4d5969669.256p.jpg', 'https://pcpartpicker.com/product/QDhKHx/corsair-vengeance-rgb-pro-16gb-2-x-8gb-ddr4-3200-memory-cmw16gx4m2c3200c16', '$54.99 ', '\nCorsair\n', 36, 2, '\nDDR4-3200\n', '\n2 x 8GB\n', '\n1.35 V\n'),
(12, 'Corsair Vengeance 16 GB', '//cdna.pcpartpicker.com/static/forever/images/product/c61cf578206c7afb06eb1af27edb1f7b.256p.jpg', 'https://pcpartpicker.com/product/H6rqqs/corsair-vengeance-16-gb-2-x-8-gb-ddr5-5200-cl40-memory-cmk16gx5m2b5200c40', '$74.98 ', '\nCorsair\n', 12, 0.1, '\nDDR5-5200\n', '\n2 x 8GB\n', '\n1.25 V\n'),
(13, 'G.Skill Flare X5 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/5bfb04d855b1e501d71ef7516d5c39f7.256p.jpg', 'https://pcpartpicker.com/product/pwxRsY/gskill-flare-x5-32-gb-2-x-16-gb-ddr5-6000-cl36-memory-f5-6000j3636f16gx2-fx5', '$102.99 ', '\nG.Skill\n', 2, 4.6, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(14, 'G.Skill Trident Z5 Neo RGB 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/a4cecff25f58230f3fbae1903d711e49.256p.jpg', 'https://pcpartpicker.com/product/CXKKHx/gskill-trident-z5-neo-rgb-32-gb-2-x-16-gb-ddr5-6000-cl30-memory-f5-6000j3038f16gx2-tz5nr', '$112.99 ', '\nG.Skill\n', 26, 2.7, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(15, 'Silicon Power GAMING 16 GB', '//cdna.pcpartpicker.com/static/forever/images/product/62a4ba196f5f165e68619a63ef5d0b70.256p.jpg', 'https://pcpartpicker.com/product/P4FKHx/silicon-power-sp016gxlzu320bdaj5-16-gb-2-x-8-gb-ddr4-3200-cl16-memory-sp016gxlzu320bdaj5', '$30.99 ', '\nSilicon Power\n', 22, 4.5, '\nDDR4-3200\n', '\n2 x 8GB\n', '\n1.35 V\n'),
(16, 'G.Skill Ripjaws V 16 GB', 'https://m.media-amazon.com/images/I/31yJ+tDh0lL.jpg', 'https://pcpartpicker.com/product/n76p99/gskill-ripjaws-v-16-gb-2-x-8-gb-ddr4-4800-cl17-memory-f4-4800c17d-16gvk', '$3,914.75 ', '\nG.Skill\n', 33, 4.5, '\nDDR4-4800\n', '\n2 x 8GB\n', '\n1.6 V\n'),
(17, 'Corsair Vengeance 64 GB', '//cdna.pcpartpicker.com/static/forever/images/product/44511eed6b609f1979ca94fe5ed2e2ad.256p.jpg', 'https://pcpartpicker.com/product/TJZ9TW/corsair-vengeance-64-gb-2-x-32-gb-ddr5-5200-cl40-memory-cmk64gx5m2b5200c40', '$154.99 ', '\nCorsair\n', 1, 4.1, '\nDDR5-5200\n', '\n2 x 32GB\n', '\n1.25 V\n'),
(18, 'G.Skill Flare X5 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/2a5856ab677607ec6f3b1c25bed693ab.256p.jpg', 'https://pcpartpicker.com/product/LBstt6/gskill-flare-x5-32-gb-2-x-16-gb-ddr5-6000-cl30-memory-f5-6000j3038f16gx2-fx5', '$104.99 ', '\nG.Skill\n', 4, 2.1, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(19, 'TEAMGROUP T-Force Vulcan Z 16 GB', '//cdna.pcpartpicker.com/static/forever/images/product/96753a64597c28e46bf80ef7064b214b.256p.jpg', 'https://pcpartpicker.com/product/z3VD4D/team-t-force-vulcan-z-16-gb-2-x-8-gb-ddr4-3200-memory-tlzgd416g3200hc16cdc01', '$34.99 ', '\nTEAMGROUP\n', 18, 3.2, '\nDDR4-3200\n', '\n2 x 8GB\n', '\n1.35 V\n'),
(20, 'Corsair Vengeance RGB 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/b2d107d629e656f9f435ce9bd604f7e0.256p.jpg', 'https://pcpartpicker.com/product/h47G3C/corsair-vengeance-rgb-32-gb-2-x-16-gb-ddr5-6000-cl40-memory-cmh32gx5m2b6000c40', '$134.99 ', '\nCorsair\n', 29, 4.7, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.35 V\n'),
(21, 'Corsair Vengeance LPX 16 GB', '//cdna.pcpartpicker.com/static/forever/images/product/a462328473351f9140c87f8c1d115ffe.256p.jpg', 'https://pcpartpicker.com/product/VNJtt6/corsair-16-gb-2-x-8-gb-ddr4-3600-memory-cmk16gx4m2d3600c18', '$40.99 ', '\nCorsair\n', 42, 3.8, '\nDDR4-3600\n', '\n2 x 8GB\n', '\n1.35 V\n'),
(22, 'Corsair Vengeance RGB 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/894ce2f4aaaf96e8a0cc61288f9ff27d.256p.jpg', 'https://pcpartpicker.com/product/kTJp99/corsair-vengeance-rgb-32-gb-2-x-16-gb-ddr5-6000-cl36-memory-cmh32gx5m2e6000c36', '$112.99 ', '\nCorsair\n', 24, 0, '\nDDR5-6000\n', '\n2 x 16GB\n', '\n1.4 V\n'),
(23, 'G.Skill Ripjaws V 32 GB', '//cdna.pcpartpicker.com/static/forever/images/product/f97fce0b44ff2447a790b0bffc74f9f3.256p.jpg', 'https://pcpartpicker.com/product/kXbkcf/gskill-ripjaws-v-32-gb-2-x-16-gb-ddr4-3200-cl16-memory-f4-3200c16d-32gvk', '$67.98 ', '\nG.Skill\n', 42, 3.7, '\nDDR4-3200\n', '\n2 x 16GB\n', '\n1.35 V\n');

-- --------------------------------------------------------

--
-- Structure de la table `storage_drives`
--

DROP TABLE IF EXISTS `storage_drives`;
CREATE TABLE IF NOT EXISTS `storage_drives` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(84) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `imageURL` varchar(99) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `productURL` varchar(158) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `manufacturer` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantityInStock` int DEFAULT '0',
  `rating` float DEFAULT NULL,
  `capacity` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `type` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COMMENT='productsTable';

--
-- Déchargement des données de la table `storage_drives`
--

INSERT INTO `storage_drives` (`id`, `name`, `imageURL`, `productURL`, `price`, `manufacturer`, `quantityInStock`, `rating`, `capacity`, `type`) VALUES
(1, 'Samsung 980 Pro', '//cdna.pcpartpicker.com/static/forever/images/product/3b2a91588d1a28bfa1b0184fb7f1c0a1.256p.jpg', 'https://pcpartpicker.com/product/f3cRsY/samsung-980-pro-2-tb-m2-2280-nvme-solid-state-drive-mz-v8p2t0bam', '$179.00 ', '\nSamsung\n', 42, 0.6, '\n2 TB\n', '\nSSD\n'),
(2, 'Kingston NV2', '//cdna.pcpartpicker.com/static/forever/images/product/7aa3028d0fc04e0ee3323f474bd349bd.256p.jpg', 'https://pcpartpicker.com/product/FnYmP6/kingston-nv2-1-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-snv2s1000g', '$60.99 ', '\nKingston\n', 10, 2.3, '\n1 TB\n', '\nSSD\n'),
(3, 'Samsung 970 Evo Plus', '//cdna.pcpartpicker.com/static/forever/images/product/326881d073c1b667bd348893696c690e.256p.jpg', 'https://pcpartpicker.com/product/Zxw7YJ/samsung-970-evo-plus-1-tb-m2-2280-nvme-solid-state-drive-mz-v7s1t0bam', '$97.50 ', '\nSamsung\n', 22, 4.5, '\n1 TB\n', '\nSSD\n'),
(4, 'Samsung 990 Pro', '//cdna.pcpartpicker.com/static/forever/images/product/242cc7c9d1e07078de3b04029e20dd82.256p.jpg', 'https://pcpartpicker.com/product/RKYmP6/samsung-990-pro-4-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-mz-v9p4t0bw', '$309.99 ', '\nSamsung\n', 30, 0.9, '\n4 TB\n', '\nSSD\n'),
(5, 'Crucial P3 Plus', '//cdna.pcpartpicker.com/static/forever/images/product/2830bf3ba317c794ccde742efe4304be.256p.jpg', 'https://pcpartpicker.com/product/chzhP6/crucial-p3-plus-1-tb-m2-2280-nvme-solid-state-drive-ct1000p3pssd8', '$72.50 ', '\nCrucial\n', 36, 1, '\n1 TB\n', '\nSSD\n'),
(6, 'Samsung 980 Pro', '//cdna.pcpartpicker.com/static/forever/images/product/4e02c24a00f7b79a56489db2acbe3a9b.256p.jpg', 'https://pcpartpicker.com/product/DDWBD3/samsung-980-pro-1-tb-m2-2280-nvme-solid-state-drive-mz-v8p1t0bam', '$106.13 ', '\nSamsung\n', 39, 2.4, '\n1 TB\n', '\nSSD\n'),
(7, 'Samsung 990 Pro', '//cdna.pcpartpicker.com/static/forever/images/product/55fb148a837f9e33dfdb095188af8a74.256p.jpg', 'https://pcpartpicker.com/product/34ytt6/samsung-990-pro-2-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-mz-v9p2t0bw', '$184.50 ', '\nSamsung\n', 40, 3.8, '\n2 TB\n', '\nSSD\n'),
(8, 'Crucial P3 Plus', 'https://m.media-amazon.com/images/I/31nXTKlKQYL.jpg', 'https://pcpartpicker.com/product/yGZ9TW/crucial-p3-plus-2-tb-m2-2280-nvme-solid-state-drive-ct2000p3pssd8', '$124.99 ', '\nCrucial\n', 31, 1.7, '\n2 TB\n', '\nSSD\n'),
(9, 'Western Digital Black SN850X', '//cdna.pcpartpicker.com/static/forever/images/product/8e6dbae8a0f3c6572216c8758ce5a0b5.256p.jpg', 'https://pcpartpicker.com/product/crKKHx/western-digital-black-sn850x-2-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-wds200t2x0e', '$159.00 ', '\nWestern Digital\n', 38, 2.1, '\n2 TB\n', '\nSSD\n'),
(10, 'Seagate Barracuda Compute', '//cdna.pcpartpicker.com/static/forever/images/product/c7b5b7dacbecdcdd0e073b761193eef6.256p.jpg', 'https://pcpartpicker.com/product/mwrYcf/seagate-barracuda-computer-2-tb-35-7200rpm-internal-hard-drive-st2000dm008', '$64.98 ', '\nSeagate\n', 47, 0.4, '\n2 TB\n', '\n7200 RPM\n'),
(11, ',', '', '', '', '', 21, 0.7, '', ''),
(12, 'SATA 6.0 Gb/s', '', '', '', '', 17, 2.2, '', ''),
(13, ',No\"', '9', '', '', '', 19, 4.1, '', ''),
(14, 'Mushkin Source HC', 'https://m.media-amazon.com/images/I/31KeULdwSLL.jpg', 'https://pcpartpicker.com/product/zxVmP6/mushkin-source-hc-16-tb-25-solid-state-drive-mknssdhc16tb', '$2,302.98 ', '\nMushkin\n', 48, 4, '\n16 TB\n', '\nSSD\n'),
(15, ',No\"', '8', '', '', '', 31, 2.4, '', ''),
(16, 'Kingston NV2', '//cdna.pcpartpicker.com/static/forever/images/product/f1af66b97ac908b094775b859ce9d33e.256p.jpg', 'https://pcpartpicker.com/product/3QXJ7P/kingston-nv2-2-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-snv2s2000g', '$118.00 ', '\nKingston\n', 13, 0.3, '\n2 TB\n', '\nSSD\n'),
(17, 'Western Digital Blue SN580', '//cdna.pcpartpicker.com/static/forever/images/product/f3d3390c0b08de6bbdfecbac012c639b.256p.jpg', 'https://pcpartpicker.com/product/rqhv6h/western-digital-blue-sn580-1-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-wds100t3b0e', '$71.00 ', '\nWestern Digital\n', 23, 4, '\n1 TB\n', '\nSSD\n'),
(18, 'Western Digital Black SN770', 'https://m.media-amazon.com/images/I/310UZVOtlfL.jpg', 'https://pcpartpicker.com/product/4KRYcf/western-digital-2-tb-m2-2280-nvme-solid-state-drive-wds200t3x0e', '$137.46 ', '\nWestern Digital\n', 25, 4.3, '\n2 TB\n', '\nSSD\n'),
(19, 'Kingston NV2', '//cdna.pcpartpicker.com/static/forever/images/product/b95d0c7234714c4d7bb0f246c23cd3b9.256p.jpg', 'https://pcpartpicker.com/product/QvpzK8/kingston-nv2-500-gb-m2-2280-pcie-40-x4-nvme-solid-state-drive-snv2s500g', '$42.99 ', '\nKingston\n', 8, 4.5, '\n500 GB\n', '\nSSD\n'),
(20, 'Western Digital Black SN850X', '//cdna.pcpartpicker.com/static/forever/images/product/8e6dbae8a0f3c6572216c8758ce5a0b5.256p.jpg', 'https://pcpartpicker.com/product/yBC48d/western-digital-black-sn850x-4-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-wds400t2x0e', '$314.00 ', '\nWestern Digital\n', 16, 4.6, '\n4 TB\n', '\nSSD\n'),
(21, 'Silicon Power UD90', '//cdna.pcpartpicker.com/static/forever/images/product/664aadb9f84d7293d083671b43c1f898.256p.jpg', 'https://pcpartpicker.com/product/f4cG3C/silicon-power-ud90-2-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-sp02kgbp44ud9005', '$114.97 ', '\nSilicon Power\n', 6, 4.3, '\n2 TB\n', '\nSSD\n'),
(22, 'TEAMGROUP MP44L', '//cdna.pcpartpicker.com/static/forever/images/product/54ce8af72e7d2a00dfe405da2cbf5313.256p.jpg', 'https://pcpartpicker.com/product/2VJgXL/teamgroup-mp44l-2-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-tm8fpk002t0c101', '$112.99 ', '\nTEAMGROUP\n', 32, 3, '\n2 TB\n', '\nSSD\n'),
(23, 'Samsung 870 QVO', '//cdna.pcpartpicker.com/static/forever/images/product/29b838814626cac9b060a2d2c0a293cd.256p.jpg', 'https://pcpartpicker.com/product/7Qvqqs/samsung-870-qvo-8-tb-25-solid-state-drive-mz-77q8t0bam', '$594.90 ', '\nSamsung\n', 44, 2, '\n8 TB\n', '\nSSD\n'),
(24, 'Crucial T700', '//cdna.pcpartpicker.com/static/forever/images/product/708ad07de98d1fb30d2435a7ef47b3ab.256p.jpg', 'https://pcpartpicker.com/product/xhkH99/crucial-t700-4-tb-m2-2280-pcie-50-x4-nvme-solid-state-drive-ct4000t700ssd3', '$426.99 ', '\nCrucial\n', 23, 1.1, '\n4 TB\n', '\nSSD\n');

-- --------------------------------------------------------

--
-- Structure de la table `test`
--

DROP TABLE IF EXISTS `test`;
CREATE TABLE IF NOT EXISTS `test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(130) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `imageURL` varchar(99) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `productURL` varchar(179) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `manufacturer` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantityInStock` int DEFAULT '0',
  `rating` float DEFAULT NULL,
  `chipset` varchar(27) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `memory` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `clock` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `frameSync` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5167 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `test`
--

INSERT INTO `test` (`id`, `name`, `imageURL`, `productURL`, `price`, `manufacturer`, `quantityInStock`, `rating`, `chipset`, `memory`, `clock`, `frameSync`) VALUES
(1, 'MSI GeForce RTX 3060 Ventus 2X 12G', '//cdna.pcpartpicker.com/static/forever/images/product/dbc81b89efc82ce66fb2e3ab7e0f0658.256p.jpg', 'https://pcpartpicker.com/product/pD8bt6/msi-geforce-rtx-3060-ventus-2x-12g-geforce-rtx-3060-12gb-12-gb-video-card-rtx3060ventus2x12goc', '$289.00 ', 'MSI', 2, 2, 'GeForce RTX 3060 12GB', '12 GB', '1320 MHz', 'G-Sync'),
(2, 'Gigabyte WINDFORCE OC', '//cdna.pcpartpicker.com/static/forever/images/product/772cce097c55469671a0d75ea4aca83a.256p.jpg', 'https://pcpartpicker.com/product/FnLdnQ/gigabyte-windforce-oc-geforce-rtx-4070-12-gb-video-card-gv-n4070wf3oc-12gd', '$581.19 ', 'Gigabyte', 1, 0.3, 'GeForce RTX 4070', '12 GB', '1920 MHz', 'G-Sync'),
(3, 'Asus ROG STRIX GAMING OC', '//cdna.pcpartpicker.com/static/forever/images/product/9f7b45a2816c45ea9449e8ca2bf6f616.256p.jpg', 'https://pcpartpicker.com/product/ZKWzK8/asus-rog-strix-gaming-oc-geforce-rtx-4090-24-gb-video-card-rog-strix-rtx4090-o24g-gaming', '$1,979.99 ', 'Asus', 1, 0.3, 'GeForce RTX 4090', '24 GB', '2235 MHz', 'G-Sync'),
(4, 'Gigabyte WINDFORCE OC', '//cdna.pcpartpicker.com/static/forever/images/product/6b90f36fbe6c1408ac40ab85c762807c.256p.jpg', 'https://pcpartpicker.com/product/KvcgXL/gigabyte-windforce-oc-geforce-rtx-4070-ti-super-16-gb-video-card-gv-n407tswf3oc-16gd', '$799.99 ', 'Gigabyte', 0, 0.5, 'GeForce RTX 4070 Ti SUPER', '16 GB', '2340 MHz', 'G-Sync'),
(5, 'Asus DUAL OC', '//cdna.pcpartpicker.com/static/forever/images/product/b836633d335617f71eb7b4e5f0ba43b7.256p.jpg', 'https://pcpartpicker.com/product/X7CZxr/asus-dual-oc-geforce-rtx-4060-8-gb-video-card-dual-rtx4060-o8g', '$309.99 ', 'Asus', 49, 1.9, 'GeForce RTX 4060', '8 GB', '1830 MHz', 'G-Sync'),
(6, 'Gigabyte GAMING OC', '//cdna.pcpartpicker.com/static/forever/images/product/7760e2607e7488a74486e8de8d3162b5.256p.jpg', 'https://pcpartpicker.com/product/mHpQzy/gigabyte-gaming-oc-radeon-rx-7800-xt-16-gb-video-card-gv-r78xtgaming-oc-16gd', '$499.00 ', 'Gigabyte', 43, 2.8, 'Radeon RX 7800 XT', '16 GB', '1295 MHz', 'FreeSync'),
(7, 'Gigabyte WINDFORCE OC', '//cdna.pcpartpicker.com/static/forever/images/product/c17472cd578b7847c10089750b161a2f.256p.jpg', 'https://pcpartpicker.com/product/HCkH99/gigabyte-windforce-oc-geforce-rtx-4070-super-12-gb-video-card-gv-n407swf3oc-12gd', '$599.99 ', 'Gigabyte', 22, 3.2, 'GeForce RTX 4070 SUPER', '12 GB', '1980 MHz', 'G-Sync'),
(8, 'ASRock Challenger D', '//cdna.pcpartpicker.com/static/forever/images/product/c5489241c902a9ae06a42212e978f989.256p.jpg', 'https://pcpartpicker.com/product/D9ytt6/asrock-radeon-rx-6600-8-gb-challenger-d-video-card-rx6600-cld-8g', '$189.99 ', 'ASRock', 30, 2.8, 'Radeon RX 6600', '8 GB', '1626 MHz', 'FreeSync'),
(9, 'PNY VCNRTX6000ADA-PB', '//cdna.pcpartpicker.com/static/forever/images/product/6ef5b8f1b94982c71019a0d9ac2795e2.256p.jpg', 'https://pcpartpicker.com/product/82bRsY/pny-vcnrtx6000ada-pb-rtx-6000-ada-generation-48-gb-video-card-vcnrtx6000ada-pb', '$9,999.00 ', 'PNY', 36, 4.2, 'RTX 6000 Ada Generation', '48 GB', '915 MHz', 'None'),
(10, 'XFX Speedster SWFT 309', 'https://m.media-amazon.com/images/I/41Gcn+794SS.jpg', 'https://pcpartpicker.com/product/RFGbt6/xfx-radeon-rx-6700-xt-12-gb-speedster-swft-309-video-card-rx-67xtyjfdv', '$299.99 ', 'XFX', 40, 2.7, 'Radeon RX 6700 XT', '12 GB', '2321 MHz', 'FreeSync'),
(11, 'NVIDIA Founders Edition', '//cdna.pcpartpicker.com/static/forever/images/product/07ff8dc03a65e34edc811c97d838af9a.256p.jpg', 'https://pcpartpicker.com/product/BCGbt6/nvidia-founders-edition-geforce-rtx-4090-24-gb-video-card-900-1g136-2530-000', '$1,972.99 ', 'NVIDIA', 40, 1.1, 'GeForce RTX 4090', '24 GB', '2230 MHz', 'G-Sync'),
(12, 'Gigabyte EAGLE', '//cdna.pcpartpicker.com/static/forever/images/product/80f174eea93a4a0981c63721c9a9805d.256p.jpg', 'https://pcpartpicker.com/product/j89wrH/gigabyte-eagle-geforce-rtx-4060-ti-8-gb-video-card-gv-n406teagle-8gd', '$390.99 ', 'Gigabyte', 33, 2.2, 'GeForce RTX 4060 Ti', '8 GB', '2310 MHz', 'G-Sync'),
(13, 'Asus ROG STRIX GAMING OC', '//cdna.pcpartpicker.com/static/forever/images/product/2aab4ec16f5be8f6d95d1e5848c2d9be.256p.jpg', 'https://pcpartpicker.com/product/V8hFf7/asus-rog-strix-gaming-oc-geforce-rtx-4090-24-gb-video-card-rog-strix-rtx4090-o24g-white', '$2,029.00 ', 'Asus', 45, 2.9, 'GeForce RTX 4090', '24 GB', '2235 MHz', 'G-Sync'),
(14, 'Gigabyte AERO OC', '//cdna.pcpartpicker.com/static/forever/images/product/13a70d0303a8922898892321f6b35104.256p.jpg', 'https://pcpartpicker.com/product/xh3NnQ/gigabyte-aero-oc-geforce-rtx-4060-8-gb-video-card-gv-n4060aero-oc-8gd', '$319.99 ', 'Gigabyte', 28, 3, 'GeForce RTX 4060', '8 GB', '1830 MHz', 'G-Sync'),
(15, 'XFX Speedster SWFT 210 Core', '//cdna.pcpartpicker.com/static/forever/images/product/286555a12154c13311feaf62beab4ee9.256p.jpg', 'https://pcpartpicker.com/product/NDvdnQ/xfx-radeon-rx-6650-xt-8-gb-speedster-swft-210-core-video-card-rx-665x8dfdy', '$219.99 ', 'XFX', 3, 1.1, 'Radeon RX 6650 XT', '8 GB', '2055 MHz', 'FreeSync'),
(16, 'Asus TUF GAMING', '//cdna.pcpartpicker.com/static/forever/images/product/4aea17ad419ee3bf159a407dc643aa80.256p.jpg', 'https://pcpartpicker.com/product/kppQzy/asus-tuf-gaming-geforce-rtx-4080-super-16-gb-video-card-tuf-rtx4080s-16g-gaming', '$999.99 ', 'Asus', 31, 1.4, 'GeForce RTX 4080 SUPER', '16 GB', '2210 MHz', 'G-Sync'),
(17, 'Gigabyte EAGLE', '//cdna.pcpartpicker.com/static/forever/images/product/232dd1c4ff3c7494fae18e5e99c878ce.256p.jpg', 'https://pcpartpicker.com/product/G9ytt6/gigabyte-radeon-rx-6600-8-gb-eagle-video-card-gv-r66eagle-8gd', '$199.99 ', 'Gigabyte', 48, 3.6, 'Radeon RX 6600', '8 GB', '1626 MHz', 'FreeSync');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `email`, `username`, `password`, `role`) VALUES
(1, 'Olivier', 'Bourgault', 'bourgault.olivier8501@gmail.com', 'RinoShip77', '$2b$20$A5I8VB1tDZFxLk6U4aEVhuN4yawwj4rRHL2lDRn7Qdlggf7OaO42a', 'admin'),
(2, 'John', 'Doe', 'johndoe@gmail.com', 'johndoe46', '$2b$13$rDeyo0POfBmXwI251wHyp.cDtgqQINaCftP7PCQ/EOCTcm5Q9Z0m2', 'user');

-- --------------------------------------------------------

--
-- Structure de la table `video_cards`
--

DROP TABLE IF EXISTS `video_cards`;
CREATE TABLE IF NOT EXISTS `video_cards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(130) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `imageURL` varchar(99) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `productURL` varchar(179) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `price` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `manufacturer` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantityInStock` int DEFAULT '0',
  `rating` float DEFAULT NULL,
  `chipset` varchar(27) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `memory` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `clock` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `frameSync` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COMMENT='productsTable';

--
-- Déchargement des données de la table `video_cards`
--

INSERT INTO `video_cards` (`id`, `name`, `imageURL`, `productURL`, `price`, `manufacturer`, `quantityInStock`, `rating`, `chipset`, `memory`, `clock`, `frameSync`) VALUES
(1, 'MSI GeForce RTX 3060 Ventus 2X 12G', '//cdna.pcpartpicker.com/static/forever/images/product/dbc81b89efc82ce66fb2e3ab7e0f0658.256p.jpg', 'https://pcpartpicker.com/product/pD8bt6/msi-geforce-rtx-3060-ventus-2x-12g-geforce-rtx-3060-12gb-12-gb-video-card-rtx3060ventus2x12goc', '$289.00 ', 'MSI', 12, 2.3, 'GeForce RTX 3060 12GB', '12 GB', '1320 MHz', 'G-Sync'),
(2, 'Gigabyte WINDFORCE OC', '//cdna.pcpartpicker.com/static/forever/images/product/772cce097c55469671a0d75ea4aca83a.256p.jpg', 'https://pcpartpicker.com/product/FnLdnQ/gigabyte-windforce-oc-geforce-rtx-4070-12-gb-video-card-gv-n4070wf3oc-12gd', '$581.19 ', 'Gigabyte', 31, 4, 'GeForce RTX 4070', '12 GB', '1920 MHz', 'G-Sync'),
(3, 'Asus ROG STRIX GAMING OC', '//cdna.pcpartpicker.com/static/forever/images/product/9f7b45a2816c45ea9449e8ca2bf6f616.256p.jpg', 'https://pcpartpicker.com/product/ZKWzK8/asus-rog-strix-gaming-oc-geforce-rtx-4090-24-gb-video-card-rog-strix-rtx4090-o24g-gaming', '$1,979.99 ', 'Asus', 19, 3.2, 'GeForce RTX 4090', '24 GB', '2235 MHz', 'G-Sync'),
(4, 'Gigabyte WINDFORCE OC', '//cdna.pcpartpicker.com/static/forever/images/product/6b90f36fbe6c1408ac40ab85c762807c.256p.jpg', 'https://pcpartpicker.com/product/KvcgXL/gigabyte-windforce-oc-geforce-rtx-4070-ti-super-16-gb-video-card-gv-n407tswf3oc-16gd', '$799.99 ', 'Gigabyte', 4, 4.1, 'GeForce RTX 4070 Ti SUPER', '16 GB', '2340 MHz', 'G-Sync'),
(5, 'Asus DUAL OC', '//cdna.pcpartpicker.com/static/forever/images/product/b836633d335617f71eb7b4e5f0ba43b7.256p.jpg', 'https://pcpartpicker.com/product/X7CZxr/asus-dual-oc-geforce-rtx-4060-8-gb-video-card-dual-rtx4060-o8g', '$309.99 ', 'Asus', 10, 0.8, 'GeForce RTX 4060', '8 GB', '1830 MHz', 'G-Sync'),
(6, 'Gigabyte GAMING OC', '//cdna.pcpartpicker.com/static/forever/images/product/7760e2607e7488a74486e8de8d3162b5.256p.jpg', 'https://pcpartpicker.com/product/mHpQzy/gigabyte-gaming-oc-radeon-rx-7800-xt-16-gb-video-card-gv-r78xtgaming-oc-16gd', '$499.00 ', 'Gigabyte', 42, 1.6, 'Radeon RX 7800 XT', '16 GB', '1295 MHz', 'FreeSync'),
(7, 'Gigabyte WINDFORCE OC', '//cdna.pcpartpicker.com/static/forever/images/product/c17472cd578b7847c10089750b161a2f.256p.jpg', 'https://pcpartpicker.com/product/HCkH99/gigabyte-windforce-oc-geforce-rtx-4070-super-12-gb-video-card-gv-n407swf3oc-12gd', '$599.99 ', 'Gigabyte', 30, 0.8, 'GeForce RTX 4070 SUPER', '12 GB', '1980 MHz', 'G-Sync'),
(8, 'ASRock Challenger D', '//cdna.pcpartpicker.com/static/forever/images/product/c5489241c902a9ae06a42212e978f989.256p.jpg', 'https://pcpartpicker.com/product/D9ytt6/asrock-radeon-rx-6600-8-gb-challenger-d-video-card-rx6600-cld-8g', '$189.99 ', 'ASRock', 23, 4, 'Radeon RX 6600', '8 GB', '1626 MHz', 'FreeSync'),
(9, 'PNY VCNRTX6000ADA-PB', '//cdna.pcpartpicker.com/static/forever/images/product/6ef5b8f1b94982c71019a0d9ac2795e2.256p.jpg', 'https://pcpartpicker.com/product/82bRsY/pny-vcnrtx6000ada-pb-rtx-6000-ada-generation-48-gb-video-card-vcnrtx6000ada-pb', '$9,999.00 ', 'PNY', 27, 2.7, 'RTX 6000 Ada Generation', '48 GB', '915 MHz', 'None'),
(10, 'XFX Speedster SWFT 309', 'https://m.media-amazon.com/images/I/41Gcn+794SS.jpg', 'https://pcpartpicker.com/product/RFGbt6/xfx-radeon-rx-6700-xt-12-gb-speedster-swft-309-video-card-rx-67xtyjfdv', '$299.99 ', 'XFX', 17, 1.7, 'Radeon RX 6700 XT', '12 GB', '2321 MHz', 'FreeSync'),
(11, 'NVIDIA Founders Edition', '//cdna.pcpartpicker.com/static/forever/images/product/07ff8dc03a65e34edc811c97d838af9a.256p.jpg', 'https://pcpartpicker.com/product/BCGbt6/nvidia-founders-edition-geforce-rtx-4090-24-gb-video-card-900-1g136-2530-000', '$1,972.99 ', 'NVIDIA', 5, 0.2, 'GeForce RTX 4090', '24 GB', '2230 MHz', 'G-Sync'),
(12, 'Gigabyte EAGLE', '//cdna.pcpartpicker.com/static/forever/images/product/80f174eea93a4a0981c63721c9a9805d.256p.jpg', 'https://pcpartpicker.com/product/j89wrH/gigabyte-eagle-geforce-rtx-4060-ti-8-gb-video-card-gv-n406teagle-8gd', '$390.99 ', 'Gigabyte', 23, 0.8, 'GeForce RTX 4060 Ti', '8 GB', '2310 MHz', 'G-Sync'),
(13, 'Asus ROG STRIX GAMING OC', '//cdna.pcpartpicker.com/static/forever/images/product/2aab4ec16f5be8f6d95d1e5848c2d9be.256p.jpg', 'https://pcpartpicker.com/product/V8hFf7/asus-rog-strix-gaming-oc-geforce-rtx-4090-24-gb-video-card-rog-strix-rtx4090-o24g-white', '$2,029.00 ', 'Asus', 0, 3.4, 'GeForce RTX 4090', '24 GB', '2235 MHz', 'G-Sync'),
(14, 'Gigabyte AERO OC', '//cdna.pcpartpicker.com/static/forever/images/product/13a70d0303a8922898892321f6b35104.256p.jpg', 'https://pcpartpicker.com/product/xh3NnQ/gigabyte-aero-oc-geforce-rtx-4060-8-gb-video-card-gv-n4060aero-oc-8gd', '$319.99 ', 'Gigabyte', 32, 4.8, 'GeForce RTX 4060', '8 GB', '1830 MHz', 'G-Sync'),
(15, 'XFX Speedster SWFT 210 Core', '//cdna.pcpartpicker.com/static/forever/images/product/286555a12154c13311feaf62beab4ee9.256p.jpg', 'https://pcpartpicker.com/product/NDvdnQ/xfx-radeon-rx-6650-xt-8-gb-speedster-swft-210-core-video-card-rx-665x8dfdy', '$219.99 ', 'XFX', 11, 3.8, 'Radeon RX 6650 XT', '8 GB', '2055 MHz', 'FreeSync'),
(16, 'Asus TUF GAMING', '//cdna.pcpartpicker.com/static/forever/images/product/4aea17ad419ee3bf159a407dc643aa80.256p.jpg', 'https://pcpartpicker.com/product/kppQzy/asus-tuf-gaming-geforce-rtx-4080-super-16-gb-video-card-tuf-rtx4080s-16g-gaming', '$999.99 ', 'Asus', 8, 4.4, 'GeForce RTX 4080 SUPER', '16 GB', '2210 MHz', 'G-Sync'),
(17, 'Gigabyte EAGLE', '//cdna.pcpartpicker.com/static/forever/images/product/232dd1c4ff3c7494fae18e5e99c878ce.256p.jpg', 'https://pcpartpicker.com/product/G9ytt6/gigabyte-radeon-rx-6600-8-gb-eagle-video-card-gv-r66eagle-8gd', '$199.99 ', 'Gigabyte', 10, 0.7, 'Radeon RX 6600', '8 GB', '1626 MHz', 'FreeSync'),
(18, 'XFX Speedster MERC 310 Black Edition', 'https://m.media-amazon.com/images/I/41KTQkxkKHL.jpg', 'https://pcpartpicker.com/product/GtXJ7P/xfx-speedster-merc-310-black-edition-radeon-rx-7900-xtx-24-gb-video-card-rx-79xmercb9', '$926.77 ', 'XFX', 24, 0.3, 'Radeon RX 7900 XTX', '24 GB', '2300 MHz', 'FreeSync'),
(19, 'Asus DUAL OC', '//cdna.pcpartpicker.com/static/forever/images/product/893108b2bc445db992e277a36594ff07.256p.jpg', 'https://pcpartpicker.com/product/Hc7scf/asus-dual-oc-geforce-rtx-4070-super-12-gb-video-card-dual-rtx4070s-o12g', '$609.00 ', 'Asus', 43, 4.5, 'GeForce RTX 4070 SUPER', '12 GB', '1980 MHz', 'G-Sync'),
(20, 'Gigabyte GAMING OC', '//cdna.pcpartpicker.com/static/forever/images/product/4255608ed3c98ddaaf0dc26bc7d2c982.256p.jpg', 'https://pcpartpicker.com/product/VTFmP6/gigabyte-gaming-oc-radeon-rx-7700-xt-12-gb-video-card-gv-r77xtgaming-oc-12gd', '$409.99 ', 'Gigabyte', 43, 1.3, 'Radeon RX 7700 XT', '12 GB', '1700 MHz', 'FreeSync'),
(21, 'XFX GTS XXX', '//cdna.pcpartpicker.com/static/forever/images/product/7a8d66854d65f497aca573e84772d861.256p.jpg', 'https://pcpartpicker.com/product/MsWfrH/xfx-gts-xxx-radeon-rx-580-8-gb-video-card-rx-580p8dfd6', '$129.99 ', 'XFX', 36, 3.4, 'Radeon RX 580', '8 GB', '1366 MHz', 'FreeSync'),
(22, 'XFX Speedster SWFT 319', 'https://m.media-amazon.com/images/I/41aCdMMAvYL.jpg', 'https://pcpartpicker.com/product/Hg92FT/xfx-radeon-rx-6800-16-gb-speedster-swft-319-video-card-rx-68xlaqfd9', '$369.99 ', 'XFX', 1, 2.8, 'Radeon RX 6800', '16 GB', '1700 MHz', 'FreeSync'),
(23, 'MSI VENTUS 2X BLACK OC', '//cdna.pcpartpicker.com/static/forever/images/product/c89cc9ea2051206aebd4189ddf05f76b.256p.jpg', 'https://pcpartpicker.com/product/7s88TW/msi-ventus-2x-black-oc-geforce-rtx-4060-8-gb-video-card-rtx-4060-ventus-2x-black-8g-oc', '$293.00 ', 'MSI', 47, 3.8, 'GeForce RTX 4060', '8 GB', '1830 MHz', 'G-Sync'),
(24, 'Gigabyte WINDFORCE OC', '//cdna.pcpartpicker.com/static/forever/images/product/1e3e35590c40b7b20e6910ecea2ae02a.256p.jpg', 'https://pcpartpicker.com/product/r9cgXL/gigabyte-windforce-oc-geforce-rtx-4060-8-gb-video-card-gv-n4060wf2oc-8gd', '$299.99 ', 'Gigabyte', 33, 0.7, 'GeForce RTX 4060', '8 GB', '1830 MHz', 'G-Sync'),
(25, 'Sapphire PULSE', '//cdna.pcpartpicker.com/static/forever/images/product/d8c578ddd6b41bcf2b3467084f13e2b2.256p.jpg', 'https://pcpartpicker.com/product/3BQcCJ/sapphire-pulse-radeon-rx-7900-xt-20-gb-video-card-11323-02-20g', '$689.99 ', 'Sapphire', 24, 2.1, 'Radeon RX 7900 XT', '20 GB', '2000 MHz', 'FreeSync');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
