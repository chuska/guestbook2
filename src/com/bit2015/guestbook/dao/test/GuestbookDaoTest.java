package com.bit2015.guestbook.dao.test;

import java.util.List;

import com.bit2015.guestbook.dao.GuestbookDao;
import com.bit2015.guestbook.vo.GuestbookVo;

public class GuestbookDaoTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
			GuestbookDao dao = new GuestbookDao();
			List<GuestbookVo> list = dao.getList(1);
			for( GuestbookVo vo : list ) {
				System.out.println( vo );
			
		}
	}
}
