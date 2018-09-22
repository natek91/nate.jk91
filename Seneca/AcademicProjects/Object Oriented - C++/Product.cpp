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

#define _CRT_SECURE_NO_WARNINGS

#include <cstring>
#include <iomanip>
#include <iostream>
#include <fstream>

#include "Product.h"

using namespace std;

namespace AMA
{
	//Name function
	void Product::name(const char* nameAdd)
	{
		if (nameAdd != nullptr)
		{
			int pro_length = strlen(nameAdd);

			m_pro_name = new char[pro_length + 1];
			for (int i = 0; i < pro_length; ++i)
			{
				m_pro_name[i] = nameAdd[i];
			}

			m_pro_name[pro_length] = '\0';
			
		}else if (nameAdd == nullptr)
		{
			delete[] m_pro_name;
			m_pro_name = nullptr;
		}
	}
	
	
	//Name query
	const char* Product::name() const
	{
		if (m_pro_name != nullptr)
			return m_pro_name;
		else
			return nullptr;	
	}
	
	
	//SKU query
	const char* Product::sku() const
	{
		return m_pro_sku;
	}
	
	
	//Unit query
	const char* Product::unit() const
	{
		return m_pro_unit;
	}
	
	
	//Taxable status query
	bool Product::taxed() const
	{
		return m_pro_taxable;
	}
	
	
	//'Price of a single item' query
	double Product::price() const
	{
		return m_pro_price_unit_notax;
	}
	
	
	//'Price of a single item plus tax' query
	double Product::cost() const
	{
		if(m_pro_taxable)
		{
			return price() * (tax_rate + 1);
		}
		else
		{
			return price();
		}
	}
	
	
	//Error Message function
	void Product::message(const char* errAdd)
	{
		if (errAdd != nullptr)
		{
			m_pro_err.message(errAdd);
		}
	}
	
	
	//ErrorState query
	bool Product::isClear() const
	{
		return m_pro_err.isClear();
	}
	
	
	//Zero-One argument constructor
	Product::Product(char type)
	{
		m_pro_type = type;
		m_pro_sku[0] = '\0';
		m_pro_unit[0] = '\0';
		m_pro_name = nullptr;
		m_pro_quant_current = 0;
		m_pro_quant_need = 0;
		m_pro_price_unit_notax = 0.0;
		m_pro_taxable = false;
	}
	
	
	//Seven argument constructor
	Product::Product(const char* sku, const char* nameAdd, const char* unit, int quant_current, bool taxable, double price_noTax, int quant_need)
	{
		bool testNull = sku != nullptr && nameAdd != nullptr && unit != nullptr;
		
		if(testNull)
		{	
			strncpy(m_pro_sku, sku, strlen(sku));
			m_pro_sku[strlen(sku)] = '\0';
			Product::name(nameAdd);
			strncpy(m_pro_unit, unit, strlen(unit));
			m_pro_unit[strlen(unit)] = '\0';
		}
		
		m_pro_quant_current = quant_current;
		m_pro_taxable = taxable;
		m_pro_price_unit_notax = price_noTax;
		m_pro_quant_need = quant_need;
		
	}
	
	
	//Copy constructor
	Product::Product(const Product& product)
	{
		*this = product;
	}
	
	
	//Copy Assignment Operator
	Product& Product::operator=(const Product& product)
	{
		if (this != &product)
		{
			int sku_length = strlen(product.m_pro_sku);
			int unit_length = strlen(product.m_pro_unit);

			m_pro_type = product.m_pro_type;
			m_pro_quant_current = product.m_pro_quant_current;
			m_pro_quant_need = product.m_pro_quant_need;
			m_pro_price_unit_notax = product.m_pro_price_unit_notax;
			m_pro_taxable = product.m_pro_taxable;

			name(product.m_pro_name);
			strncpy(m_pro_sku, product.m_pro_sku, sku_length);
			m_pro_sku[sku_length] = '\0';

			strncpy(m_pro_unit, product.m_pro_unit, unit_length);
			m_pro_unit[unit_length] = '\0';
		}

		return *this;
	}
	

	
	//Destructor
	Product::~Product()
	{
		delete[] m_pro_name;
	}
	
	
	//Fstream query
	std::fstream& Product::store(std::fstream& file, bool newLine) const
	{
		file << m_pro_type << ',' 
			 << m_pro_sku << ','
			 << m_pro_name << ','
			 << m_pro_unit << ','
			 << m_pro_taxable << ","
			 << m_pro_price_unit_notax << ","
			 << m_pro_quant_current << ","
			 << m_pro_quant_need;
			 
				
		if (newLine) file << endl;
		
		return file;
	}
	
	
	//Fstream modifier
	std::fstream& Product::load(std::fstream& file)
	{
		char proTax;
		char pName_length[max_char_user_name];
		char sku_length[max_char_sku];
		char unit_length[max_char_unit];
		int currentQty;
		int neededQty;
		double proPrice;
		bool taxable;
		
		if (file.is_open())
		{
			file.getline(sku_length, max_char_sku, ',');
			sku_length[strlen(sku_length)] = '\0';
			file.getline(pName_length, max_char_user_name, ',');
			pName_length[strlen(pName_length)] = '\0';
			file.getline(unit_length, max_char_unit, ',');
			unit_length[strlen(unit_length)] = '\0';

			file >> proTax;

			if (proTax == '1'){
				taxable = true;
				
			}else if (proTax == '0'){
				taxable = false;
			}
			
			file.ignore();
			file >> proPrice;
			file.ignore();
			file >> currentQty;
			file.ignore();
			file >> neededQty;
			file.ignore();
			
			*this = Product(sku_length, pName_length, unit_length, currentQty, taxable, proPrice, neededQty);
		
		}

		
		return file;
	}
	
	
	//Ostream query
	std::ostream& Product::write(std::ostream& os, bool linear) const
	{
		
		if(!(m_pro_err.isClear()))
		{
			os << m_pro_err.message();
		}
		
		else if (linear == true)
		{
			os  << setw(max_char_sku) << left << m_pro_sku << '|'
				<< setw(20) << left << m_pro_name << '|'
				<< setw(7) << right << fixed << setprecision(2) << cost() << '|'
				<< setw(4) << right << m_pro_quant_current << '|'
				<< setw(10) << left << m_pro_unit << '|'
				<< setw(4) << right << m_pro_quant_need << '|';
		}
		else
		{
			os  << " Sku: " << m_pro_sku << endl
				<< " Name (no spaces): " << m_pro_name << endl
				<< " Price: " << m_pro_price_unit_notax << endl;
				
			if (m_pro_taxable)
			{
				os << " Price after tax: " << cost() << endl;
			}
			else
			{
				os << " Price after tax: N/A" << endl;
			}

			os  << " Quantity on Hand: " << m_pro_quant_current << ' ' << m_pro_unit << endl
				<< " Quantity needed: " << m_pro_quant_need;
		}
		
		return os;
	}
	
	
	//Istream modifier
	std::istream& Product::read(std::istream& is)
	{	
		char * nameAdd = new char[max_char_user_name + 1];
		char temp_tax;
		int quant_current;
		int pro_need;	
		double price_noTax;

		if (!is.fail())
		{
			//Sku data
			cout << " Sku: ";
			is >> m_pro_sku;
			cin.ignore();
			
			//Product Name data
			cout << " Name (no spaces): ";
			is >> nameAdd;
			name(nameAdd);
			
			//Product Unit data
			cout << " Unit: ";
			is >> m_pro_unit;
			
			//Taxed data
			cout << " Taxed? (y/n): ";
			is >> temp_tax;

			if (!is.fail())
			{
				m_pro_err.clear();

				if (temp_tax)
				{
					bool yes_tax = temp_tax == 'y' || temp_tax == 'Y';
					bool no_tax = temp_tax == 'n' || temp_tax == 'N';

					if (yes_tax)
						m_pro_taxable = true;

					if (no_tax)
						m_pro_taxable = false;

					if (!(yes_tax || no_tax))
					{
						is.setstate(std::ios::failbit);
						m_pro_err.message("Only (Y)es or (N)o are acceptable");
						return is;
					}
				}
			}
			else
			{
				is.setstate(std::ios::failbit);
				m_pro_err.message("Only (Y)es or (N)o are acceptable");
				return is;
			}

			
			//Product price data
			cout << " Price: ";
			is >> price_noTax;

			if (is.fail())
			{
				m_pro_err.clear();
				is.setstate(ios::failbit);
				m_pro_err.message("Invalid Price Entry"); 
				return is;
			}else{
				price(price_noTax);
			}
			
			
			//Product Quantity on Hand data
			cout << " Quantity on hand: ";
			is >> quant_current;
			
			if (is.fail())
			{
				m_pro_err.clear();
				m_pro_err.message("Invalid Quantity Entry");
				is.setstate(ios::failbit);
				return is;
			}else{
				quantity(quant_current);
			}
			
			
			//Product Quantity Needed data
			cout << " Quantity needed: ";
			is >> pro_need;
			cin.ignore();

			if (is.fail())
			{
				m_pro_err.clear();
				m_pro_err.message("Invalid Quantity Needed Entry");
				is.setstate(ios::failbit);
				return is;
			}else{
				needed(pro_need);
			}
			
			if (!is.fail())
			{
				m_pro_err.clear();
			}
		}

		return is;
	}

	
	//'==' operator query
	bool Product::operator==(const char* nameAdd) const
	{
		if(nameAdd == sku())
		{
			return true;
			
		}
		else
		{
			return false;
		}
		
	}
	
	
	//'Total cost of current product plus tax' query
	double Product::total_cost() const
	{
		return m_pro_quant_current * cost();
	}
	
	
	//Quantity modifier
	void Product::quantity(int unit_current_quant)
	{
		m_pro_quant_current = unit_current_quant;
	}
	
