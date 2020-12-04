<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="util.Gmail" %>
<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 서비스입니다.');");
		script.println("location.href='userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if(emailChecked == true){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 회원정보입니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	// 사용자에게 보낼 메시지
	String host = "http://localhost:8080/Professor_Evaluation/";
	String from = "testkjmin@gmail.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "평가를 위한 확인 이메일입니다.";
	String content = "다음 링크에 접속하여 지시대로 진행하세요." +
		"<a href='" + host + "emailCheckedAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
		
	// SMTP에 접속하기 위한 정보
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	
	try{
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF-8");
		Transport.send(msg);
	} catch(Exception e){
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		
		return;
	}
%>
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
<nav class="navbar navbar-expand-lg navbar-light bg-primary">
      <a class="navbar-brand text-white" href="Index.jsp">교수평가</a>
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
              <a class="dropdown-item" href="userLogin.jsp">로그인</a>
            </div>
          </li>
        </ul>
      </div>
    </nav>
	<div class="container">
	    <div class="alert alert-success mt-4" role="alert">
		  이메일 주소 인증 메일이 전송되었습니다. 이메일에 들어가셔서 인증해주세요.
		</div>
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