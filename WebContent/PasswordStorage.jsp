<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.net.*" %>
<%@ page import="org.apache.commons.io.FilenameUtils" %>
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
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration</title>
<style>
	
	.image {
	opacity: 1;
	transition: .2s ease;
	backface-visibility: hidden;
	}
	.middle {
	transition: .2s ease;
	opacity: 0;
	top: 50%;
	left: 50%;
	position: absolute;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%,-50%);
	text-align: center;
	}
	
	.image:hover {
	opacity: 0.3;
	}
	
	.image:hover .text {
	opacity: 1;
	}
	
	.text {
	background-color: #4CAF50;
	color: black;
	fontsize: 16px;
	}
	
	.div {
	display: inline;
	}
	
</style>
</head>
<body>
<%!
	String path1,path2,path3,path4,filename;
%>
<script>
var count = 0;
function changeIt(_src, _alt,_name){
	count++;
	name = _alt;
	if(count == 1)
	{
		path1 = _src;
		filename = _name;
		document.getElementById("result1").value = filename;
		document.getElementById("pass1").innerHTML = "You Selected : "+name;
	}
	else if(count == 2)
	{
		path2 = _src;
		filename = _name;
		document.getElementById("result2").value = filename;
		document.getElementById("pass2").innerHTML = "You Selected : "+name;
	}
	else if(count == 3)
	{
		path3 = _src;
		filename = _name;
		document.getElementById("result3").value = filename;
		document.getElementById("pass3").innerHTML = "You Selected : "+name;
	}
	else if(count == 4)
	{
		path4 = _src;
		filename = _name;
		document.getElementById("result4").value = filename;
		document.getElementById("pass4").innerHTML = "You Selected : "+name;
	}
}
</script>
<%
String name = request.getParameter("name");					//IMPORTANT STUFF. DO NOT DELETE!!!
String email = request.getParameter("email");
String phoneNo = request.getParameter("telNo");
String username = request.getParameter("username");
/*
String name = "Devang Katekar";
String email = "devang15.katekar@gmail.com";
String phoneNo = "9822677269";
String username = "devang"; */
int no1,no2;
//Database Connection
String connectionUrl = "jdbc:mysql://localhost:3306/test";
String dbUser = "root";
String dbPwd = "devang12";
Connection conn;
ResultSet rs,rs1;
ArrayList<Integer> arr= new ArrayList<Integer>();
String passpath1="";
try
{
//out.println(path1+"2");
conn = DriverManager.getConnection(connectionUrl, dbUser, dbPwd);
Statement stmt = conn.createStatement();
out.print("<div id='IG' style='display: inline; padding-bottom: 100px'>");
out.print("<table border='2'>");
//Random Image Generation Grid
for(int i=0;i<5;i++)	 
{	
	out.print("<tr>");
	//out.println(path1+"3");
	for(int j=0;j<5;j++)
	{
		//out.println(path1+"4");
		Random rn=new Random();
		int num = rn.nextInt(25)+1;
		boolean chk = arr.contains(num);
		if(chk == false)
		{
			//out.println(path1+"5");
			arr.add(num);
			String queryString = "select * from imagegrid where num="+num+";";
			rs = stmt.executeQuery(queryString);
			while(rs.next())
			{
				no1=rn.nextInt(10);
				no2=rn.nextInt(10);
				out.print("<div class='container'>");
				out.print("<td> <img onclick='path1 = changeIt(this.src,this.alt,this.name)' src='"+ rs.getString(2)+"' class='image' name='"+FilenameUtils.getName(rs.getString(2))+"' alt='"+FilenameUtils.getBaseName(rs.getString(2))+"' style='width:100px; height:100px;'> </td>");
				out.print("<div class='middle'>");
				out.print("<div class='text'>"+FilenameUtils.getName(rs.getString(2))+"</div>");
				out.print("</div");
				out.print("</div");
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
out.print("</div>");
}
catch(Exception e){
	out.println(e.getMessage());
}
%>
<div class="UserSelectedData">
	<p id="pass1"><p>
	<p id="pass2"><p>
	<p id="pass3"><p>
	<p id="pass4"><p>
</div>
<form method="POST" action="Process.jsp">
	<input type="hidden" id="result1" name="img1">
	<input type="hidden" id="result2" name="img2">
	<input type="hidden" id="result3" name="img3">
	<input type="hidden" id="result4" name="img4">
	<input type="hidden" id="userName" name="clientName" value='<%=name%>' />
	<input type="hidden" id="userEmail" name="clientEmail" value='<%=email%>' />
	<input type="hidden" id="userNo" name="clientPhone" value='<%=phoneNo%>' />
	<input type="hidden" id="userID" name="clientUsername" value='<%=username%>' />
	<input type="submit" value="submit">
</form>
</body>
</html>