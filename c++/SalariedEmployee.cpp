#include <sstream>
#include "SalariedEmployee.h"

using namespace std;
    SalariedEmployee::SalariedEmployee(const string& first, const string& last, double pay): Employee(first, last){
      weeklySalary = pay;
    }

    void SalariedEmployee::setweeklySalary(const double value){
      weeklySalary = value;
    }

    double SalariedEmployee::getweeklySalary() const{
      return weeklySalary;
    }

    double SalariedEmployee::getEarning() const{
      return weeklySalary;
    }

    string SalariedEmployee::getInfo() const{
      ostringstream os;
      os.precision(2);
      os << fixed << "Salaried employee: " << getFirstName() << " " << getLastName() << endl << "weekly salary: " << getweeklySalary();
      return os.str();
    }
