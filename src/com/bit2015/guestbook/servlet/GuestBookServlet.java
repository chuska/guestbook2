package com.bit2015.guestbook.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bit2015.guestbook.dao.GuestbookDao;
import com.bit2015.guestbook.vo.GuestbookVo;
import com.bit2015.guestbook.web.action.GuestbookActionFactory;
import com.bit2015.web.action.Action;
import com.bit2015.web.action.ActionFactory;

/**
 * Servlet implementation class GuestBookServlet
 */
@WebServlet("/gb")
public class GuestBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String actionName = request.getParameter("a");
		ActionFactory actionFactory = new GuestbookActionFactory();
		Action action = actionFactory.getAction(actionName);
		action.execute(request, response);
	}
}
