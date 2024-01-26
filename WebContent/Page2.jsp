<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>    
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,
java.io.IOException,
java.io.PrintWriter,
java.util.Random,
javax.servlet.*,
javax.servlet.ServletException,
javax.servlet.http.HttpServlet,
javax.servlet.annotation.WebServlet,
javax.servlet.http.HttpServletRequest,
javax.servlet.http.HttpServletResponse"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Page-2 : GRIDS</title>
<div id="countdown" style="color: red; font-family: Titillium Web, Arial; font-size: 40px; font-weight: bold; padding: 5px; position: relative; left: 60%; background-color: yellow; width: 35%;"></div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script>
//Countdown Timer starts
function countdown( elementName, minutes, seconds)
{
	var element, endTime, hours, mins, msLeft, time;
	
	function twoDigits( n )
	{
		return( (n <= 9) ? ("0" + n) : n );
	}
	
	function updateTimer()
	{
		msLeft = endTime - (+new Date);
		if (msLeft <1000 )
		{
			element.innerHTML = "Countdown's Over";
			var timeflag = 1;
			document.getElementById("time").value = timeflag;
		}
		else
		{
			time = new Date( msLeft );
			hours = time.getUTCHours();
			mins = time.getUTCMinutes();
			element.innerHTML = "Time Remaining : " + (hours ? hours + ':' + twoDigits( mins) : mins) + ':' + twoDigits( time.getUTCSeconds() );
			setTimeout(updateTimer, time.getUTCMilliseconds() + 500 );
		}
	}
	
	element = document.getElementById( elementName );
	endTime = (+new Date) + 1000*(60*minutes + seconds) + 500;
	updateTimer();
}
countdown("countdown", 5, 0);
// Countdown Timer Ends
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
var count = 0;
$(document).ready(function(){
	var p1,p2,p3,p4,userInput;
	$(".batch1").change(function(){
		p1 = $('#password1').val();
		p2 = $('#password2').val();
		p3 = $('#password3').val();
		p4 = $('#password4').val();
		count++;
		if(count > 7)
		{
			document.location.replace("LastPageWrong.html");
		}	
		userInput = p1+p2+p3+p4;
		var pn1 = document.getElementById("password1");
		var pn2 = document.getElementById("password2");
		var pn3 = document.getElementById("password3");
		var pn4 = document.getElementById("password4");

		if(p1 !== pn1.defaultValue && p2 !== pn2.defaultValue && p3 !== pn3.defaultValue && p4 !== pn4.defaultValue)
		{
		alert("GET Request Sent!");
		$.get('http://localhost:8085/MFIBUAT/Page2.jsp',
		{
			pass1 : p1,
			pass2 : p2,
			pass3 : p3,
			pass4 : p4,
		},
		function(data,status){
			document.getElementById("firsthalfuserInput").value = userInput;
			myFunction(userInput);
		});
		}
	});
});
</script>

<script type="text/javascript">
var o1 = Math.floor(Math.random()*10);
var o2 = Math.floor(Math.random()*10);
var o3 = Math.floor(Math.random()*10);
var o4 = Math.floor(Math.random()*10);
var smsOTP = ""+o1+o2+o3+o4;
//Extracting form values to validate password
function myFunction(userData) {
	var value =document.getElementById("genInput").value;
	var phone = document.getElementById("userPhoneNo").value;
	var timeOut = document.getElementById("time").value;
	if(timeOut === "0")
	{
		if(value===userData)
		{
			alert("Your OTP is : "+smsOTP+" to phone No "+phone);
			var settings = {
					  "async": true,
					  "crossDomain": true,
					  "url": "http://2factor.in/API/V1/c11f76af-286a-11e8-a895-0200cd936042/SMS/"+phone+"/"+smsOTP,
					  "method": "GET",
					  "headers": {
					    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
					  },
					  "data": {}
					}
	
					$.ajax(settings).done(function (response) {
					  console.log(response);
					});
		}
		else
		{
			alert("Wrong Password");
		}
	}
	else
	{
		alert("SERVER TIMEOUT!");
		document.location.replace("LastPageWrong.html");
	}
}

