package com.spring.user.service;

import java.util.List;

import com.spring.board.vo.ComCodeVo;
import com.spring.user.vo.UserVo;

public interface UserService {

	public UserVo selectUser(String userId, String userPw) throws Exception;
	
	public int userInsert(UserVo userVo) throws Exception;
	
	//아이디 중복 체크
	int checkId(String userId) throws Exception;
	
	public List<ComCodeVo> codeNameList() throws Exception;
}
