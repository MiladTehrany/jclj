/*ALTER TABLE employees MODIFY COLUMN employeeNumber INT NOT NULL AUTO_INCREMENT;
ALTER TABLE orders MODIFY COLUMN orderNumber INT NOT NULL AUTO_INCREMENT;
ALTER TABLE productlines MODIFY htmlDescription mediumtext CHARACTER SET utf8mb4;*/


CREATE TABLE customers
(
    customerNumber         number(10)   NOT NULL,
    customerName           varchar2(50) NOT NULL,
    contactLastName        varchar2(50) NOT NULL,
    contactFirstName       varchar2(50) NOT NULL,
    phone                  varchar2(50) NOT NULL,
    addressLine1           varchar2(50) NOT NULL,
    addressLine2           varchar2(50)  DEFAULT NULL,
    city                   varchar2(50) NOT NULL,
    state                  varchar2(50)  DEFAULT NULL,
    postalCode             varchar2(15)  DEFAULT NULL,
    country                varchar2(50) NOT NULL,
    salesRepEmployeeNumber number(10)    DEFAULT NULL,
    creditLimit            number(10, 2) DEFAULT NULL,
    PRIMARY KEY (customerNumber)
);

CREATE INDEX salesRepEmployeeNumber ON customers (salesRepEmployeeNumber);


CREATE TABLE employees
(
    employeeNumber number(10)    NOT NULL,
    lastName       varchar2(50)  NOT NULL,
    firstName      varchar2(50)  NOT NULL,
    extension      varchar2(10)  NOT NULL,
    email          varchar2(100) NOT NULL,
    officeCode     varchar2(10)  NOT NULL,
    reportsTo      number(10) DEFAULT NULL,
    jobTitle       varchar2(50)  NOT NULL,
    PRIMARY KEY (employeeNumber)
);

CREATE INDEX reportsTo ON employees (reportsTo);
CREATE INDEX officeCode ON employees (officeCode);

CREATE TABLE offices
(
    officeCode   varchar2(10) NOT NULL,
    city         varchar2(50) NOT NULL,
    phone        varchar2(50) NOT NULL,
    addressLine1 varchar2(50) NOT NULL,
    addressLine2 varchar2(50) DEFAULT NULL,
    state        varchar2(50) DEFAULT NULL,
    country      varchar2(50) NOT NULL,
    postalCode   varchar2(15) NOT NULL,
    territory    varchar2(10) NOT NULL,
    PRIMARY KEY (officeCode)
);

CREATE TABLE orderdetails
(
    orderNumber     number(10)    NOT NULL,
    productCode     varchar2(15)  NOT NULL,
    quantityOrdered number(10)    NOT NULL,
    priceEach       number(10, 2) NOT NULL,
    orderLineNumber number(5)     NOT NULL,
    PRIMARY KEY (orderNumber, productCode)
);

CREATE INDEX productCode ON orderdetails (productCode);

CREATE TABLE orders
(
    orderNumber    number(10)   NOT NULL,
    orderDate      date         NOT NULL,
    requiredDate   date         NOT NULL,
    shippedDate    date DEFAULT NULL,
    status         varchar2(15) NOT NULL,
    comments       clob,
    customerNumber number(10)   NOT NULL,
    PRIMARY KEY (orderNumber)
);

CREATE INDEX customerNumber ON orders (customerNumber);

CREATE TABLE payments
(
    customerNumber number(10)    NOT NULL,
    checkNumber    varchar2(50)  NOT NULL,
    paymentDate    date          NOT NULL,
    amount         number(10, 2) NOT NULL,
    PRIMARY KEY (customerNumber, checkNumber)
);

CREATE TABLE productlines
(
    productLine     varchar2(50) NOT NULL,
    textDescription varchar2(4000) DEFAULT NULL,
    htmlDescription clob,
    image           blob,
    PRIMARY KEY (productLine)
);

CREATE TABLE products
(
    productCode        varchar2(15)  NOT NULL,
    productName        varchar2(70)  NOT NULL,
    productLine        varchar2(50)  NOT NULL,
    productScale       varchar2(10)  NOT NULL,
    productVendor      varchar2(50)  NOT NULL,
    productDescription clob          NOT NULL,
    quantityInStock    number(5)     NOT NULL,
    buyPrice           number(10, 2) NOT NULL,
    MSRP               number(10, 2) NOT NULL,
    PRIMARY KEY (productCode)
);

CREATE INDEX productLine ON products (productLine);


ALTER TABLE customers
    ADD CONSTRAINT customers_ibfk_1 FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber);

ALTER TABLE employees
    ADD CONSTRAINT employees_ibfk_1 FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber);
ALTER TABLE employees
    ADD CONSTRAINT employees_ibfk_2 FOREIGN KEY (officeCode) REFERENCES offices (officeCode);

ALTER TABLE orderdetails
    ADD CONSTRAINT orderdetails_ibfk_1 FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber);
ALTER TABLE orderdetails
    ADD CONSTRAINT orderdetails_ibfk_2 FOREIGN KEY (productCode) REFERENCES products (productCode);

ALTER TABLE orders
    ADD CONSTRAINT orders_ibfk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber);

ALTER TABLE payments
    ADD CONSTRAINT payments_ibfk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber);

ALTER TABLE products
    ADD CONSTRAINT products_ibfk_1 FOREIGN KEY (productLine) REFERENCES productlines (productLine);


CREATE SEQUENCE employees_seq;
CREATE SEQUENCE orders_seq;


CREATE OR REPLACE TRIGGER employees_on_insert
    BEFORE INSERT
    ON employees
    FOR EACH ROW
BEGIN
    SELECT employees_seq.nextval
    INTO :new.employeeNumber
    FROM dual;
END;


CREATE OR REPLACE TRIGGER orders_on_insert
    BEFORE INSERT
    ON orders
    FOR EACH ROW
BEGIN
    SELECT orders_seq.nextval
    INTO :new.orderNumber
    FROM dual;
END;


insert into OFFICES (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
values (1, 'Init', '+989126645934', 'Tehran', NULL, '2', 'Iran', '3761345156', 'Root');

insert into employees (employeeNumber, lastName, firstName, extension, email, officeCode, jobTitle)
values (employees_seq.nextval, 'Murphy', 'Diane', 'x5800', 'dmurphy@classicmodelcars.com', '1', 'President');

insert into customers(customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode,
                      country, salesRepEmployeeNumber, creditLimit)
values (1, 'Atelier graphique', 'Schmitt', 'Carine ', '40.32.2555', '54, rue Royale', NULL, 'Nantes', NULL, '44000', 'France',
        4, '21000.00');

insert into payments (customerNumber, checkNumber, paymentDate, amount)
values (1, 1, SYSDATE, 6066.78);

insert into orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
values (orders_seq.nextval, sysdate, sysdate, sysdate, 'Shipped', NULL, 1);

insert into productlines (productLine, htmlDescription, image)
values (1, 'Classic Cars',
        utl_raw.cast_to_raw ('Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb attention to detail and craftsmanship and offer features such as working steering system, opening forward compartment, opening rear trunk with removable spare wheel, 4-wheel independent spring suspension, and so on. The models range in size from 1:10 to 1:24 scale and include numerous limited edition and several out-of-production vehicles. All models include a certificate of authenticity from their manufacturers and come fully assembled and ready for display in the home or office.'));

insert into products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
values ('S10_1678','1969 Harley Davidson Ultimate Chopper','Motorcycles','1:10','Min Lin Diecast','This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.',7933,'48.81','95.70');

insert into orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
values (4,'S10_1678',30,'136.00',3);









