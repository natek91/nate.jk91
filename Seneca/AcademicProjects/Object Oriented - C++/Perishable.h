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

#ifndef AMA_PERISHABLE_H
#define AMA_PERISHABLE_H

#include <iostream>
#include <fstream>
#include "Date.h"
#include "Product.h"


namespace AMA
{
	class Perishable : public Product
	{
		Date perish_exp_date;	//a Date object that holds the expiry date for the perishable product

	public:	
	//Public member functions: Queires + Modifiers:
		Perishable(); 							
		std::fstream& store(std::fstream& file, bool newLine = true) const;
		std::fstream& load(std::fstream& file);
		std::ostream& write(std::ostream& os, bool linear) const;
		std::istream& read(std::istream& is);
		const Date& expiry() const;
	};

	iProduct* CreatePerishable();
}

#endif