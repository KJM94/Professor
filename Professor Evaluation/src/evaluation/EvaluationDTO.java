package evaluation;

public class EvaluationDTO {
	
	int evaluationID;
	String userID;
	String professorName;
	int lectureYear;
	String semesterDivide;
	String evaluationContent;
	String Score;
	int likeCount;
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	public int getLectureYear() {
		return lectureYear;
	}
	public void setLectureYear(int lectureYear) {
		this.lectureYear = lectureYear;
	}
	public String getSemesterDivide() {
		return semesterDivide;
	}
	public void setSemesterDivide(String semesterDivide) {
		this.semesterDivide = semesterDivide;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public String getScore() {
		return Score;
	}
	public void setScore(String score) {
		this.Score = score;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public EvaluationDTO(int evaluationID, String userID, String professorName, int lectureYear, String semesterDivide,
			String evaluationContent, String score, int likeCount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.professorName = professorName;
		this.lectureYear = lectureYear;
		this.semesterDivide = semesterDivide;
		this.evaluationContent = evaluationContent;
		this.Score = score;
		this.likeCount = likeCount;
	}

}
