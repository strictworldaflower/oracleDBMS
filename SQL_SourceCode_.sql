//논리적 모델에서 물리적 모델 변환
//sql로 변환하자



CREATE TABLE NewBook
(
	bookid               NUMBER NOT NULL ,
	bookname             VARCHAR2(40) NULL ,
	price                NUMBER NULL ,
	pubname              VARCHAR2(40) NOT NULL 
);



CREATE UNIQUE INDEX XPK도서 ON NewBook
(bookid   ASC);



CREATE TABLE NewCustomer
(
	name                 NUMBER NOT NULL ,
	custid               VARCHAR2(40) NULL ,
	address              VARCHAR2(40) NULL ,
	phone                NUMBER NULL 
);



CREATE UNIQUE INDEX XPK고객 ON NewCustomer
(name   ASC);



CREATE TABLE NewOrder
(
	orderid              NUMBER NOT NULL ,
	name                 NUMBER NOT NULL ,
	bookid               NUMBER NOT NULL ,
	orderdate            NUMBER NULL ,
	saleprice            NUMBER NULL 
);



CREATE UNIQUE INDEX XPK주문 ON NewOrder
(orderid   ASC);



CREATE TABLE NewPublisher
(
	pubname              VARCHAR2(40) NOT NULL ,
	stname               VARCHAR2(40) NULL ,
	officephone          NUMBER NULL 
);



CREATE UNIQUE INDEX XPK출판사 ON NewPublisher
(pubname   ASC);


