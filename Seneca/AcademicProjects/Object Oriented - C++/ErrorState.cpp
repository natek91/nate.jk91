// Final Project Milestone 2
//
// Version 1.0
// Date: July 17th, 2018
// Author: JuAn Kim
// Description
// Milestone 2 Assignment
//
//
//
// Revision History
// -----------------------------------------------------------
// Name               Date                 Reason
/////////////////////////////////////////////////////////////////

#include <iostream>
#include <cstring>
#include <string>
#include "ErrorState.h"

using namespace AMA;
using namespace std;

namespace AMA
{
	//Receives address of a null-terminated C string that holds an err msg.
	//If the address is nullptr, then it puts the object in a safe state
	//If the address points to a non-empty message, it allocates memory for
	//that specified message and copies the message into the allocated memory.
    ErrorState::ErrorState(const char* errorMessage)
    {
        if (errorMessage == nullptr)
        {
			m_message = nullptr;   //puts into a safe state
        }
        else
        {
			m_message = new char[strlen(errorMessage) + 1]; //allocates new errorMessage dynamic memory
			strcpy(m_message, errorMessage); //then copies the message
        }
    }

	
	//De-allocated any memory that has been dynamically allocated by the current object
    ErrorState::~ErrorState()
    {
		delete[]m_message;
		m_message = nullptr;
    }

	
	//Clears any message stored by the current object and initializes the object to a safe state
    void ErrorState::clear()
    {
		delete[] m_message;
		m_message = nullptr;
    }

	
	//Query that reports returns true if the current object is in a safe state
    bool ErrorState::isClear() const
    {
		return (m_message == nullptr) ? true : false;
    }

  
	//Stores a copy of C string pointed to by str
	void ErrorState::message(const char* str)
    {
		int err_length = strlen(str);
		
		delete[] m_message; //de-allocates previously allocated m_message memory
		m_message = nullptr;
		
		m_message = new char[err_length + 1];  //allocate new dynamic memory
		
		for(int i = 0; i < err_length; i++)
		{
			m_message[i] = str [i];
		}
		
		m_message[err_length] = '\0';
	
    }
  
	
	//Query that returns the address of the message stored in the current object
    const char* ErrorState::message() const
    {
		return m_message;
    }

	
	//This '<<' operator,
	// a) if one Errorstate message exists, it sends the message to an std::ostream object, then returns a reference to the std::ostream object
	// b) if no Errorstate message exists, this operator does not send anything to the std object, and then returns a reference to the std object
    std::ostream& operator<<(std::ostream& os, const ErrorState& em)
    {
		if (!em.isClear())
		{
			os << em.message();
		}
		return os;
    }
	
}