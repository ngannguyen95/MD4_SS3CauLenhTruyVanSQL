create database QuanLyBanHang;
use QuanLyBanHang;
create table customer(
customerId int auto_increment primary key,
customerName varchar(255),
customerAge int
);
create table `order`(
orderId int auto_increment primary key,
customerId int,
foreign key (customerId) references customer(customerId),
orderDate datetime default now(),
orderTotalPrice float
);
create table product(
productId int auto_increment primary key,
productName varchar(255),
productprice float
);
create table orderDetail(
orderId int,
foreign key(orderId) references `order`(orderId),
productId int,
foreign key(productId) references product(productId),
orderQTY int
);
insert into customer(customerName,customerAge) values
("Minh Quan",10),("Ngoc Oanh",20),("Hong Ha",50);
insert into `order` (customerId,orderDate,orderTotalPrice) values
(1,"2006-3-21",null),(2,"2006-3-23",null),(1,"2006-3-16",null);
insert into product(productName,productprice) values
("may giat",3),("tu lanh",5),("dieu hoa",7),("quat",1),("bep dien",2);
insert into orderDetail(orderId,productId,orderQTY) values
(1,1,3),(1,3,7),(1,4,2),(2,1,1),(3,1,8),(2,5,4),(2,3,3);
-- 	Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select o.orderId,o.orderDate,o.orderTotalPrice from `order` o; 
-- 	Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select c.customerName,p.productName
from 
orderdetail o join product p on o.productId=p.productId
join  `order` od on od.orderId = o.orderId
join customer c on c. c.customerName=od.customerId;
-- 	Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select c.customerName
from customer c 
where c.customerId not in (select customerId from `order`);
-- 	Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn.
-- Giá bán của từng loại được tính = odQTY*pPrice)
select od.orderId, o.orderDate, sum(od.orderQTY*p.productprice) as "Thành tiền"
from 
orderdetail od join product p on  od.productId= p.productId
join `order` o on o.orderId= od.orderId
group by  o.orderId;
 
