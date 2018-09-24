// set a global httpRequest object

var httpRequest;
		
// TODO: when the page (window) has loaded, make a
// request for page 1

window.onload = makeRequest(1);



function makeRequest(pageNum) {
	
    // TODO: create a variable "url" to store the request to 
	// the current pageNum, ie:
	// 		"https://reqres.in/api/users?page=1" // for page 1
	// 		"https://reqres.in/api/users?page=2" // for page 2
	// 		etc...
	
	var url = ["https://reqres.in/api/users?page=1", "https://reqres.in/api/users?page=2", "https://reqres.in/api/users?page=3", "https://reqres.in/api/users?page=4"];

	if (pageNum == 1)
	{
		url = "https://reqres.in/api/users?page=1";
	}
	else if (pageNum == 2)
	{
		url = "https://reqres.in/api/users?page=2";
	}
	else if (pageNum == 3)
	{
		url = "https://reqres.in/api/users?page=3";
	}
	else if (pageNum == 4)
	{
		url = "https://reqres.in/api/users?page=4";
	}


	
	// make an HTTP request object
	
	httpRequest = new XMLHttpRequest();

	// execute the "showContents" function when
	// the httprequest.onreadystatechange event is fired
	
	httpRequest.onreadystatechange = showContents;
	
	// open a asynchronous HTTP (GET) request with the specified url
	
	httpRequest.open('GET', url, true);
	
	// send the request
	
	httpRequest.send();
}

// the function that handles the server response

function showContents() {

//  check for response state
//  0      The request is not initialized
//  1      The request has been set up
//  2      The request has been sent
//  3      The request is in process
//  4      The request is complete

	if (httpRequest.readyState === 4) {
		// check the response code
		if (httpRequest.status === 200) { // The request has succeeded
		    // Just for debugging. 
			console.log(httpRequest.responseText);
			
			// Javascript function JSON.parse to parse JSON data
			var jsData = JSON.parse(httpRequest.responseText);
			
			// TODO: use the jsData object to populate the correct
			// table cells, ie <tr><td>...</td></tr>
			// in the <tbody> element with id="data"
			
			var i = 0;
			
			document.getElementById("data").innerHTML = "";
			
			for(i = 0; i < jsData.data.length; i++)
			{
				//to populate the correct 'tr' elements
				var trEle = document.createElement("tr");
				
				//to populate the correct 'td' elements with respect to JSON data
				var tdEle_id = document.createElement("td");
				var tdEle_fName = document.createElement("td");
				var tdEle_LName = document.createElement("td");
				var tdEle_img = document.createElement("td");
				
				//to populate the correct 'img' elements
				var Ele_img = document.createElement("img");

				//to populate the correct 'data ID' elements with td elements
				var data_id = document.createTextNode(jsData.data[i].id);
				tdEle_id.appendChild(data_id);

				//to populate the correct First Names with td elements
				var data_firstName = document.createTextNode(jsData.data[i].first_name);
				tdEle_fName.appendChild(data_firstName);

				//to populate the correct Last Names with td elements
				var data_lastName = document.createTextNode(jsData.data[i].last_name);
				tdEle_LName.appendChild(data_lastName);

				//to set correct attributes, the JS data to avatar elements
				Ele_img.setAttribute("src", jsData.data[i].avatar);
				Ele_img.setAttribute("alt", "Images are not found");

				//to populate the correct image data with td elements
				tdEle_img.appendChild(Ele_img);
				
				//to populate the correct id, first names, last names, and image data with tr elements
				trEle.appendChild(tdEle_id);
				trEle.appendChild(tdEle_fName);
				trEle.appendChild(tdEle_LName);
				trEle.appendChild(tdEle_img);

				document.getElementById("data").appendChild(trEle);
			}
		} 
		else 
		{
			console.log('The request cannot not be loaded');
		}
	}
}	