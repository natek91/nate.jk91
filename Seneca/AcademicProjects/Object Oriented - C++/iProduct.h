// Final Project Milestone 4
//
// Version 1.0
// Date: July 31st, 2018
// Author: JuAn Kim
// Description
// Milestone 4 Assignment
//
//
//
// Revision History
// -----------------------------------------------------------
// Name               Date                 Reason
/////////////////////////////////////////////////////////////////

#ifndef AMA_IPRODUCT_H
#define AMA_IPRODUCT_H

#include <iostream>
#include <fstream>


namespace AMA
{
    class iProduct
    {
    public:
		//Pure Virtual Member Functions:
		
        virtual std::fstream& store(std::fstream& file, bool newLine=true) const = 0;	//query inserts the Product reocrds into fstream object
        virtual std::fstream& load(std::fstream& file) = 0;								//modifier extracts iProduct records from fstream object
        virtual std::ostream& write(std::ostream& os, bool linear) const = 0;			//query inserts the iProduct record for the current object into ostream object
        virtual std::istream& read(std::istream& is) = 0;     							//modifier extracts iProduct record for the current object from the istream object
        virtual bool operator==(const char*) const = 0;      							//query returns true if the string is identical to the stock keeping unit of an iProduct record; false othewise
        virtual double total_cost() const = 0;      									//query returns the cost of a single unit of an iProduct with taxes included
        virtual const char* name() const = 0;     										//query returns the address of a C-style null-terminated string containing the name of an iProduct
        virtual void quantity(int) = 0;   												//modifier sets the number of units available
        virtual int qtyNeeded() const = 0;     											//query returns the number of units of an iProduct that are needed
        virtual int quantity() const = 0;    											//query returns the number of units of that are currently available
        virtual int operator+=(int) = 0;      											//modifier returns the updated number of units currently available
        virtual bool operator>(const iProduct&) const = 0;								//query returns true if the current object is greater than the referenced iProduct object; false otherwise
  
		virtual ~iProduct() = default;  							//iProduct class to be defined with a virtual destructor
  };

	//Helper Functions:
	
    std::ostream& operator<<(std::ostream&, const iProduct&);		//inserts the iProduct record for the referenced object into the ostream object
    std::istream& operator>>(std::istream&, iProduct&);				//extracts the iProdcut record for the referenced object from the istream object
    double operator+=(double&, const iProduct&);					//adds the total cost of the iProdcut object to the double received and returns the updated value of the double
    iProduct* CreateProduct();										//returns address of a Product object
    iProduct* CreatePerishable();									//returns the address of a Perishable object
}

#endif