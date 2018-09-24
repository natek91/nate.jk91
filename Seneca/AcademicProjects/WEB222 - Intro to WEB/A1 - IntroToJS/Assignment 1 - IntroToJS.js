/*********************************************************************************
* WEB222 – Assignment 01
* I declare that this assignment is my own work in accordance with Seneca Academic Policy. No part of
* this assignment has been copied manually or electronically from any other source (including web sites)
* or distributed to other students.
*
* Name: JuAn Kim Student ID: 131549164 Date: Jan. 26th, 2018
*
********************************************************************************/

/*****************************
*Task 1
*****************************/


var studentname, numberofcourses, program;


studentname = "JuAn Kim';
numberofcourses = 5;
program = 'CPA';

function parttimejob(a){
	var a;
	if(a=true)
		a="have";
	else if(a=false)
		a="don't have";

	return a;
}

console.log("My name is " + studentname + " and I'm in " + program + ".");
console.log("I am taking " + numberofcourses + " courses in this semester.");
console.log("and I " + parttimejob(true) + "a part-time job now.");


/*****************************
*Task 2
*****************************/

var Year = 2018;

age = prompt("Please enter your age: ");
birthyear = Year - parseInt(age,10);

console.log("You were born in the year of " + birthyear);

remainyear = prompt("Enter the number of years you expect to study in the college: ");
gradyear = Year + parseInt(remain,10);

console.log("You will graduate from Seneca college in the year of " + gradyear);

/*****************************
*Task 3
*****************************/

var cel,far, fuTemp, cTemp;

cel = prompt("Enter the temperature in Celsius: ");
far = (parseInt(cel,10) * 9/5) + 32;

console.log(cel + "°C is " + far);

nfar = prompt("Enter the temperature in Fahrenheit: ");
ncel = (parseInt(nfar,10)-32) * 5/9;

console.log(nfar + "°F is " + ncel);


/*****************************
*Task 4
*****************************/

for(var i = 0; i <= 10; i++)
{
     if(i%2==0)
          console.log(i + " is even");
     else if(i%2==1)
	 {
          console.log(i + " is odd");
	 }
	 else if(i=0)
	 {
		 console.log(i + " is even");
	 }
}

/*****************************
*Task 5
*****************************/

/*declaration approach*/
function largerNum(a,b)
{
    if(a>b)
        return a;
    else
        return b;
}

/*expression approach*/
var greaterNum = function(a,b)
{
    if(a>b)
        return a;
    else
        return b;
}

//output
console.log("The large number of 5 and 12 is " + largerNum(5,12));
console.log("The large number of 5 and 12 is " + greaterNum(5,12));

/*****************************
*Task 6
*****************************/

function Evaluator()
{
    if ( ! arguments.length )
        return false;
 
    var sum = 0;
    for(var i in arguments)
        sum += arguments[i];
 
    var average = sum / arguments.length;
    return average >= 50;
}
 
console.log("Average greater than or equal to 50: " + Evaluator(50));
console.log("Average greater than or equal to 50: " + Evaluator(10,60,20,70));
console.log("Average greater than or equal to 50: " + Evaluator(55,40,99));

/*****************************
*Task 7
*****************************/
function Grader(numberscore)
{
  var score = parseInt(numberscore);
  
  if (score >= 80 && score <= 100)
    return 'A';
  if(score >= 70 && score <= 79)
    return 'B';
  if(score >= 60 && score <= 69)
    return 'C';
  if(score >= 50 && score <= 59)
    return 'D';
  if(score >= 0 && score <= 49)
    return 'F';
}

console.log(" " + Grader(91));
console.log(" " + Grader(75));
console.log(" " + Grader(54));


/*****************************
*Task 8
*****************************/

function showMultiples(num, numMultiples)
{
  for(var i = 1; i <= numMultiples; i++)
    {
      console.log(num + " * " + i + " = " + (num * i ));
    }
}

var first, multiplier;

for(var i = 0; i < 3; i++)
  {
    first = prompt("Enter the first number: ");
    multiplier = prompt("Enter the multiplier: ");
    first = parseInt(first);
    multiplier = parseInt(multiplier);
    
    showMultiples(first,multiplier);
  }