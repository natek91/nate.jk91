/*Main function checks and validates all user input data, clears all error-message buffers, and activates all 5 validation functions */
function checkAllData()
{
	errorBufferRemover();
	var val1 = username();
	var val2 = streetName();
	var val3 = password()
	var val4 = city();
	var val5 = province();
	return val1 && val2 && val3 && val4 && val5;
}

/*Displays assigned error messages*/
function errorDisplay(text)
{  
    document.querySelector("#error").innerHTML+=text;
}

/*Clears all the previously-displayed error-message buffers*/
function errorBufferRemover()
{
	document.querySelector("#error").innerHTML="";
}

/*Validates username-inputs by user*/
function username()
{
	var error = true;
	var counter = 0;
	var username = document.signup.username.value.trim();
	var userLength = username.length;
	var allChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@#$*()!=+-/";
	var onlyLetters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var errorLength = "Username must contain at least 5 characters";
	var errorChar = "Username must start with a letter";
	var checkChar = 0;
	
	
	for(var i = 0; i < userLength; i++)
    {
        if(allChars.indexOf(username.substr(i,1))>=0)
        counter++;
    }

    if(counter < 5)
    {
		errorDisplay("<p>" + errorLength + "</p>");
		error = false;
    }

    if(onlyLetters.indexOf(username.substr(0,1))>=0)
    { 
        checkChar = 1;
    }

    if(checkChar != 1)
    {
        errorDisplay("<p>" + errorChar + "</p>");
        error = false;
    }

	if(!error)
	{
		return false;
	}
	else
	{
		return true;
	}
}


/*Validates password-inputs by user*/
function password()
{
	var error = true;
    var pass = document.signup.password.value.trim();
	var passLength = pass.length;
    var repeat = document.signup.repeat.value.trim();
	var characters = "@#$*()!=+-/";
    var upperLetter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var numberDigit ="1234567890";
	var checkUpper = 0;
	var checkDigit = 0;
    var errorLength = "Password must contain at least 8 characters";
    var errorMatch = "Passwords do not match. Try re-typing the passwords";
    var errorUpper = "Password must contain at least one uppercase letter";
    var errorDigit = "Password must contain at least one number";
    
	
    if(passLength < 8)
    {
		errorDisplay("<p>" + errorLength + "</p>");
        error = false;
    }
	
	if(pass != repeat)
    {
		errorDisplay("<p>" + errorMatch + "</p>");
        error=false;
    }

	for(var i = 0; i < passLength; i++)
    {
        if(upperLetter.indexOf(pass.substr(i,1))>=0)
        {
            checkUpper = 1;      
            break;
        } 
    }
	
    if(checkUpper != 1)
    {
        errorDisplay("<p>" + errorUpper + "</p>");
        return false;
    }
    
    for(var i = 0; i < passLength; i++)
    {
        if(numberDigit.indexOf(pass.substr(i,1))>=0)
        {
            checkDigit = 1;
            break;
        }
    }
	
    if(checkDigit != 1)
    {
        errorDisplay("<p>" + errorDigit + "</p>");
        error = false;
    }
	
    if(!error)
    {
		return false;
	}
	else
	{
		return true;
	}
	
}


/*Prompts the user to at least selects one province*/
function province()
{
	var error = true;
	var province = document.signup.province.selectedIndex;
	var errorProvince = "You must select a province";
   
	if(province == -1)
	{   
		errorDisplay("<p>" + errorProvince + "</p>"); 
		error = false;
	}
	else
	{
		error = true;
	}
	
	if(!error)
	{
		return false;
	}
	else
	{
		return true;
	}
	
}



/*Validates the street name if it contains a number digit or not*/
function streetName()
{
	var error=true;
	var street = document.signup.streetName.value.trim();
	var numberDigit="1234567890";
	var valid = 0;
	var errorStreetName = "Street name must not have any number digit";
	
	for(var i=0; i < street.length; i++)
	{
		if(numberDigit.indexOf(street.substr(i,1))>=0)
		{
			valid = 1;
			error = false;
			break;
		}
	}
  
  
	if(valid == 1)
	{
		errorDisplay("<p>" + errorStreetName + "</p>");
		error = false;
	}

	
    if(!error)
    {
		return false;
    }
    else
    {
		return true;
	}

}



/*Validates City input by the user, city must accept only alphabet letters*/
function city()
{
	var error=true;
	var city = document.signup.city.value.trim();
	var lowerUpperalphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var errorCityChar = "Must contain letters only";
	var validCity = 0;
	
	for(var i=0; i < city.length; i++)
	{
		if(lowerUpperalphabets.indexOf(city.substr(i,1))>=0)
		{
			validCity = 1;
		}
		else
		{
			validCity=0;
			break;
		}
	}

	if(validCity == 0)
	{
		error = false;
		errorDisplay("<p>" + errorCityChar + "</p>");
	}

	if(!error)
	{
		return false;
	}
	else
	{
		return true;
	}

}


