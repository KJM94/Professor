<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교수 평가</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- 커스텀 CSS -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
	}
%>
<nav class="navbar navbar-expand-lg navbar-light bg-primary">
      <a class="navbar-brand text-white" href="Index.jsp">교수 평가</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbar">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle text-white btn" id="dropdown" data-toggle="dropdown">
              회원 관리
            </a>
            <div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null){
%>
              <a class="dropdown-item" href="userLogin.jsp">로그인</a>
              <a class="dropdown-item" href="userRegister.jsp">회원가입</a>
<%
	} else{
%>
              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
            </div>
          </li>
        </ul>
        
      </div>
    </nav>
    <div class="container mt-3" style="max-width: 560px;">
      <form method="post" action="./userRegisterAction.jsp">
        <div class="form-group">
          <label>아이디</label>
          <input type="text" name="userID" class="form-control">
        </div>
        <div class="form-group">
          <label>비밀번호</label>
          <input type="password" name="userPassword" class="form-control">
        </div>
        <div class="form-group">
          <label>이메일</label>
          <input type="email" name="userEmail" class="form-control">
        </div>
        <button type="submit" class="btn btn-success">회원가입</button>
      </form>
    </div>
    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
      Copyright ⓒ 2020 권정민 All Rights Reserved.
    </footer>

		<!-- jquery js 추가 -->
		<script src="./js/jquery-3.5.1.min.js"></script>
		
		<!-- popper js 추가 -->
		<script src="./js/popper.min.js"></script>
		
		<!-- bootstrap js 추가 -->
		<script src="./js/bootstrap.min.js"></script>
</body>
</html>