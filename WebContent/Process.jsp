<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.net.*" %>
<%@ page import="org.apache.commons.io.FilenameUtils" %>
<%@ page import="java.io.*" %>    
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration</title>
</head>
<body>
<%
String name = request.getParameter("clientName");
String email = request.getParameter("clientEmail");
String phoneNo = request.getParameter("clientPhone");
String username = request.getParameter("clientUsername");
String passwordImage1 = "C:\\"+"\\Users\\"+"\\devan\\"+"\\Downloads\\"+"\\Pictures\\"+"\\"+request.getParameter("img1");
String passwordImage2 = "C:\\"+"\\Users\\"+"\\devan\\"+"\\Downloads\\"+"\\Pictures\\"+"\\"+request.getParameter("img2");
String passwordImage3 = "C:\\"+"\\Users\\"+"\\devan\\"+"\\Downloads\\"+"\\Pictures\\"+"\\"+request.getParameter("img3");
String passwordImage4 = "C:\\"+"\\Users\\"+"\\devan\\"+"\\Downloads\\"+"\\Pictures\\"+"\\"+request.getParameter("img4");

String connectionUrl = "jdbc:mysql://localhost:3306/test";
String dbUser = "root";
String dbPwd = "devang12";
Connection conn;
ResultSet rs;

try
{
conn = DriverManager.getConnection(connectionUrl, dbUser, dbPwd);
Statement stmt = conn.createStatement();
String queryString = "insert into useracc values('"+username+"','"+passwordImage1+"','"+passwordImage2+"','"+passwordImage3+"','"+passwordImage4+"','"+email+"','"+phoneNo+"','"+name+"')";
int i = stmt.executeUpdate(queryString);
if( i!= 0)
{
	out.println("You have been Successfully Registered!");
	out.println("Go to the Login Page.<br><a href='Login.html'>Click here to Login.</a>");
}
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</body>
</html>