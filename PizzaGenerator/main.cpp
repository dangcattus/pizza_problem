#include <stdlib.h>
#include <iostream>
#include <stdio.h>
#include <fstream>
#include <ctime>
#include <string>
#include <sstream>
#include <sstream>



using namespace std;
/*v1 = rand() % 100;         // v1 in the range 0 to 99
v2 = rand() % 100 + 1;     // v2 in the range 1 to 100
v3 = rand() % 30 + 1985;   // v3 in the range 1985-2014*/

int main(int argc, char* argv[]){
srand( time( NULL ) );
  int numfiles, n, m; //n is pizzas, m is vouchers
  if (argc < 3){
    numfiles = 5;
    n = rand() % 10 + 4; //range 4 - 10
    m = rand() % 10 + 4; //
  }
  else {
    numfiles = atoi(argv[1]);
    n = atoi(argv[2]);
    m = atoi(argv[3]);
  }

  for (int c = 1; c <= numfiles; c++){
    //Generate the pizza data
    std::ostringstream oss;
    oss << c;
    string fileName = "../Pizza/Data/data" + oss.str() +".dzn";
    ofstream file;
    file.open(fileName);
    file << "n = " << n << ";\n";
    file << "price = [";
    for (int i = 0; i < n; i++){
      int price = rand() % 100 + 1;
      file << price;
      if (i != (n-1)){
        file << ",";
      }
      else{
        file << "];" << endl;
      }
    }
    file << "m = " << m << ";" << endl;
    file << "buy = [";
    for (int i = 0; i < m; i++){
      int buy = rand() % (n-1) + 1;
      file << buy;
      if (i != (m-1)){
        file << ",";
      }
      else{
        file << "];" << endl;
      }
    }
    file << "free = [";
    for (int i = 0; i < m; i++){
      int fr = rand() % (n-1) + 1;
      file << fr;
      if (i != (m-1)){
        file << ",";
      }
      else{
        file << "];" << endl;
      }
    }
    file.close();
  }
  return 0;
}
