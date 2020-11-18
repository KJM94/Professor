<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
              <a class="dropdown-item" href="userLogin.jsp">로그인</a>
            </div>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form>
      </div>
    </nav>
    
    <div class="container">
    	<div class="alert alert-success mt-4" role="alert">
    		이메일 인증 메일이 전송되었습니다. 확인해주세요.
    	</div>
    
    </div>
    
        <div class="container">
      <form method="get" action="./index.jsp" class="form-inline mt-3">
        <select name="lectureDivide" class="form-control mx-1 mt-2">
          <option value="전체">전체</option>
          <option value="제목">제목</option>
          <option value="내용">내용</option>
        </select>
        <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
        <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
        <a class="btn btn-danger ml-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
      </form>
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left">우도균&nbsp;<small>(2017년 가을학기)</small></div>
          </div>
        </div>
        <div class="card-body">
          <p class="card-text">강의가 많이 널널해서, 솔직히 많이 배운 건 없는 것 같지만 학점도 잘 나오고 너무 좋은 것 같습니다.</p>
          <div class="row">
            <div class="col-9 text-left">
              평가 <span style="color: red;">A</span>
              <span style="color: green;">(추천: 15★)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
            </div>
          </div>
        </div>
      </div>
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left">우도균&nbsp;<small>(2017년 가을학기)</small></div>
          </div>
        </div>
        <div class="card-body">
          <p class="card-text">강의가 많이 널널해서, 솔직히 많이 배운 건 없는 것 같지만 학점도 잘 나오고 너무 좋은 것 같습니다.</p>
          <div class="row">
            <div class="col-9 text-left">
              평가 <span style="color: red;">A</span>
              <span style="color: green;">(추천: 15★)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
            </div>
          </div>
        </div>
      </div>
     <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left">우도균&nbsp;<small>(2017년 가을학기)</small></div>
          </div>
        </div>
        <div class="card-body">
          <p class="card-text">강의가 많이 널널해서, 솔직히 많이 배운 건 없는 것 같지만 학점도 잘 나오고 너무 좋은 것 같습니다.</p>
          <div class="row">
            <div class="col-9 text-left">
              평가 <span style="color: red;">A</span>
              <span style="color: green;">(추천: 15★)</span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
              <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
            </div>
          </div>
        </div>
      </div> 
    </div>
    <ul class="pagination justify-content-center mt-3">
      <li class="page-item">
        <a class="page-link" href="#">이전</a>
      </li>
      <li class="page-item">
        <a class="page-link" href="#">다음</a>
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
		<script src="./js/jquery.min.js"></script>
		
		<!-- popper js 추가 -->
		<script src="./js/popper.min.js"></script>
		
		<!-- bootstrap js 추가 -->
		<script src="./js/bootstrap.min.js"></script>
		
</body>
</html>
