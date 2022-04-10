#include <sstream>
#include "CommissionEmployee.h"

using namespace std;
//Compiles free of errors and warnings
    CommissionEmployee::CommissionEmployee(const string& first, const string& last, double min, double sold, double percent): Employee(first, last){
      minimumSalary = min;
      sales = sold;
      commissionRate = percent;
    }

    void CommissionEmployee::setminimumSalary(const double value){
      minimumSalary = value;
    }

    double CommissionEmployee::getminimumSalary() const{
      return minimumSalary;
    }

    void CommissionEmployee::setSales(const double value){
      sales = value;
    }

    double CommissionEmployee::getSales() const{
      return sales;
    }

    void CommissionEmployee::setcommissionRate(const double value){
      commissionRate = value;
    }

    double CommissionEmployee::getcommissionRate() const{
      return commissionRate;
    }

    double CommissionEmployee::getEarning() const{
      double total = sales * commissionRate;
      if (total > minimumSalary) return total;
      else return minimumSalary;
    }

    string CommissionEmployee::getInfo() const{
      //minimum salary: 300.00, sales amount: 15000.00, commission rate: 15.00%
       double percent = getcommissionRate() * 100;
       ostringstream os;
       os.precision(2);
       os << fixed << "Commission employee: " << getFirstName() << " " << getLastName() << endl << "minimum salary: " << getminimumSalary() << ", sales amount: " << getSales() << ", commission rate: " << percent << "%";
       return os.str();
    }
