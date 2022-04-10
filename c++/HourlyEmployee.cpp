#include <sstream>
#include "HourlyEmployee.h"

using namespace std;
//Compiles without errors or warnings
    HourlyEmployee::HourlyEmployee(const string& first, const string& last, double time, double rate): Employee(first, last){
      hours = time;
      hourlyRate = rate;
    }

    void HourlyEmployee::setHours(const double value){
      hours = value;
    }

    double HourlyEmployee::getHours() const{
      return hours;
    }

    void HourlyEmployee::sethourlyRate(const double value){
      hourlyRate = value;
    }

    double HourlyEmployee::getHourlyRate() const{
      return hourlyRate;
    }

    double HourlyEmployee::getEarning() const{
      if (hours <= 40) return hours * hourlyRate;
      else if (hours <= 50) return ((40 * hourlyRate) + ((hours - 40) * (hourlyRate * 1.5)));
      else return ((40 * hourlyRate) + (10 * (hourlyRate * 1.5)) + ((hours - 50) * (hourlyRate * 2)));
    }

    string HourlyEmployee::getInfo() const{
      ostringstream os;
      os.precision(2);
      os << fixed << "Hourly employee: " << getFirstName() << " " << getLastName() << endl << "hours worked: " << getHours() << ", hourly rate: " << getHourlyRate();
      return os.str();
    }
