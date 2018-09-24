var filterType = ""; // sets the filter type to "" (will later be dog, cat or bird)
var filterAgeMin = 0; // sets the filter age min to 0 (for no minimum age filter)
var filterAgeMax = Number.MAX_VALUE; // sets the filter age max to the largest number possible (for no maximum age filter)

window.onload = loadTableWithFilters; 
function loadTableWithFilters() 
{
	document.querySelector("#main-table-body").innerHTML = '';
	
	for (var i = 0; i < petData.length; i++) 
	{
		document.querySelector("#main-table-body")
		if ((filterType == petData[i].type || filterType == "") && petData[i].age >= filterAgeMin && petData[i].age <= filterAgeMax)
			{
				var tdContainer1 = document.createElement("td");
				var imgSource = document.createElement("img");
    
				imgSource.setAttribute("src", petData[i].image.src);
				imgSource.setAttribute("alt", petData[i].image.alt);
				imgSource.setAttribute("width", petData[i].image.width);
				imgSource.setAttribute("height", petData[i].image.height);
				tdContainer1.appendChild(imgSource);
				
				var tr = document.createElement("tr");
				tr.appendChild(tdContainer1);
     
				var tdContainer2 = document.createElement("td");
				tdContainer2.setAttribute("style", "text-align:center;");
     
				var header4 = document.createElement("h4");
				var name = document.createTextNode(petData[i].name);
				header4.appendChild(name);
				tdContainer2.appendChild(header4);
     
				var p = document.createElement("p");
				p.innerHTML = petData[i].description.toString();
				tdContainer2.appendChild(p);
     
				var span = document.createElement("span");
				var age = document.createTextNode("Age: " + petData[i].age + " years old.");
				span.appendChild(age);
				tdContainer2.appendChild(span);
				tr.appendChild(tdContainer2);
     
				document.querySelector("#main-table-body").appendChild(tr);
    }
  }
};

function filterDog() 
{ 
	filterType = "dog";
	loadTableWithFilters();
};

function filterCat() 
{ 
	filterType = "cat";
	loadTableWithFilters();
};

function filterBird() 
{
	filterType = "bird";
	loadTableWithFilters();
};

function filter_zero_1() 
{    
	filterAgeMin = 0;
	filterAgeMax = 1;
	loadTableWithFilters();
};

function filter_1_3() 
{
	filterAgeMin = 1;
	filterAgeMax = 3;
	loadTableWithFilters();
};

function filter_4_plus() 
{
	filterAgeMin = 4;
	filterAgeMax = Number.MAX_VALUE;
	loadTableWithFilters();
};

function filterAllPets() 
{
	var filterType = "";
	var filterAgeMin = 0;
	var filterAgeMax = Number.MAX_VALUE;
	loadTableWithFilters();
};