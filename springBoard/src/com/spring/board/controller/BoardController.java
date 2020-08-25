package com.spring.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.BoardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

import net.sf.json.JSONArray;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/* 게시물 리스트 페이지 */
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(HttpServletRequest request, Locale locale, Model model, PageVo pageVo) throws Exception {

		String[] codeId = request.getParameterValues("codeId");
		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>();
		comCodeList = boardService.codeNameList();

		List<BoardVo> boardList = new ArrayList<BoardVo>();
		int page = 1;
		int totalCnt = 0;

		if (pageVo.getPageNo() == 0) {
			pageVo.setPageNo(page);
		}

		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardList.get(0).getTotalCnt();

		model.addAttribute("codeNameList", comCodeList);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", pageVo.getPageNo());

		return "board/boardList";
	}

	/* 게시물 조회 json
	@RequestMapping(value = "/board/boardSearchAction.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray boardSearchAction(HttpServletRequest request, Locale locale, Model model, BoardVo boardVo,
			PageVo pageVo) throws Exception {
		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>();
		comCodeList = boardService.codeNameList();

		List<BoardVo> boardList = new ArrayList<BoardVo>();

		int page = 1;
		int totalCnt = 0;

		if (pageVo.getPageNo() == 0) {
			pageVo.setPageNo(page);
		}

		model.addAttribute("codeNameList", comCodeList);

		JSONArray jsonArray = new JSONArray();

		return jsonArray.fromObject(boardService.SelectBoardList(pageVo));
	}
	*/

	/* html 조회 */
	@RequestMapping(value = "/board/boardSearchAction.do", method = RequestMethod.POST)
	public String boardSearchAction(HttpServletRequest request, Locale locale, Model model, PageVo pageVo) throws Exception {

		String[] codeId = request.getParameterValues("codeId");
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));
		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>();
		comCodeList = boardService.codeNameList();

		List<BoardVo> boardList = new ArrayList<BoardVo>();
		int page = pageNo;
		int totalCnt = 0;

		if (pageVo.getPageNo() == 0) {
			pageVo.setPageNo(page);
		}

		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardList.get(0).getTotalCnt();

		model.addAttribute("codeNameList", comCodeList);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", pageVo.getPageNo());
		
		return "board/boardTable";
	}

	/* 게시물 상세 페이지 */
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model, @PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum) throws Exception {

		BoardVo boardVo = new BoardVo();

		boardVo = boardService.selectBoard(boardType, boardNum);

		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);

		return "board/boardView";
	}

	/* 게시물 작성 페이지 */
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception {

		return "board/boardWrite";
	}

	/* 게시물 작성 */
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale, BoardVo boardVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardInsert(boardVo);

		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}
	
	/* 다중 게시물 작성 */
	@RequestMapping(value = "/board/boardWriteAction2.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction2(HttpServletRequest request, Locale locale, BoardVo boardVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int count = Integer.parseInt(request.getParameter("count"));
		System.out.println(count);
		System.out.println(count);
		System.out.println(count);

		System.out.println(boardVo);
		System.out.println(boardVo);

		System.out.println(boardVo.getBoardType().split(",")[0]);
		System.out.println(boardVo.getBoardType().split(",")[1]);
		
		int resultCnt = 0;
		
		for(int i = 0; i < count; i++) {
			BoardVo temp = new BoardVo();
			temp.setBoardType(boardVo.getBoardType().split(",")[i]);
			temp.setBoardTitle(boardVo.getBoardTitle().split(",")[i]);
			temp.setBoardComment(boardVo.getBoardComment().split(",")[i]);
			temp.setCreator(boardVo.getCreator().split(",")[i]);
			
			if(boardService.boardInsert(temp)>0)
				resultCnt++;
		}
		result.put("success", (resultCnt > count-1) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	/* 게시물 수정 페이지 */
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate(Locale locale, Model model, @PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum) throws Exception {

		BoardVo boardVo = new BoardVo();

		boardVo = boardService.selectBoard(boardType, boardNum);

		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);

		return "board/boardUpdate";
	}

	/* 게시물 수정 */
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale, BoardVo boardVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardUpdate(boardVo);

		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	/* 게시물 삭제 */
	@RequestMapping(value = "/board/boardDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDeleteAction(Locale locale, BoardVo boardVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardDelete(boardVo);

		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

}
