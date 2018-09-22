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

#ifndef AMA_ERROR_STATE_H
#define AMA_ERROR_STATE_H
#include <iostream>
#include <cstring>
#include <string>
using namespace std;

namespace AMA
{
    class ErrorState
    {
        char* m_message;

    public:
        explicit ErrorState(const char* errorMessage = nullptr);   
		
		//A deleted copy constructor that prevents copying of any ErrorState object
        ErrorState(const ErrorState& em) = delete;   
		
		//A deleted assignment operator prevents assignment of any Errostate object to current obj
        ErrorState& operator=(const ErrorState& em) = delete;    
		
        virtual ~ErrorState();       
        void clear();
        bool isClear() const;       
        void message(const char* str);        
        const char* message() const;
    };

    std::ostream& operator<<(std::ostream& os, const ErrorState& em);
}

#endif