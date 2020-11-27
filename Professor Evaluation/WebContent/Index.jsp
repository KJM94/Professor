<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교수평가</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- 커스텀 CSS -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("lectureDivide") != null){
		lectureDivide = request.getParameter("lectureDivide");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null){
		try{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}catch(Exception e){
			System.out.println("검색 오류 발생");
		}
	}
	

	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();	
	}
	
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);

	if(emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp'");
		script.println("</script>");
		script.close();		
		return;
	}
%>

	<nav class="navbar navbar-expand-lg navbar-light bg-secondary">
      <a class="navbar-brand" href="Index.jsp">교수평가</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbar">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="Index.jsp">메인</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
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
        <div class="container">
      <form method="get" action="./Index.jsp" class="form-inline mt-3">
        <select name="lectureDivide" class="form-control mx-1 mt-2">
          <option value="전체">전체</option>
          <option value="메카"<%if(lectureDivide.equals("메카")) out.println("selected"); %>>메카</option>
          <option value="기계"<%if(lectureDivide.equals("기계")) out.println("selected"); %>>기계</option>
          <option value="전기"<%if(lectureDivide.equals("전기")) out.println("selected"); %>>전기</option>
        </select>
        <select name="searchType" class="form-control mx-1 mt-2">
        	<option value="최신순">최신순</option>
        	<option value="추천순" <%if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
        </select>
        <input type="text" name="search" class="form-control mx-1 mt-2" value="<%= search %>"placeholder="내용을 입력하세요.">
        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
        <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
        <a class="btn btn-danger ml-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
      </form>
<%
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	if(evaluationList != null)
		for(int i =0; i<evaluationList.size(); i++){
			if(i==5) break;
			EvaluationDTO evaluation = evaluationList.get(i);
		
%>
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left"><%=evaluation.getProfessorName() %>&nbsp;
            <small><%=evaluation.getLectureYear() %>	<%=evaluation.getSemesterDivide() %>	<span style="color: blue;"><%=evaluation.getLectureDivide() %></span></div></small>
          </div>
        </div>
        <div class="card-body">
          <p class="card-text">
          <%=evaluation.getEvaluationContent() %>
          </p>
          <div class="row">
            <div class="col-9 text-left">
              평가 <span style="color: red;"><%=evaluation.getScore() %></span>
              <span style="color: green;">(추천 : <%=evaluation.getLikeCount() %>)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID() %>">추천</a>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID() %>">삭제</a>
            </div>
          </div>
        </div>
      </div>
      <%
      		}
      %>
     
    </div>
    <ul class="pagination justify-content-center mt-3">
      <li class="page-item">
      <%
      		if(pageNumber <= 0){
      %>
        <a class="page-link disabled">이전</a>
        <%
      		} else{
        %>
        <a class="page-link" href="./Index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%=pageNumber -1 %>">이전</a>
        <%
      		}
        %>
      </li>
      <li class="page-item">
      <%
      		if(evaluationList.size() < 6){
      %>
        <a class="page-link disabled">다음</a>
      <%
      		} else{
      %>
      <a class="page-link" href="./Index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8")%>&searchType=<%=URLEncoder.encode(searchType, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%=pageNumber +1 %>">다음</a>
      <%
      		}
      %>
      </li>
    </ul>
    <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal">평가 등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="./evaluationRegisterAction.jsp" method="post">
              <div class="form-row">
                <div class="form-group col-sm-6">
                  <label>교수명</label>
                  <input type="text" name="professorName" class="form-control" maxlength="20">
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-sm-4">
                  <label>수강 연도</label>
                  <select name="lectureYear" class="form-control">
                    <option value="2011">2011</option>
                    <option value="2012">2012</option>
                    <option value="2013">2013</option>
                    <option value="2014">2014</option>
                    <option value="2015">2015</option>
                    <option value="2016">2016</option>
                    <option value="2017">2017</option>
                    <option value="2018">2018</option>
                    <option value="2019">2019</option>
                    <option value="2020" selected>2020</option>
                    <option value="2021">2021</option>
                    <option value="2022">2022</option>
                    <option value="2023">2023</option>
                  </select>
                </div>
                <div class="form-group col-sm-4">
                  <label>수강 학기</label>
                  <select name="semesterDivide" class="form-control">
                    <option name="1학기" selected>1학기</option>
                    <option name="여름학기">여름학기</option>
                    <option name="2학기">2학기</option>
                    <option name="겨울학기">겨울학기</option>
                  </select>
                </div>
                <div class="form-group col-sm-4">
                <lable>학과 구분</lable>
                <select name="lectureDivide" class="form-control">
                	<option name="메카" selected>메카</option>
                	<option name="기계">기계</option>
                	<option name="전기">전기</option>
                </select>
                </div>
              </div>
              <div class="form-group">
                <label>내용</label>
                <textarea type="text" name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
              </div>
              <div class="form-row">
                <div class="form-group col-sm-3">
                  <label>평가</label>
                  <select name="Score" class="form-control">
                    <option value="A" selected>A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary">등록하기</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal">신고하기</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form method="post" action="./reportAction.jsp">
              <div class="form-group">
                <label>신고 제목</label>
                <input type="text" name="reportTitle" class="form-control" maxlength="20">
              </div>
              <div class="form-group">
                <label>신고 내용</label>
                <textarea type="text" name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-danger">신고하기</button>
              </div>
            </form>
          </div>
        </div>
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