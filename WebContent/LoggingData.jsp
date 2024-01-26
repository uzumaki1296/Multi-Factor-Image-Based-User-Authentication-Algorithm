<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String username = request.getParameter("username");
String phoneNo = request.getParameter("telNo");

try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","devang12");
	String sql = "select * from useracc where username='"+username+"' and phoneNo='"+phoneNo+"'";
	Statement stmt= conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
	if(!rs.next())
	{
		String redirect1 = new String("WrongCombination.html");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location",redirect1);
		//out.println("Wrong Username or PhoneNo combination. Try Again!");  
    }
	else
	{
		out.println("<h2> Welcome "+rs.getString(8)+",</h2><br><h3>You will now be taken to the Password Selection Page.</h3>");
		out.println("<br><h3> Please make sure that you are connected to the Internet before proceeding.");
		String redirect2 = new String("Page2.jsp");
		out.println("<form method='get' action='Page2.jsp'>");
		out.println("<input type='hidden' name='hiddenUsername' value='"+username+"' />");
		out.println("<input type='submit' value='GO to Next page'>");
		out.println("</form>");
		
	}
} 
catch (Exception e)
{
        out.println(e);
}
%>
</body>
</html>