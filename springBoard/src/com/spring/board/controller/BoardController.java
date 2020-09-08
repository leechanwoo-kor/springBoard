package com.spring.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.BoardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

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

	/* 게시물 조회 / 페이지네이션 */
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

		List<ComCodeVo> comCodeList = new ArrayList<ComCodeVo>();
		comCodeList = boardService.codeNameList();

		model.addAttribute("codeNameList", comCodeList);
		return "board/boardWrite";
	}
	
	/* 게시물 작성 */
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(HttpServletRequest request, Locale locale, BoardVo boardVo) throws Exception {

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		List<BoardVo> boardList = boardVo.getBoardVoList();
		System.out.println(boardList);
		System.out.println(boardList);
		
		int resultCnt = 0;
		
		resultCnt = boardService.boardListInsert(boardList);
		
		result.put("success", (resultCnt > 0) ? "Y" : "N");
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
	
	@RequestMapping(value = "/board/boardExcel.do")
	public void boardExcel(HttpServletRequest request, HttpServletResponse response, PageVo pageVo) throws Exception {
		
		// 게시판 목록 조회
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

		Workbook wb = boardService.boardWorkbook(boardList);
		
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=board.xls");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
	
	@RequestMapping(value = "/board/boardCalendar.do")
	public void boardCalendar(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String date = request.getParameter("date");
		
		FileInputStream fis = new FileInputStream("C:\\calendar1.xlsx");
		XSSFWorkbook workbook = new XSSFWorkbook(fis);

		XSSFWorkbook wb = boardService.boardCalendar(workbook, date);
		
		// 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=calendar.xlsx");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	    workbook.close();
	}

}
