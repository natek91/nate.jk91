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
#ifndef AMA_DATE_H
#define AMA_DATE_H
#include <iostream>

namespace AMA 
{
	
	const int min_year = 2000;
	const int max_year = 2030;
	const int NO_ERROR = 0;     // No error - the date is valid
	const int CIN_FAILED = 1;   // istream failed on information entry
	const int YEAR_ERROR = 2;   // Year value is invalid
	const int MON_ERROR = 3;    // Month value is invalid
	const int DAY_ERROR = 4;    // Day value is invalid 

	
	class Date {
	  
		private:
			int m_year;
			int m_month;
			int m_day;
			int comparator;
			int errorState;
		
		//Member functions
			int mdays(int, int)const;
			bool checkDate(int, int, int);
			void errCode(int);
		
		public:
			Date();
			Date(int, int, int);
			bool operator==(const Date&) const;
			bool operator!=(const Date&) const;
			bool operator<(const Date&) const;
			bool operator>(const Date&) const;
			bool operator<=(const Date&) const;
			bool operator>=(const Date&) const;
		
		//Queries and Modifier
			int errCode() const;
			bool bad() const;
			std::istream& read(std::istream&);
			std::ostream& write(std::ostream&) const;

	};
	
	//Helper functions
	std::ostream& operator<<(std::ostream&, const Date&);
	std::istream& operator>>(std::istream&, Date&);

}
#endif