create database library;
use library;
create table Branch_(branch_no int primary key,
manager_id int,branch_address varchar(50),contact_no varchar(20));

create table employee(employee_id int primary key,emp_name varchar(30),
position varchar(30),salary decimal(10,2));

create table customer(customer_id int primary key,customer_name varchar(30),
customer_address varchar(50),reg_date date);

create table issuestatus(issue_id int primary key,
issued_customer int,issued_book_name varchar(30),issue_date date,
isbn_book varchar(30),foreign key(issued_customer) References customer(customer_id),
foreign key (isbn_book) references books (isbn));

create table books(isbn varchar(30) primary key,
book_title varchar(20),category varchar(30),rental_price decimal(10,2),
status enum('yes','no'),author varchar(30),publisher varchar(20));

create table returnstatus(return_id int primary key,
return_customer int,return_book_name varchar(30),return_date date,
isbn_book2 varchar(30),foreign key(return_customer) References customer(customer_id),
foreign key (isbn_book2) references books (isbn));


insert into branch_(branch_no ,manager_id ,branch_address ,contact_no)
values(1,100,'mumbai north',9234567667),
(2,101,'mumbai south',9234567227),(3,102,'mumbai east',9634567897),
(4,103,'mumbai west',9454567634),(5,104,'mumbai north',9645682056);
insert into branch_(branch_no ,manager_id ,branch_address ,contact_no)values
(6,104,'mumbai north',9645682056),
(7,104,'mumbai north',9645682056);


insert into employee(employee_id,emp_name,position,salary)
values
(1,'bhaskar','librarian1',25000),(2,'geetha','librarian2',25000),
(3,'tony','librarian3',25000),(4,'richard','Asst.manager',30000),
(5,'lalvarma','manager',35000);

insert into customer(customer_id,customer_name,customer_address,reg_date)
values
(1001,'Ahmed','street243 mumbai east','2020-02-05'),(1002,'sidharth','street246 mumbai east','2021-02-25'),
(1003,'Simon','street2 mumbai north','2022-02-15'),(1004,'Lalitha','street26 mumbai north','2023-05-29'),
(1005,'Deepthi Sharma','street1 mumbai south','2021-03-01');

insert into  issuestatus(issue_id,issued_customer,issued_book_name,issue_date,isbn_book)
values
(1,1001,'rich dad poor dad','2020-03-20','isbn-1'),(2,1002,'wings of fire','2020-04-10','isbn-2'),
(3,1003,'inheritance of loss','2020-01-06','isbn-3'),(4,1004,'Arachaar','2022-06-01','isbn-4'),
(5,1001,'The alchemist','2019-04-01','isbn-5');

insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values
('isbn-1','rich dad poor dad','Business',50.00,'yes','Robert t kiyosaki','plata'),
('isbn-2','wings of fire','Autobiography',50.00,'yes','Abdul kalam','Bookseller'),
('isbn-3','inheritance of loss','Fiction',50.00,'yes','Kiran desai','Groove'),
('isbn-4','Arachaar','Fiction',50.00,'yes','Kr meera','Dc books'),
('isbn-5','The alchemist','Motivation',50.00,'yes','paulo coelho','Book seller');

insert into returnstatus(return_id,return_customer,return_book_name,return_date,isbn_book2)
values
(1,1001,'rich dad poor dad','2023-03-26','isbn-1'),(2,1002,'wings of fire','2023-04-23','isbn-2'),
(3,1003,'inheritance of loss','2023-02-06','isbn-3'),(4,1004,'Arachaar','2023-07-11','isbn-4'),
(5,1001,'The alchemist','2023-04-21','isbn-5');


select * from returnSTATUS;

#retrive the book title,category and rental price of all availiable books
select book_title,category,rental_price from books; 

#list of the employee names and thier respective salaries in descending order
select emp_name,salary from employee order by salary desc;

#retrive the booktitle and the corresponding customer who have issued that book
select issuestatus.issued_book_name,customer.customer_name
from issuestatus join customer
on issuestatus.issued_customer=customer.customer_id;

#display the total count of book in each category
select category,count(category) from books group by category;

#retrive the employee name thier position for the employees where salary greater than 25000
select emp_name,position from employee where salary>25000;

#lists the customer name who registered before 2022_-01-01 and not issued any books yet
select customer_name from customer where reg_date<'2022-01-01' and
customer_id not in(select issued_customer from issuestatus);

#display the branch number and the total count of employee in each branch
select branch.branch_no,count(*) as employee_count
from branch join employee 
on branch.manager_id=employee.employee_id
group  by branch.branch_no;

#display the names of customer who have issued books in month of june 2022
select customer.customer_name from
customer join issuestatus
on customer.customer_id=issuestatus.issued_customer
where issuestatus.issue_date >='2022-06-01'and issuestatus.issue_date <= '2022-06-30';

#retrive book title from book table containing autobiography
select book_title from books where book_title like '%wings%';

#retrive the branch number along with the count of employees for branches having more than 5 employees
select branch.branch_no,count(*) as emplyee_count
 from branch
 join employee on branch.manager_id=employee.employee_id
 group by branch.branch_no
 having count(employee_id)>=5;

