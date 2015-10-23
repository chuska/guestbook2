package com.bit2015.guestbook.web.api.action;

import com.bit2015.web.action.Action;
import com.bit2015.web.action.ActionFactory;

public class GuestbookActionFactory extends ActionFactory {

	@Override
	public Action getAction(String actionName) {
		// TODO Auto-generated method stub
		Action action = null;
		if ("delete".equals(actionName)) {
		} else if ("insert".equals(actionName)) {
		} else {
			action = new IndexAction();
		}
		return action;
	}

}