function submitFunction(){
	
	var d5 =document.getElementById("password5").value;
	var d6 =document.getElementById("password6").value;
	var d7 =document.getElementById("password7").value;
	var d8 =document.getElementById("password8").value;
	var abc = document.getElementById("firsthalfuserInput").value;
	var value2 =document.getElementById("genInput").value;
	var userPassword = ""+abc+d5+d6+d7+d8;
	var generatedPassword = value2+smsOTP;
	var timeOut = document.getElementById("time").value;
	alert("User Password : "+userPassword+"\nGenerated Password : "+generatedPassword+"\nTimeout : "+timeOut);
	if(timeOut === "0")
	{
		if(generatedPassword === userPassword)
			{
				document.location.replace('LastPageRight.html');
			}
		else
			{
				document.location.replace("LastPageWrong.html");
			}
	
	}
	else
	{
		alert("SERVER TIMEOUT!");
		document.location.replace("LastPageWrong.html");
	}
}
</script>


</head>
<body>
<link href="https://fonts.googleapis.com/css?family=Titillium+Web" rel="stylesheet">
<%! //Sets when Countdown Timer hits 0
	int pass1,pass2,pass3,pass4,pass5,pass6,pass7,pass8; // form elements making up the password
	int d1,d2,d3,d4; //Last 4 digits of password and also the sent OTP
%>

