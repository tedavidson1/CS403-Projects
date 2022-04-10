#ifndef _COMMISSIONEMPLOYEE_H
#define _COMMISSIONEMPLOYEE_H
#include "Employee.h"

#include <string>
class CommissionEmployee: public Employee{
  public:
    CommissionEmployee(const std::string&, const std::string&, double, double, double);
    void setminimumSalary(const double);
    double getminimumSalary() const;

    void setSales(const double);
    double getSales() const;

    void setcommissionRate(const double);
    double getcommissionRate() const;

    double getEarning() const;
    std::string getInfo() const;


  private:
    double minimumSalary;
    double sales;
    double commissionRate;
};
#endif
