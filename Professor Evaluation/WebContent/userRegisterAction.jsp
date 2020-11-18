<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	
	if(request.getParameter("userID") != null){
		userID = (String) request.getParameter("userID");
	}
	
	if(request.getParameter("userPassword") != null){
		userPassword = (String) request.getParameter("userPassword");
	}
	
	if(request.getParameter("userEmail") != null){
		userEmail = (String) request.getParameter("userEmail");
	}
	
	if(userID == null || userPassword == null || userEmail == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('필수사항을 입력해주세요.');");
		script.println("history.back(;)");
		script.println("</script>");
		script.close();
	} else{
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('중복된 아이디입니다.');");
			script.println("history.back(;)");
			script.println("</script>");
			script.close();
		} else{
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("loaction.href = 'emailSendAction.jsp';");
			script.println("</script>");
			script.close();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>