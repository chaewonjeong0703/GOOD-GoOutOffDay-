package study.spring.goodspring.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import study.spring.goodspring.model.MyCourses;
import study.spring.goodspring.service.MyCourseService;

@Slf4j
@Service
public class MyCourseServiceImpl implements MyCourseService {
	// MyBatis 세션 객체 주입 설정
	@Autowired
	SqlSession sqlSession;

	/*
	 * 단일 데이터 조회
	 * @param MyCourses 조회할 데이터의 일련번호를 담고있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	@Override
	public MyCourses getMyCourseItem(MyCourses input) throws Exception {
		MyCourses result = null;

		try {
			result = sqlSession.selectOne("MyCourseMapper.selectMyCoursesItem", input);

			if (result == null) {
				throw new NullPointerException("result = null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("조회된 코스 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}

		return result;
	}
	/*
	 * 데이터 목록 조회
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	@Override
	public List<MyCourses> getMyCourseList(MyCourses input) throws Exception {
		List<MyCourses> result = null;

		try {
			result = sqlSession.selectList("MyCourseMapper.selectMyCourseList", input);

			if (result == null) {
				throw new NullPointerException("result=null");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("조회된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}

		return result;
	}
	/*
	 * 데이터 등록
	 * @param MyCourses 저장할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int addMyCourse(MyCourses input) throws Exception {
		int result = 0;

		try {
			result = sqlSession.insert("MyCourseMapper.insertCrew", input);

			if (result == 0) {
				throw new NullPointerException("result=0");
			}

		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("저장된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 등록에 실패했습니다.");
		}

		return result;
	}
	/*
	 * 데이터 수정
	 * @param MyCourses 수정할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int editMyCourse(MyCourses input) throws Exception {
		int result = 0;

		try {
			result = sqlSession.update("MyCourseMapper.updateCrew", input);

			if (result == 0) {
				throw new NullPointerException("result=0");
			}

		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("수정된 데이터가 없습니다.");
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 수정에 실패했습니다.");
		}

		return result;
	}
	/*
	 * 데이터 삭제
	 * @param MyCourses 삭제할 정보를 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int deleteMyCourse(MyCourses input) throws Exception {
		int result = 0;

		try {
			result = sqlSession.delete("MyCourseMapper.deleteCrew", input);

			if (result == 0) {
				throw new NullPointerException("result=0");
			}
		} catch (NullPointerException e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("삭제된 데이터가 없습니다.");
		}

		catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 삭제에 실패했습니다.");
		}

		return result;
	}
	/*
	 * 데이터가 저장되어 있는 갯수 조회
	 * @param MyCourses 검색 조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int getMyCourseCount(MyCourses input) throws Exception {

		int result = 0;

		try {
			result = sqlSession.selectOne("MyCourseMapper.selectCountAll", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception("데이터 조회에 실패했습니다.");
		}

		return result;
	}

}