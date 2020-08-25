package com.spring.user.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.common.CommonUtil;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;
import com.sun.javafx.collections.MappingChange.Map;

@Controller
public class UserController {

	@Autowired
	UserService userService;

	/* 회원가입 페이지 */
	@RequestMapping("/user/join.do")
	public String userJoin(Locale local, Model model) throws Exception {

		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>();
		comCodeList = userService.codeNameList();

		model.addAttribute("codeNameList", comCodeList);

		return "user/join";
	}

	/* 아이디 중복 체크 */
	@RequestMapping(value = "/user/checkId.do")
	@ResponseBody
	public void checkId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		String paramId = (request.getParameter("userId") == null) ? "" : String.valueOf(request.getParameter("userId"));

		int checkId = userService.checkId(paramId);
		out.print(checkId);
		out.flush();
		out.close();
	}

	/* 회원가입 */
	@RequestMapping(value = "/user/joinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String userJoinAction(Locale locale, UserVo userVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		System.out.println(userVo.getUserId());
		int resultCnt = userService.userInsert(userVo);

		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	/* 로그인 페이지 */
	@RequestMapping("/user/login.do")
	public String userLogin(Locale local, Model model) throws Exception {

		return "user/login";
	}

	/* 로그인 */
	@RequestMapping(value = "/user/loginAction.do", method = RequestMethod.POST)
	public String loginAction(HttpSession session, HttpServletRequest request, Locale locale, Model model)
			throws Exception {

		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");

		UserVo user = userService.selectUser(userId, userPw);

		if (user == null) {
			request.setAttribute("errCode", 1);
			return "redirect:/user/login.do";
		} else {
			session.setAttribute("user", user);
			return "redirect:/board/boardList.do";
		}
	}

	/* 로그아웃 */
	@RequestMapping("/user/logout.do")
	public String logoutAction(HttpSession session) throws Exception {

		session.invalidate();

		return "redirect:/board/boardList.do";
	}

}
