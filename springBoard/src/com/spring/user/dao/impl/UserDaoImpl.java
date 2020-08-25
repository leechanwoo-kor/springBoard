package com.spring.user.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.vo.ComCodeVo;
import com.spring.user.dao.UserDao;
import com.spring.user.vo.UserVo;


@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public UserVo selectUser(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.userInfo", userVo);
	}
	
	@Override
	public int userInsert(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("user.userInsert", userVo);
	}

	/* 아이디 중복 체크 */
	@Override
	public int checkId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.checkId", userId);
	}

	@Override
	public List<ComCodeVo> codeNameList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("user.codeNameList");
	}

}