	//Price modifier
	void Product::price(double price)
	{
		m_pro_price_unit_notax = price;
	}
	
	//Quantity Needed modifer
	void Product::needed(int needed)
	{
		m_pro_quant_need = needed;
	}
	
	
	//Safe emptystate query
	bool Product::isEmpty() const
	{
		if(m_pro_name == nullptr)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	
	//Product specific type query
	char Product::type() const
	{
		return m_pro_type;
	}

	
	//'Number of units of the product that are needed' query
	int Product::qtyNeeded() const
	{
		return m_pro_quant_need;
	}
	
	
	//Quantity query on hand
	int Product::quantity() const
	{
		return m_pro_quant_current;
	}
	
	
	//'>' operator SKU query
	bool Product::operator>(const char* skuAdd) const
	{
		if (strcmp(m_pro_sku, skuAdd) > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	
	//'>' operator Product Name query
	bool Product::operator>(const iProduct& pro_name) const
	{
		if (strcmp(m_pro_name, pro_name.name()) > 0) 
		{	
			return true;
		}
		else
		{
			return false;
		}
	}
	
	
	//'+=' operator '# of units to be added' modifier
	int Product::operator+=(int add_unit)
	{
		if (add_unit > 0)
		{
			m_pro_quant_current += add_unit;
			
			return m_pro_quant_current;
		}
		else
		{
			return m_pro_quant_current;
		}
	}
	
	
	
	//Helper Functions
	
	//Ostream helper
	std::ostream &operator<<(std::ostream& os, const iProduct& product)
	{
		return product.write(os, true);
	}
	
	//Istream helper
	std::istream &operator>>(std::istream& is, iProduct& product)
	{
		product.read(is);
		return is;
	}
	
	//'+=' helper
	double operator+=(double& total_cost, const Product& product)
	{
		return total_cost + product.total_cost();
	}
	
	
}