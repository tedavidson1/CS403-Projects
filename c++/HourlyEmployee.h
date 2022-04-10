#ifndef _HOURLYEMPLOYEE_H
#define _HOURLYEMPLOYEE_H
#include "Employee.h"

#include <string>
class HourlyEmployee: public Employee{
  public:
    //make a constructor for each class. Even if blank
    HourlyEmployee(const std::string&, const std::string&, double, double);
    void setHours(const double);
    double getHours() const;

    void sethourlyRate(const double);
    double getHourlyRate() const;

    double getEarning() const;
    std::string getInfo() const;

  private:
    double hours;
    double hourlyRate;
};
#endif
