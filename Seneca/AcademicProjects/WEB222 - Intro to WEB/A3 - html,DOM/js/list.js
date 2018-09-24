// Data for the "HTML Lists" Page

var fruits = [ "Apples","Oranges","Pears","Grapes","Pineapples","Mangos" ];

var directory = [
    {type: "file", name: "file1.txt"},
    {type: "file", name: "file2.txt"},
    {type: "directory", name: "HTML Files", files: [{type: "file", name: "file1.html"},{type: "file", name: "file2.html"}]},
    {type: "file", name: "file3.txt"},
    {type: "directory", name: "JavaScript Files", files: [{type: "file", name: "file1.js"},{type: "file", name: "file2.js"},{type: "file", name: "file3.js"}]}
];


window.onload = function () 
{
    var favFruitsName = document.querySelector("#FruitList");
    var fruitList = numberedList(fruits);
    favFruitsName.innerHTML += "<ol>" + fruitList + "</ol>";
	
    var directoryName = document.querySelector("#directList");
    var directoryList = fileContainer(directory);
    directoryName.innerHTML += "<ul>" + directoryList + "</ul>";
};


numberedList = function(object) 
{
    var fruitList = "";
    for (var i = 0; i < object.length; i++) 
	{
        fruitList += "<li>" + object[i] + "</li>";
    }
    return fruitList;
};


fileContainer = function (object) 
{
    var directoryList = ""; 
    for (var j = 0; j < object.length; j++) 
	{
      if (object[j]["type"] === "file") {
          directoryList += "<li>" + object[j]["name"] + "</li>";
      } else {
          directoryList += "<li>" + object[j]["name"] + "</li><ul>";
          directoryList += fileContainer(object[j]["files"]);
          directoryList += "</ul>";
      }
    }
    return directoryList;
};