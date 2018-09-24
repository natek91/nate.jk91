// Final Project Milestone 5
//
// Version 1.0
// Date: Aug 7th, 2018
// Author: JuAn Kim
// Description
// Milestone 5 Assignment
//
//
//
// Revision History
// -----------------------------------------------------------
// Name               Date                 Reason
/////////////////////////////////////////////////////////////////

#include <iostream>

#include "Perishable.h"


using namespace std;

namespace AMA
{
	//No-argument constructor:
	//passes the file record tag for a perishable product 'P' to the base class constructor
	//sets the current object to a safe empty state
	Perishable::Perishable() : Product('P')
	{
		m_pro_err.clear();
	}
	
	
	//Query stores a single file record for the current object
	std::fstream& Perishable::store(std::fstream& file, bool newLine) const
	{
		Product::store(file, false);
		
		file << ',' << perish_exp_date << endl;

		return file;
	}
	
	
	//Modifier extracts the data fields for a single file record from the fstream object
	std::fstream& Perishable::load(std::fstream& file)
	{
		Product::load(file);
		
		perish_exp_date.read(file);
		
		file.ignore();
		
		return file;
	}
	
	
	//Query identifies the output format
	std::ostream& Perishable::write(std::ostream& os, bool linear) const
	{
		Product::write(os, linear);

		if (isClear() && !isEmpty())
		{
			if (linear) {
				perish_exp_date.write(os);
				
			}else{
				os << "\n Expiry date: ";
				perish_exp_date.write(os);
			}
		}
		return os;
	}
	
	
	//Modfier populates the current object with the data extracted from the istream object
	//Calls its base class version passing as its argument a reference to the istream object
	std::istream& Perishable::read(std::istream& is)
	{
		is.clear();
		
		Product::read(is);

		if (m_pro_err.isClear()) 
		{
			cout << " Expiry date (YYYY/MM/DD): ";
			perish_exp_date.read(is);
		}

		if (perish_exp_date.errCode() == CIN_FAILED)
		{
			m_pro_err.clear();
			m_pro_err.message("Invalid Date Entry");
		}

		if (perish_exp_date.errCode() == YEAR_ERROR)
		{
			m_pro_err.clear();
			m_pro_err.message("Invalid Year in Date Entry");
		}

		if (perish_exp_date.errCode() == MON_ERROR)
		{
			m_pro_err.clear();
			m_pro_err.message("Invalid Month in Date Entry");
		}

		if (perish_exp_date.errCode() == DAY_ERROR)
		{
			m_pro_err.clear();
			m_pro_err.message("Invalid Day in Date Entry");
		}

		if (perish_exp_date.errCode())
		{
			is.setstate(std::ios::failbit);
		}

		if (perish_exp_date.errCode() != CIN_FAILED && perish_exp_date.errCode() != YEAR_ERROR && perish_exp_date.errCode() != MON_ERROR && perish_exp_date.errCode() != DAY_ERROR)
		{
			m_pro_err.clear();
		}

		return is;
	}
		
	
	//Query returns the expiry date for the perishable product
	const Date& Perishable::expiry() const
	{
		return perish_exp_date;
	}

	
}