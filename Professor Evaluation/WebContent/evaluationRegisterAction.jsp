<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="util.SHA256" %>
<%
	request.setCharacterEncoding("UTF-8");

	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	request.setCharacterEncoding("UTF-8");
	String professorName = null;
	int lectureYear = 0;
	String semesterDivide = null;
	String evaluationContent = null;
	String Score = null;
	
	if(request.getParameter("professorName") != null){
		professorName = (String) request.getParameter("professorName");
	}
	if(request.getParameter("lectureYear") != null){
		try{
			lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
		} catch(Exception e){
			System.out.println("강의 연도 데이터 오류");
		}
	}
	if(request.getParameter("semesterDivide") != null){
		semesterDivide = (String) request.getParameter("semesterDivide");
	}
	if(request.getParameter("evaluationContent") != null){
		evaluationContent = (String) request.getParameter("evaluationContent");
	}
	if(request.getParameter("Score") != null){
		Score = (String) request.getParameter("Score");
	}
	
	if(professorName == null || lectureYear == 0 || semesterDivide == null || evaluationContent == null || Score == null ||
			evaluationContent.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력하지 않은 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else{
		EvaluationDAO evaluationDAO = new EvaluationDAO();
		int result = evaluationDAO.write(new EvaluationDTO(0, userID, professorName, lectureYear, semesterDivide, evaluationContent, Score, 0));
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('평가 등록에 실패하였습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		} else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='./Index.jsp';");
			script.println("</script>");
			script.close();
			return;
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