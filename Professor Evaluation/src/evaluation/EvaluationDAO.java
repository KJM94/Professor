package evaluation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	public ArrayList<EvaluationDTO> getList(String Score, String searchType, String search, int pageNumber){
		if(Score.equals("전체")) {
			Score = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		PreparedStatement pstmt = null;
		String SQL = "";
		try {
			if(searchType.equals("최신순")) {
				SQL = "SELECT * FROM EVALUATION WHERE Score LIKE ? AND CONCAT(professorName, evaluationContent)"
						+ "LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if(searchType.equals("추천순")) {
				SQL = "SELECT * FROM EVALUATION WHERE Score LIKE ? AND CONCAT(professorName, evaluationContent)"
						+ "LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + Score + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getInt(4),
						rs.getString(5),
						rs.getString(6),
						rs.getString(7),
						rs.getInt(8)
						);
				evaluationList.add(evaluation);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return evaluationList;
	}

}
