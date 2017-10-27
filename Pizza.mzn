%Pizza problem

% A voucher is  a pair (a,b) where you pay for a pizzas and you can obtain for free
% b pizzas as long as they each cost no more than the cheapest of the 2 pizzas
% you paid for.

%goal: obrain all the ordered pizzas for the least possible cost. Not all vouchers
% need to be used, and a voucher does not need to be totally used


%input variables from data file
int: n;   %number of pizzas to obtain
set of int: Pizzas = 1 .. n;
array[Pizzas] of int: price;  % price is array of n pizza prices
int: m;   %number of pizza vouchers

array[Vouchers] of int: buy; %match position for voucher
array[Vouchers] of int: free;

set of int: Vouchers = 1..m;

array[Vouchers,Pizzas] of var bool: Apply;
array[Vouchers,Pizzas] of var bool: Justify;

var set of Pizzas: Pay;
var set of Vouchers: V; 

%set of applied vouchers
%array[Pizzas] of var bool: Pay;
%array[Vouchers] of var bool: V;

%final sum
var int: cost = sum (i in Pizzas) (bool2int(i in Pay) * price[i]);


%%constraints


% 1. pay for exactly the pizzas that we don't get by applying the vouchers
constraint forall(p in Pizzas)((p in Pay) <-> not exists(v in V)(Apply[v,p]));

% 2. V is the set of applied vouchers
constraint forall(v in Vouchers)((v in V) <-> exists(p in Pizzas)(Apply[v,p]));

% 3. Any voucher that is apploed must be Justified by sufficiently many purchased pizzas
constraint forall(v in Vouchers) ((v in V) -> sum(p in Pizzas)(bool2int(Justify[v,p] )) >=buy[v]);

%9. Any pizza used to justify a voucher can only be used once
constraint forall(v in Vouchers) (
  forall(p in Pizzas)
    (Justify[v,p] -> not exists(w in Vouchers where v != w)(Justify[w,p])
));

% 4.The number of pizzas any voucher is applied to is not too large
constraint forall(v in Vouchers)((v in V) -> (sum(p in Pizzas)(bool2int(Apply[v,p])) <= free[v]));

% 5. Each free pizza costs at most as much as the cheapest pizza used to justify the application of the relevant voucher
constraint
  forall(v in Vouchers) (
      forall (p,q in Pizzas where p !=q) (
                ((Apply[v,p] /\ Justify[v,q]) -> (price[p] <= price[q])) 
                ));
                
% 6. We pay for every pizza used to justify applying a voucher
constraint forall (p in Pizzas)(
    forall(v in Vouchers) (
        Justify[v,p] -> (p in Pay)));

% 7. The total cost is not too large (total of all pizzas)
constraint cost <= sum(p in Pizzas)(price[p]);

% 8. Require that J(v,p) and A(v,p) hold only pairs consisting of a voucher and a pizza. (For example, if there are 3 
%    vouchers but 5 pizzas, we would not want J(5,5) to hold, as here is no voucher 5)
constraint forall(v in Vouchers) (
    forall(p in Pizzas) (
      (Justify[v,p]) -> (
         ((1 <= v ) /\ (v<=m)) /\ ((1 <= p) /\ (p<=n)))
    ));
    
constraint forall(v in Vouchers) (
    forall(p in Pizzas) (
      (Apply[v,p]) -> (
         ((1 <= v ) /\ (v<=m)) /\ ((1 <= p) /\ (p<=n)))
    ));  
   

solve minimize cost;
output ["cost(" ++ show(cost) ++ ")\n"
    ++ "Pay: " ++ show(Pay)
    ++ "\nV" ++ show(V) ++"\n"
    ++"Vouchers" ++ show(Vouchers) ++ "\n"]%figure out output for pizzas
    ++ ["\nApply\n"] ++
    [show(bool2int(Apply[v,p])) ++ " " ++
      if p mod n == 0 then "\n" else "" endif 
      | v in Vouchers, p in Pizzas ]
      ++ ["\nJustify\n"] ++
      [show(bool2int(Justify[v,p])) ++ " " ++
      if p mod n == 0 then "\n" else "" endif
      | v in Vouchers, p in Pizzas];