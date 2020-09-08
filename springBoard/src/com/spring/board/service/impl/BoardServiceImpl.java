package com.spring.board.service.impl;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.BoardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDao boardDao;

	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}

	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub

		return boardDao.selectBoardList(pageVo);
	}

	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}

	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();

		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);

		return boardDao.selectBoard(boardVo);
	}

	/* 게시물 작성 */
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.boardInsert(boardVo);
	}
	
	/* 다중 게시물 작성 */
	@Override
	public int boardListInsert(List<BoardVo> boardList) throws Exception {
		// TODO Auto-generated method stub
		int count = boardList.size();
		int cnt = 0;
		
		BoardVo boardVo;
		
		for(int i = 0; i < count; i++) {
			
			boardVo = boardList.get(i);
			
			if(boardDao.boardInsert(boardVo)>0)
				cnt++;
		}
		
		return cnt;
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardDelete(boardVo);
	}

	@Override
	public List<ComCodeVo> codeNameList() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.codeNameList();
	}

	@Override
	public Workbook boardWorkbook(List<BoardVo> boardList) throws Exception {
		// TODO Auto-generated method stub
		
		// 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("게시판");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;
		
	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();

	    // 가는 경계선을 가집니다.
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);

	    // 배경색은 노란색입니다.
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

	    // 데이터는 가운데 정렬합니다.
	    headStyle.setAlignment(HorizontalAlignment.CENTER);

	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);

	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("Type");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("No");
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("Title");

	    // 데이터 부분 생성
	    for(BoardVo vo : boardList) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getCodeName());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getBoardNum());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getBoardTitle());
	    }
		
		return wb;
	}
	
	
	// 달력 만들기

	@Override
	public XSSFWorkbook boardCalendar(XSSFWorkbook workbook, String date) throws Exception {
		// TODO Auto-generated method stub
		
		// 워크북, 시트 생성
		XSSFWorkbook wb = workbook;
		XSSFSheet sheet = wb.cloneSheet(0);
		wb.setSheetName(1, "calendar");
		
		Row row = null;
	    Cell cell = null;
	    
	    // 날짜 불러오기
	    row = sheet.createRow(0);
	    cell = row.createCell(0);
	    cell.setCellValue(date);
		
	    // 스타일
	    Map<String, XSSFCellStyle> cellStyle = new HashMap<String, XSSFCellStyle>();
	    int num = 1;
	    for(int i = 1; i<4; i++) {
	    	for(int j = 1; j<4; j++) {
	    		String name ="cellStyle"+num;
	    		
	    		XSSFCellStyle cs = wb.createCellStyle();
	    		cs.cloneStyleFrom(sheet.getRow(i).getCell(j).getCellStyle());
	    		
	    		cellStyle.put(name, cs);
	    		
	    		num++;
	    	}
	    }
	    
	    int h=1; // header 생성
	    for(int i = 1; i <= 18; i+=3) {
	    	row = sheet.createRow(i);
	    	for(int j = 1; j <= 21; j++) {
	    		cell = row.createCell(j);
	    		cell = sheet.getRow(i).getCell(j);
	    	    cell.setCellStyle(cellStyle.get("cellStyle"+h));
	    	    if(h==2) {
	    	    	cell.setCellValue(date);
	    	    }
	    	    h++;
	    	    if(h>3) {
	    	    	h=1;
	    	    }
	    	}
	    	h=1;
	    }
	    int b=4; // body 생성
	    for(int i = 2; i <= 19; i+=3) {
	    	row = sheet.createRow(i);
	    	for(int j = 1; j <= 21; j++) {
	    		cell = row.createCell(j);
	    		cell = sheet.getRow(i).getCell(j);
	    	    cell.setCellStyle(cellStyle.get("cellStyle"+b));
	    	    b++;
	    	    if(b>6) {
	    	    	b=4;
	    	    }
	    	}
	    	b=4;
	    }
	    
	    int f=7; // footer 생성
	    for(int i = 3; i <= 20; i+=3) {
	    	row = sheet.createRow(i);
	    	for(int j = 1; j <= 21; j++) {
	    		cell = row.createCell(j);
	    		cell = sheet.getRow(i).getCell(j);
	    	    cell.setCellStyle(cellStyle.get("cellStyle"+f));
	    	    f++;
	    	    if(f>9) {
	    	    	f=7;
	    	    }
	    	}
	    	f=7;
	    }
	    
	    
	    Calendar cal = Calendar.getInstance();
	    // 달력 데이터 배열
	    String[][] calDate = new String[6][7];
	    int width=7;
	    int startDay;
	    int lastDay;
	    int inputDate=1;

	    String year = date.substring(0,4);
	    String month = date.substring(5,7);
	    
	    cal.set(Calendar.YEAR, Integer.parseInt(year));
	    cal.set(Calendar.MONTH, Integer.parseInt(month)-1);
	    cal.set(Calendar.DATE, 1);
	    
	    startDay = cal.get(Calendar.DAY_OF_WEEK);
	    lastDay = cal.getActualMaximum(Calendar.DATE);
	    
	    int r = 0;
	    for(int i = 1; inputDate <= lastDay; i++) {
	    	if(i<startDay) {
	    		calDate[r][i-1]="";
	    	}else {
	    		calDate[r][(i-1)%width]=Integer.toString(inputDate);
	    		inputDate++;
	    		
	    		if(i%width==0) {
	    			r++;
	    		}
	    	}
	    }

	    int cr=0; int cc=1; // cal 입력
	    for(int i = 1; i <= 18; i+=3) {
	    	for(int j = 2; j <= 22; j+=3) {
	    		cell = sheet.getRow(i).getCell(j);
	    		cell.setCellValue(calDate[cr][(cc-1)%width]);
	    		cc++;
	    	}
	    	cr++;
	    }
	    
		// 폼 시트 삭제
		wb.removeSheetAt(0);
		
		return wb;
	}


}
