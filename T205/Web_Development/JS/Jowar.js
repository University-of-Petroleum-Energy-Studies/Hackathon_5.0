var number_1 = Number(document.getElementById("number_1").value);
var number_2 = Number(document.getElementById("number_2").value);
var radius = Number(document.getElementById("radius").value);
function calculate() {
  number_1 =     Number(document.getElementById("number_1").value);
  number_2 =     Number(document.getElementById("number_2").value);
  radius =       Number(document.getElementById("radius").value);
  
if(number_1>0 && number_2>0)
{
  var area = number_1 * number_2;
  var perimeter =2 * (number_1 + number_2);
  var price = area * 3200;
}
else if(radius > 0)
{
  var perimeter = Math.round(2 * 3.14 *radius);
  var area = Math.round(3.14 * radius * radius);
  var price = area * 3200;
}
  
  
  document.getElementById("lblarea").innerHTML = area;
  
  document.getElementById("lblperimeter").innerHTML = perimeter;

  document.getElementById("price").innerHTML = price;
}