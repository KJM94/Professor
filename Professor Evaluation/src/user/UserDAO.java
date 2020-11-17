package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/ProfessorEvaluation";
			String dbID = "root";
			String dbPassword = "4651";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).contentEquals(userPassword))
					return 1; // 로그인 성공
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2; // db오류
	}
	
	public int join(UserDTO user) {
		String SQL = "INSERT INTO USER VALUES(?,?,?.?,false)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return -1; // 회원가입 실패
	}
	
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM USER WHERE userID=?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				return rs.getString(1); // 이메일 주소 반환
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
	
	public boolean getUserEmailChecked(String userID) {
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getBoolean(1); // 이메일 등록 여부 반환
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return false; // 데이터베이스 오류
	}
	
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true; // 이메일 등록 설정 성공
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return false; // 이메일 등록 설정 실패
	}

}

/*
 * UserDAO에서는 실제로 데이터베이스와 통신하는 부분이 들어있습니다. 보시면 생성자는 데이터베이스와 연동하는 부분임을 알 수 있습니다. 나머지 함수들은 각각 데이터베이스와 통신하는 유의미한 함수들입니다.

  - login(): 아이디와 비밀번호를 받아서, 로그인을 시도하는 함수입니다. 결과는 정수형으로 반환됩니다.
  - join(): 사용자의 정보를 입력 받아서 회원가입을 수행하는 함수입니다. 결과는 정수형으로 반환됩니다.
  - getUserEmail(): 사용자의 아이디를 이용해 이메일 주소를 알아냅니다. 결과는 문자열형으로 반환됩니다.

  - getUserEmailChecked(): 사용자가 현재 이메일 인증이 되었는지 확인하는 함수입니다. 결과는 참/값형으로 반환됩니다.
  - setUserEmailChecked(): 특정한 사용자의 이메일 인증을 수행해줍니다.
*/
