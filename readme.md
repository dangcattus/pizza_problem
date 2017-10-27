# Pizza Problem Solver

Pizza Problem Solver is written in MiniZinc for Simon Fraser University's Intelligent Systems Course
## Pizza Generator

Pizza Generator generates random input files in order to test the MiniZinc Program.

### To build PizzaGenerator
Run
```
make
```
from the command line.

### To run pizza generator from the command line:
```
./pizzagen <numfiles> <n> <m>
```
where numfiles is the number of output files you would like, n is the number of pizzas and m is the number of vouchers.

Files will be output to Data/ in MiniZinc format.


## Constraints

Constraints and the MiniZinc solver are found in the Pizza.mzn file.
The constraints are as follows:
1. Pay for exactly the pizzas that we don't get by applying the vouchers
2. V is the set of applied vouchers
3. Any voucher that is applied must be Justified by sufficiently many purchased pizzas
4. The number of pizzas any voucher is applied to is not too large
5. Each free pizza costs at most as much as the cheapest pizza used to justify the application of the relevant voucher
6. We pay for every pizza used to justify applying a voucher
7. The total cost is not too large (total of all pizzas)
8. Require that J(v,p) and A(v,p) hold only pairs consisting of a voucher and a pizza. (For example, if there are 3 vouchers but 5 pizzas, we would not want J(5,5) to hold, as here is no voucher 5)
9. Any pizza used to justify a voucher can only be used once


## Pizza Problem
The following is the problem presented in the Intelligent Systems CMPT 417 course at Simon Fraser University.

### Problem
The problem arises in the University College Cork student dorms. There is a large order of pizzas for a party, and many of the students have vouchers for acquiring discounts in purchasing pizzas. A voucher is a pair of numbers e.g. (2,4), which means if you pay for 2 pizzas then you can obtain for free up to 4 pizzas as long as they each cost no more than the cheapest of the 2 pizzas you paid for. Similarly a voucher (3,2) means that if you pay for 3 pizzas you can get up to 2 pizzas for free as long as they each cost no more than the cheapest of the 3 pizzas you paid for. The aim is to obtain all the ordered pizzas for the least possible cost. Note that not all vouchers need to be used, and a voucher does not need to be totally used.

### Input Formats
An input file for LP systems contains the following facts:
One fact of the form n_pizzas(N), which specifies the number of pizzas to obtain.
For each I in 1..N, there is a fact of the form pizza(I,C), which gives the price C of pizza I.
One fact of the form n_vouchers(M), which gives the number of vouchers M.
For each I in 1..M, there is a fact of the form voucher(I,B,F), which indicates that with voucher I one can get F free pizzas when buying B pizzas.
An input file for MiniZinc defines the following constants:
n = number of pizzas to obtain;
price = list of n pizza prices;
m = number of vouchers;
Two lists of size m named buy and free, which specify the vouchers. For i in 1..m, one can get free[i] free pizzas when buying buy[i] pizzas.

### Output format
The output should contain exactly one fact of the form cost(K), where K is the minimum cost required to obtain the pizzas.
