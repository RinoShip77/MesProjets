CREATE TABLE categories (
    idCategory INT AUTO_INCREMENT NOT NULL,
    categoryName VARCHAR(50) NOT NULL,
    PRIMARY KEY(idCategory)
) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB;
CREATE TABLE products (
    idProduct INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL,
    price DOUBLE PRECISION NOT NULL,
    quantityInStock INT NOT NULL,
    description VARCHAR(1024) NOT NULL,
    imagePath VARCHAR(255) NOT NULL,
    idCategory INT NOT NULL,
    INDEX IDX_B3BA5A5A55EF339A (idCategory),
    PRIMARY KEY(idProduct)
) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB;
CREATE TABLE users (
    idUser INT AUTO_INCREMENT NOT NULL,
    email VARCHAR(180) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(120) NOT NULL,
    city VARCHAR(50) NOT NULL,
    postalCode VARCHAR(7) NOT NULL,
    province VARCHAR(2) NOT NULL,
    phoneNumber VARCHAR(12) DEFAULT NULL,
    roles LONGTEXT NOT NULL COMMENT '(DC2Type:json)',
    UNIQUE INDEX UNIQ_1483A5E9E7927C74 (email),
    PRIMARY KEY(idUser)
) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB;
CREATE TABLE messenger_messages (
    id BIGINT AUTO_INCREMENT NOT NULL,
    body LONGTEXT NOT NULL,
    headers LONGTEXT NOT NULL,
    queue_name VARCHAR(190) NOT NULL,
    created_at DATETIME NOT NULL,
    available_at DATETIME NOT NULL,
    delivered_at DATETIME DEFAULT NULL,
    INDEX IDX_75EA56E0FB7336F0 (queue_name),
    INDEX IDX_75EA56E0E3BD61CE (available_at),
    INDEX IDX_75EA56E016BA31DB (delivered_at),
    PRIMARY KEY(id)
) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB;
ALTER TABLE products
ADD CONSTRAINT FK_B3BA5A5A55EF339A FOREIGN KEY (idCategory) REFERENCES categories (idCategory);