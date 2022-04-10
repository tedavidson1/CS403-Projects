#include <vector>
#include "Employee.h"
#include "CommissionEmployee.h"
#include "HourlyEmployee.h"
#include "SalariedEmployee.h"
#include <sstream>
#include <iostream>
#include <fstream>
using namespace std;

vector<Employee*> *readFrom(string path){
  vector<Employee*> *persons = new vector<Employee*>; //should work
  ifstream infile; //ifstream for reading the file
  infile.open(path); //opening the path of the file
  if (infile.is_open() != 1) return persons; //return the empty vector
  //otherwise, operate on the data
  string line; //current line we have from the file
  while(getline(infile, line)){ //while we can get a line from the file
    stringstream ss(line); //string stream of the line. Gets stuff by spaces
    string job; //holds the job title
    ss >> job; //gets the type of employee
    string first;
    ss >> first;
    string last;
    ss >> last;

    if (job == "salaried"){
      double pay;
      ss >> pay;
      SalariedEmployee *hire = new SalariedEmployee(first, last, pay);
      persons->push_back(hire);
    }
    else if (job == "hourly"){
      double time;
      double rate;
      ss >> time;
      ss >> rate;
      HourlyEmployee *hire = new HourlyEmployee(first, last, time, rate);
      persons->push_back(hire);
    }
    else if (job == "commission"){ //must be commissioned
      double min, sold;
      double percent;
      ss >> min;
      ss >> sold;
      ss >> percent;
      CommissionEmployee *hire = new CommissionEmployee(first, last, min, sold, percent);
      persons->push_back(hire);
    }
  }//end of while
  infile.close(); //close the file
  return persons; //return the vector
}//end of function
