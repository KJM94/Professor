<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="likey.LikeyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%!
	public static String getClientIP(HttpServletRequest request){
	String ip = request.getHeader("X-FORWARDED-FOR");
	if(ip == null || ip.length() == 0){
		ip = request.getHeader("Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0){
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0){
		ip = request.getRemoteAddr();
	}
	return ip;
}
%>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 서비스입니다.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String evaluationID = null;
	if(request.getParameter("evaluationID") != null){
		evaluationID = (String) request.getParameter("evaluationID");
	}
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	
	int result = likeyDAO.like(userID, evaluationID, getClientIP(request));
	if(result == 1){
		result = evaluationDAO.like(evaluationID);
		
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천하였습니다.');");
			script.println("location.href='Index.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('db오류발생.');");
			script.println("histroy.back();");
			script.println("</script>");
			script.close();
			
		}
	} else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 추천된 강의평가입니다.');");
		script.println("histroy.back();");
		script.println("</script>");
		script.close();
		
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