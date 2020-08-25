package com.spring.user.dao;

import java.util.List;

import com.spring.board.vo.ComCodeVo;
import com.spring.user.vo.UserVo;

public interface UserDao {

	public UserVo selectUser(UserVo userVo) throws Exception;

	public int userInsert(UserVo userVo) throws Exception;

	// 아이디 중복 체크
	public int checkId(String userId) throws Exception;

	public List<ComCodeVo> codeNameList() throws Exception;
}
