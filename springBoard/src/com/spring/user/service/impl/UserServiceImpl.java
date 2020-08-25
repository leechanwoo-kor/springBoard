package com.spring.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.vo.ComCodeVo;
import com.spring.user.dao.UserDao;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao userDao;

	@Override
	public UserVo selectUser(String userId, String userPw) throws Exception {
		// TODO Auto-generated method stub
		UserVo userVo = new UserVo();

		userVo.setUserId(userId);
		userVo.setUserPw(userPw);

		return userDao.selectUser(userVo);
	}

	@Override
	public int userInsert(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return userDao.userInsert(userVo);
	}

	@Override
	public int checkId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userDao.checkId(userId);
	}

	@Override
	public List<ComCodeVo> codeNameList() throws Exception {
		// TODO Auto-generated method stub
		return userDao.codeNameList();
	}

}
