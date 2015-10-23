package com.bit2015.guestbook.web.api.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.bit2015.guestbook.dao.GuestbookDao;
import com.bit2015.guestbook.vo.GuestbookVo;
import com.bit2015.web.action.Action;

public class IndexAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String page = request.getParameter("page");
		if (page == null) {
			page = "1";
		}
		GuestbookDao dao = new GuestbookDao();
		List<GuestbookVo> list = dao.getList(Integer.parseInt(page));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "ok");
		map.put("data", list);
		JSONObject jSONObject = JSONObject.fromObject(map);
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jSONObject.toString());
	}

}
