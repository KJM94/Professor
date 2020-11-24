package evaluation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EvaluationDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public EvaluationDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/ProfessorEvaluation?serverTimezone=Asia/Seoul&useSSL=false";
			String dbID = "root";
			String dbPassword = "4651";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int write(EvaluationDTO evaluationDTO) {
		PreparedStatement pstmt = null;
		
		try {
			String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ? ,? ,? ,0);";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID());
			pstmt.setString(2, evaluationDTO.getProfessorName());
			pstmt.setInt(3, evaluationDTO.getLectureYear());
			pstmt.setString(4, evaluationDTO.getSemesterDivide());
			pstmt.setString(5, evaluationDTO.getEvaluationContent());
			pstmt.setString(6, evaluationDTO.getScore());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}

}
