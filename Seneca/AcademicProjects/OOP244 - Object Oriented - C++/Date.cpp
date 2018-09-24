// Final Project Milestone 1
//
// Version 1.0
// Date: July 08th, 2018
// Author: JuAn Kim
// Description
// Milestone 1 Assignment
//
//
//
// Revision History
// -----------------------------------------------------------
// Name               Date                 Reason
/////////////////////////////////////////////////////////////////

#include <iostream>
#include "Date.h"

using namespace std;

namespace AMA {
	
   //Number of days in month mon_ and year year_
	int Date::mdays(int mon, int year)const {
		int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, -1 };
		int month = mon >= 1 && mon <= 12 ? mon : 13;
		month--;
		return days[month] + int((month == 1)*((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0));
	}

	
	//Sets the error state variable to one of the listed values 
	void Date::errCode(int errorC) 
	{
		errorState = errorC;
	}

	
	//Set to empty state (No argument default constructor)
	Date::Date() {
		m_year = 0;
		m_month = 0;
		m_day = 0;
		comparator = 0;
		errorState = 0;
	}
	
	//Checks if each number is in range, order of year, month and day. If not, sets the error state to error code
	Date::Date(int year, int month, int day) {
		
		if (checkDate(year, month, day))
		{
			m_year = year;
			m_month = month;
			m_day = day;
			errorState = NO_ERROR;
			comparator = year * 372 + month * 13 + day;
		}
		else
		{	
			*this = Date();
		}
	}
		
	
	//Checks and returns if the inputted date parameters are valid
	bool Date::checkDate(int year, int month, int day)
	{
		bool dateCheck = !year || !month || !day;
		bool ruleYear = year >= min_year && year <= max_year;
		bool ruleMonth = month >= 1 && month <= 12;
		bool ruleDay = day >= 1 && day <= 31;

		if (!dateCheck)
		{
			
			if (ruleYear && ruleMonth && ruleDay)
			{
				return true;
			}
			
			else
			{
				if (!ruleYear)
				{
					*this = Date();
					errCode(YEAR_ERROR);
				}

				else if (!ruleMonth)
				{
					*this = Date();
					errCode(MON_ERROR);
				}

				else if (!ruleDay || m_day > mdays(m_month, m_year))
				{
					*this = Date();
					errCode(DAY_ERROR);
				}

				return false;
			}
		}
		
		else
		{
			return false;
		}
	}
	
	
	//Returns true if the data in the current Date object is equal to the Date stored in rhs object
	bool Date::operator==(const Date& rhs) const { 
		Date temp(this->m_year, this->m_month, this->m_day);
		bool valid = temp.m_year != 0 && rhs.m_year != 0;

		if (temp.comparator == rhs.comparator && valid)
		{
			return true;
		}
		
		return false;
	}
	
	
	//Returns true if the data in the current Date object is not equal to the Date stored in rhs object
	bool Date::operator!=(const Date& rhs) const {
		Date temp(this->m_year, this->m_month, this->m_day);
		bool valid = temp.m_year != 0 && rhs.m_year != 0;

		if (valid)
		{
			if (temp.comparator != rhs.comparator)
				return true;
			else
				return false;
		}
		
		return false;
	}
	
	
	//Returns true if the data in the current Date object is before the Date stored in rhs object
	bool Date::operator<(const Date& rhs) const {
		Date temp(this->m_year, this->m_month, this->m_day);
		bool valid = temp.m_year != 0 && rhs.m_year != 0;

		if (valid)
		{
			if (temp.comparator < rhs.comparator)
				return true;
			else
				return false;
		}
		
		return false;
	}
	
	
	//Returns true if the data in the current Date object is after the Date stored in rhs object
	bool Date::operator>(const Date& rhs) const {
		Date temp(this->m_year, this->m_month, this->m_day);
		bool valid = temp.m_year != 0 && rhs.m_year != 0;

		if (valid)
		{
			if (temp.comparator > rhs.comparator)
				return true;
			else
				return false;
		}
		
		return false;
	}
	
	
	//Returns true if the data in the current Date object is before and equal to the Date stored in rhs object
	bool Date::operator<=(const Date& rhs) const {
		Date temp(this->m_year, this->m_month, this->m_day);
		bool valid = temp.m_year != 0 && rhs.m_year != 0;

		if (valid)
		{
			if (temp.comparator <= rhs.comparator)
				return true;
			else
				return false;
		}
		
		return false;
	}
	
	
	//Returns true if the data in the current Date object is after and equal the Date stored in rhs object
	bool Date::operator>=(const Date& rhs) const {
		Date temp(this->m_year, this->m_month, this->m_day);
		bool valid = temp.m_year != 0 && rhs.m_year != 0;

		if (valid)
		{
			if (temp.comparator >= rhs.comparator)
				return true;
			else
				return false;
		}
		
		return false;
	}
	
	
	//This Query returns the error state as an error code value
	int Date::errCode() const {

		return this->errorState;
	}
	
	
	//This Query returns true if the error state is not NO_ERROR
	bool Date::bad() const{
		if (this->errorState != 0) {
			return true;
		}
		
		return false;
	}

	
	//Reads the date from the console in the YYYY?MM?DD format
	std::istream& Date::read(std::istream& istr) { 
		
		char slash = '/';
		
		errCode(NO_ERROR);
		istr >> m_year >> slash >> m_month >> slash >> m_day;

		if (cin.fail() || istr.fail())
		{
			*this = Date();
			errCode(CIN_FAILED);
		}
		else if (!checkDate(m_year, m_month, m_day))
		{
			istr.clear();
			return istr;
		}

		istr.clear();
		
		return istr;
		
	}
	
	
	//Writes the date to an std::ostream object in YYYY/MM/DD format, 
	//and returns a reference to the std::ostream object
	std::ostream& Date::write(std::ostream& ostr) const {
		char slash = '/';
		
		ostr << m_year << slash;

		if (m_month < 10)
		{
			ostr << 0;
		}
		
		ostr << m_month << slash;
		
		if (m_day < 10)
		{
			ostr << 0;
		}

		ostr << m_day;

		return ostr;
	}
	
	
	//Works with std::ostream object to print a date to the console
	std::ostream& operator<<(std::ostream& ostr, const Date& rhs)
	{
		return rhs.write(ostr);
	}
	
	
	//Works with std::istream object to read a date from the console
	std::istream& operator>>(std::istream& istr, Date& rhs)
	{
		return rhs.read(istr);
	}
	
}
