package com.bit2015.guestbook.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.bit2015.guestbook.vo.GuestbookVo;

public class GuestbookDao {
	private Connection getconnection() throws SQLException {
		Connection connection = null;
		try {
			// 1. 드라이버 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// 2. 커넥션 만들기(ORACLE DB)
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			connection = DriverManager.getConnection(dbURL, "webdb", "webdb");

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}

	public List<GuestbookVo> getList() {
		List<GuestbookVo> list = new ArrayList<GuestbookVo>();

		try {
			// 1. Connection 가져오기
			Connection connection = getconnection();

			// 2. Statement 생성
			Statement stmt = connection.createStatement();

			// 3. SQL문 실행
			String sql = "select * from GUESTBOOK order by reg_date desc";
			ResultSet rs = stmt.executeQuery(sql);

			// 4. row 가져오기
			while (rs.next()) {
				Long no = rs.getLong(1);
				String name = rs.getString(2);
				String password = rs.getString(3);
				String message = rs.getString(4);
				String regDate = rs.getString(5);
				GuestbookVo vo = new GuestbookVo();
				vo.setNo(no);
				vo.setName(name);
				vo.setPassword(password);
				vo.setMessage(message);
				vo.setRegDate(regDate);
				list.add(vo);
			}
			// 5. 자원 정리
			rs.close();
			stmt.close();
			connection.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("SQL 오류-" + e);
		}
		return list;
	}

	public void insert(GuestbookVo vo) {

		try {
			// 1. Connection 가져오기
			Connection connection = getconnection();

			// 2. Statement 준비
			String sql = "insert into GUESTBOOK VALUES(guestbook_seq.nextval, ?, ?, ?, sysdate)";
			PreparedStatement pstmt = connection.prepareStatement(sql);

			// 3. binding
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getPassword());
			pstmt.setString(3, vo.getMessage());

			// 4. query 실행
			pstmt.executeUpdate();

			// 5. 자원 정리
			pstmt.close();
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("SQL 오류-" + e);
		}
	}

	public void delete(String id, String password) {
		try {
			// 1. Connection 가져오기
			Connection connection = getconnection();

			// 2. Statement 준비
			String sql = "delete from guestbook where no=? and password=?";
			PreparedStatement pstmt = connection.prepareStatement(sql);

			// 3. binding
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			// 4. query 실행
			pstmt.executeUpdate();

			// 5. 자원 정리
			pstmt.close();
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("SQL 오류-" + e);
		}
	}
}
