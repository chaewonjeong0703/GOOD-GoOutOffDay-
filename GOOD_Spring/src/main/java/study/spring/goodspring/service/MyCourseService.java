package study.spring.goodspring.service;

import java.util.List;

import study.spring.goodspring.model.MyCourses;

//나만의 코스 데이터 관리 기능을 제공하기위한 Service
public interface MyCourseService {

	/**
	 * 나만의코스 데이터 상세 조회
	 * @param MyCourses 조회할 코스의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public MyCourses getMyCourseItem(MyCourses input) throws Exception;
	
	
	/**
	 * 나만의코스 데이터 목록 조회
	 * @param MyCourses 조회할 코스의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public List<MyCourses> getMyCourseList(MyCourses input) throws Exception;
	
	/*
	 * 나만의코스 데이터 등록
	 * @param MyCourse 저장할 정보를 담고 있는 Beans
	 * @return int 
	 * @throws Exception
	 */
	public int addMyCourse(MyCourses input) throws Exception;
	
	
	/*
	 * 나만의코스 데이터 수정
	 * @param MyCourse 수정할 정보를 담고 있는 Beans
	 * @return int 
	 * @throws Exception
	 */
	public int editMyCourse(MyCourses input) throws Exception;
	
	
	/*
	 * 나만의코스 데이터 삭제
	 * @param MyCourse 삭제할 정보를 담고 있는 Beans
	 * @return int 
	 * @throws Exception
	 */
	public int deleteMyCourse(MyCourses input) throws Exception;
	
	/*
	 * 나만의코스 데이터 저장되어 있는 갯수 조회
	 * @param MyCourse 검색 조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getMyCourseCount(MyCourses input) throws Exception;
}