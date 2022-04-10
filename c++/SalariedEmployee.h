#ifndef _SALARIEDEMPLOYEE_H
#define _SALARIEDEMPLOYEE_H
#include "Employee.h"

#include <string>
class SalariedEmployee: public Employee{
  public:
    SalariedEmployee(const std::string&, const std::string&, double);
    void setweeklySalary(const double);
    double getweeklySalary() const;

    double getEarning() const;
    std::string getInfo() const;


  private:
    double weeklySalary;
  };
#endif