<%
int mappingnum1=0,mappingnum2=0,mappingnum3=0,mappingnum4=0,mappingnum5=0,mappingnum6=0,mappingnum7=0,mappingnum8=0; //inprocess temporary mapping variales 
int mapped1=0,mapped2=0,mapped3=0,mapped4=0, no1=0,no2=0; //Processed variables to store password which are used later to compare with user input
//Database Connection
String connectionUrl = "jdbc:mysql://localhost:3306/test";
String dbUser = "root";
String dbPwd = "devang12";
Connection conn;
ResultSet rs,rs1;
ArrayList<Integer> arr= new ArrayList<Integer>();
String username = request.getParameter("hiddenUsername");
String passpath1="";
String userPhone="";
try
{
conn = DriverManager.getConnection(connectionUrl, dbUser, dbPwd);
Statement stmt = conn.createStatement();
Statement stmt2 = conn.createStatement();
out.print("<div id='IG' style='display: inline-block; padding-bottom: 100px'>");
out.print("<table border='2'>");
//Random Image Generation Grid
for(int i=0;i<5;i++)	 
{	
	out.print("<tr>");
	for(int j=0;j<5;j++)
	{
		Random rn=new Random();
		int num = rn.nextInt(25)+1;
		boolean chk = arr.contains(num);
		if(chk == false)
		{
			arr.add(num);
			passpath1 = "select image1,image2,image3,image4 from useracc where username = '"+username+"';";
			rs1 = stmt2.executeQuery(passpath1);
			while(rs1.next())
			{
			String queryString = "select * from imagegrid where num="+num+";";
			rs = stmt.executeQuery(queryString);
			while(rs.next())
			{
				no1=rn.nextInt(10);
				no2=rn.nextInt(10);
				out.print("<td> <img src='"+ rs.getString(2)+"' alt='image.jpg' style='width:100px; height:100px;'><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+no1+"&nbsp;&nbsp;&nbsp;"+no2+"</td>");
				
				if((rs.getString(2)).equals(rs1.getString(1)))
				{
					mappingnum1 = no1;
					mappingnum2 = no2;
				}
				else if((rs.getString(2)).equals(rs1.getString(2)))
				{
					mappingnum3 = no1;
					mappingnum4 = no2;
				}
				else if((rs.getString(2)).equals(rs1.getString(3)))
				{
					mappingnum5 = no1;
					mappingnum6 = no2;
				}
				else if((rs.getString(2)).equals(rs1.getString(4)))
				{
					mappingnum7 = no1;
					mappingnum8 = no2;
				}
			}
			}
		}
		else
		{
			j--;
		}
	}
	out.print("</tr>");
}
out.print("</table>");

//Displaying user pasword images( Temporary)
passpath1 = "select image1,image2,image3,image4,phoneNo from useracc where username = '"+username+"';";
rs1 = stmt2.executeQuery(passpath1);
while(rs1.next())
{
	/*out.print("<td> <img src='"+ rs1.getString(1)+"' alt='image.jpg' style='width:100px; height:100px;'><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
	out.print("<td> <img src='"+ rs1.getString(2)+"' alt='image.jpg' style='width:100px; height:100px;'><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
	out.print("<td> <img src='"+ rs1.getString(3)+"' alt='image.jpg' style='width:100px; height:100px;'><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
	out.print("<td> <img src='"+ rs1.getString(4)+"' alt='image.jpg' style='width:100px; height:100px;'><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>"); */
	userPhone = rs1.getString(5);	
}
out.print("</div>");
} 
catch (Exception e){ System.out.println(e.getMessage());}
//Generating Random Number Grid
Random rnn = new Random();
out.print("<div id='NG' style='display: inline-block; padding: 0px 0px 300px 200px;'>");
out.print("<table border='1' cellpadding='5'>");
int gridnum=0;
out.println("<b><th></th> <th>0</th> <th>1</th> <th>2</th> <th>3</th> <th>4</th> <th>5</th> <th>6</th> <th>7</th> <th>8</th> <th>9</th></b>");
for(int i=0;i<10;i++)
{
	out.println("<tr>");
	out.println("<td><b>"+gridnum+"</b></td>");
	//Mapping numbers
	for(int j=0;j<10;j++)
	{
		int num = rnn.nextInt(10);
		out.println("<td>"+num+"</td>");
		if(i == mappingnum1 && j == mappingnum2)
		{
			mapped1 = num;
		}
		if(i == mappingnum3 && j == mappingnum4)
		{
			mapped2 = num;
		}
		if(i == mappingnum5 && j == mappingnum6)
		{
			mapped3 = num;
		}
		if(i == mappingnum7 && j == mappingnum8)
		{
			mapped4 = num;
		}
	}
	out.println("</tr>");
	gridnum++;
}
out.println("</table>");
out.println("</div>");
//form for inputting password
out.println("<div id='password' style=' display: block; position: absolute; left: 30%;'>");
out.println("<h1 style=' position: absolute; top: -120%; left: 18%; font-family: Titillium Web;'>PASSWORD</h1>");
out.println("<form method='POST'>");
out.println("&nbsp;&nbsp;&nbsp;&nbsp; <input type='number' class='batch1' id='password1' maxlength='1' max='9' style=' width: 1%; padding: 12px 12px; margin: 8px 0px; border: none; border-bottom: 2px solid red;'>");
out.println("&nbsp;&nbsp;&nbsp;&nbsp; <input type='number' class='batch1' id='password2' maxlength='1' max='9' style=' width: 1%; padding: 12px 12px; margin: 8px 0px; border: none; border-bottom: 2px solid red;'>");
out.println("&nbsp;&nbsp;&nbsp;&nbsp; <input type='number' class='batch1' id='password3' maxlength='1' max='9' style=' width: 1%; padding: 12px 12px; margin: 8px 0px; border: none; border-bottom: 2px solid red;'>");
out.println("&nbsp;&nbsp;&nbsp;&nbsp; <input type='number' class='batch1' id='password4' maxlength='1' max='9' style=' width: 1%; padding: 12px 12px; margin: 8px 0px; border: none; border-bottom: 2px solid red;'>");

out.println("&nbsp;&nbsp;&nbsp;&nbsp; <input type='number' id='password5' maxlength='1' max='9' style=' width: 1%; padding: 12px 12px; margin: 8px 0px; border: none; border-bottom: 2px solid red;'>");
out.println("&nbsp;&nbsp;&nbsp;&nbsp; <input type='number' id='password6' maxlength='1' max='9' style=' width: 1%; padding: 12px 12px; margin: 8px 0px; border: none; border-bottom: 2px solid red;'>");
out.println("&nbsp;&nbsp;&nbsp;&nbsp; <input type='number' id='password7' maxlength='1' max='9' style=' width: 1%; padding: 12px 12px; margin: 8px 0px; border: none; border-bottom: 2px solid red;'>");
out.println("&nbsp;&nbsp;&nbsp;&nbsp; <input type='number' id='password8' maxlength='1' max='9' style=' width: 1%; padding: 12px 12px; margin: 8px 0px; border: none; border-bottom: 2px solid red;'>");
out.println("&nbsp;&nbsp;&nbsp;&nbsp; <input type='button' value='Submit' onClick='submitFunction()'>");
out.println("</form>");
out.println("</div>");
out.println("<p id='result1'></p>");
out.println("<p id='result2'></p>");
out.println("<p id='result3'></p>");
out.println("<p id='result4'></p>");
out.println("<div id='displayarea'>");
out.println("<p>"+mapped1+"<p>"+mapped2+"<p>"+mapped3+"<p>"+mapped4); //TEMPORARY
String genInput = ""+mapped1+mapped2+mapped3+mapped4;
out.println("</div>");
%>
<input type='hidden' id='genInput' value='<%=genInput%>' />
<input type='hidden' id='firsthalfuserInput' />
<input type='hidden' id='time' value='0'/>
<input type='hidden' id='userPhoneNo' value='<%=userPhone%>' />
</body>
</html>