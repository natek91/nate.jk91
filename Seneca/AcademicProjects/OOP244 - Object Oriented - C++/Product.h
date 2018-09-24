// Final Project Milestone 3
//
// Version 1.0
// Date: July 31st, 2018
// Author: JuAn Kim
// Description
// Milestone 3 Assignment
//
//
//
// Revision History
// -----------------------------------------------------------
// Name               Date                 Reason
/////////////////////////////////////////////////////////////////
#ifndef AMA_PRODUCT_H
#define AMA_PRODUCT_H

#include <fstream>
#include <iostream>
#include "ErrorState.h"
#include "iProduct.h"
	
	
namespace AMA 
{	
	const int max_char_sku = 7;					//maximum # of chars in a sku(stock keeping unit)
	const int max_char_unit = 10;				//maximum # of chars in the units' descriptor for a product
	const int max_char_user_name = 75;			//maximum # of chars in the user's name descriptor for a product legnth
	const double tax_rate = 0.13;				//the current tax rate
	
	const int max_sku_length = max_char_sku;
	const int max_name_length = max_char_user_name;
	const int max_unit_length = max_char_unit;
	
	class Product : public iProduct
	{
	
	private:
		char m_pro_type;						//indicates the type of the product for use in the file record
		char m_pro_sku[max_char_sku + 1];		//holds the product's sku (stock keeping unit) 
		char m_pro_unit[max_char_unit + 1];		//describes the product's units
		char* m_pro_name;						//holds the address of a C-string in dynamic memory containing the name of the product
		int m_pro_quant_current;				//holds the quantity of the product currently on hand
		int m_pro_quant_need;					//holds the quantity of the product needed
		double m_pro_price_unit_notax;			//holds the price of a single unit of the product before any taxes
		bool m_pro_taxable;						//identifies the taxable status of the product. 'True' if the product is taxable
		
		
	protected:
		void name(const char*);					//receives the address of a C-style null-terminated string that holds the name of the product
		const char* name() const;				//returns the address of the C-style string that holds the name of the product
		const char* sku() const;				//returns the address of the C-style string that holds the sku of the product
		const char* unit() const;				//returns the address of the C-style string that holds the unit of the product
		bool taxed() const;						//returns the taxable status of the product
		double price() const;					//returns the price of a single item of the product
		double cost() const;					//returns the price of a single item of the product plus any tax that applies to the product
		void message(const char*);				//receives the address of a C-style null-terminated string holding an error message and stores that message in the ErrorState object
		bool isClear() const;					//returns 'true' if the ErrorState object is clear; false otherwise
		ErrorState m_pro_err;					//holds the error state of the Product object
	
	public:	
		Product(char type = 'N');																											//Zero-One argument; receives a character that identifies the product type. Default is N
		Product(const char*, const char*, const char *, int onHand = 0, bool taxable = true, double beforeTax = 0.0, int needed = 0);		//Receives in its seven parameters values
		Product(const Product&);												//Copy Constructor; receives an unmodifiable reference to a Product object and copies the object referenced to the current object
		Product& operator=(const Product&);     								//Copy Assignment Operator; receives an unmodifiable reference to a Product object and replaces the current object with a copy of the object referenced
		~Product();																//Destructor; deallocates any memory that has been dynamically allocated		
		std::fstream& store(std::fstream& file, bool newLine = true) const;		//receives a reference to an fstream object and an optional bool and returns a reference to the fstream object
		std::fstream& load(std::fstream& file); 								//receives a reference to an fstream object and returns a reference to that fstream object
		std::ostream& write(std::ostream& os, bool linear) const;				//receives a reference to an ostream object and a bool and returns a reference to the ostream object
		std::istream& read(std::istream& is);									//receives a reference to an istream object and returns a reference to the istream object
		bool operator==(const char*) const;										//receives the address of an unmodifiable C-style null-terminated string and returns true if the string is identical to the sku of the current object
		double total_cost() const;												//returns the total cost of all items of the product on hand, taxes included
		void quantity(int);														//receives an integer holding the number of units of the Product that are on hand		
		void price(double);												        //returns the price of a single item of the product
		void needed(int);														//receives the number of units of the products that are needed
		char type() const;														//returns the type of the product 
		bool isEmpty() const;													//returns true if the object is in a safe empty state; false otherwise
		int qtyNeeded() const;													//returns the number of units of the product that are needed
		int quantity() const;													//returns the number of units of the product that are on hand	
		bool operator>(const char*) const;										//receives the address of a C-style null-terminated string holding a product sku and returns true if the sku of the current object is greater than the string stored at the received addressbool operator>(const Product& other) const;				
		bool operator>(const iProduct&) const;									//receives an unmodifiable reference to a Product obejct and returns true if the name of the current object is greater than the name of the referenced Product object; false otherwise
		int operator+=(int);													//receives an integer identifying the number of units to be added to the Product and returns the updated number of units on hand

	};
	
	//Helper Functions:
		std::ostream& operator<<(std::ostream&, const iProduct&);				//receives a reference to an ostream object and an unmodifiable reference to a Product object and returns a reference to the ostream object 
		std::istream& operator>>(std::istream&, iProduct&);						//receives a reference to an istream object and a reference to a Product object and returns a reference to the istream object
		double operator+=(double&, const iProduct&);							//receives a reference to a double and an unmodifiable reference to a Product object and returns a double

		
}

#endif