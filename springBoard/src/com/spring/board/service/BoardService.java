package com.spring.board.service;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

public interface BoardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public int boardListInsert(List<BoardVo> boardList) throws Exception;

	public int boardUpdate(BoardVo boardVo) throws Exception;

	public int boardDelete(BoardVo boardVo) throws Exception;

	public List<ComCodeVo> codeNameList() throws Exception;
	
	public Workbook boardWorkbook(List<BoardVo> boardList) throws Exception;
	
	public XSSFWorkbook boardCalendar(XSSFWorkbook workbook, String date) throws Exception;

}
