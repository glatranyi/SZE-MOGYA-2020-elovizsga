set ProductGroups;
param space{ProductGroups};
param nRows;
set Rows:=1..nRows;
param cashierCount;
param cashierLength;

var melyiksorbanmelyiktermekcsoport{Rows,ProductGroups} binary;
var sorhossz{Rows};
var kasszahelye{Rows} binary;
var maxhossz >=0;

s.t. kasszapoz:
	sum{r in Rows} kasszahelye[r]=cashierCount;

s.t. egytermekcsoportegysor{p in ProductGroups}: #1 termékcsoport csak 1 sorban lehet
	sum{r in Rows} melyiksorbanmelyiktermekcsoport[r,p]=1;

s.t. sorhosszok{r in Rows}: #ez redundáns kiiratás
	sorhossz[r]=sum{p in ProductGroups} melyiksorbanmelyiktermekcsoport[r,p]*space[p]+cashierLength*kasszahelye[r];

#s.t. mindensorbalegyen {r in Rows}:
#	sum{p in ProductGroups} melyiksorbanmelyiktermekcsoport[r,p]>=1;

s.t. maxh{r in Rows}: 
	maxhossz>=sum{p in ProductGroups} melyiksorbanmelyiktermekcsoport[r,p]*space[p]+cashierLength*kasszahelye[r]
;
minimize Epulethossz:
	maxhossz;

solve;



