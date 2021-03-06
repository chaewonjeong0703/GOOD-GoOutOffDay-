package study.spring.goodspring.controllers;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.spring.goodspring.helper.RegexHelper;
import study.spring.goodspring.helper.WebHelper;
import study.spring.goodspring.model.BookMark;
import study.spring.goodspring.model.CAS;
import study.spring.goodspring.model.Crew;
import study.spring.goodspring.model.Member;
import study.spring.goodspring.service.BookMarkService;
import study.spring.goodspring.service.CasService;
import study.spring.goodspring.service.CrewService;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
	@Autowired
	WebHelper WebHelper;
	@Autowired
	RegexHelper RegexHelper;
	@Value("#{servletContext.contextPath}")
	String contextPath;
	/** 문화체욱 선언 **/
	@Autowired
	CasService CasService;
	@Autowired
	WebHelper webHelper;
	/** 크루서비스 선언 **/
	@Autowired
	CrewService crewService;

	@Autowired
	BookMarkService bookMarkService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {

		/** 홈컨트롤러 기본값 **/
		log.debug("HomeController 실행됨");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		/** 홈컨트롤러 기본값 끝 **/

		String keyword_exp = "문화";
		String keyword_imp = "교육";
		String keyword_borrow = "대관";

		// 찜하기
		BookMark bookinput = new BookMark();

		BookMark bookUnique = new BookMark();

		List<BookMark> outputUnique = null;

		// 문화 창의 체험 시작
		CAS input_exp = new CAS();

		input_exp.setDIV_COL(keyword_exp);

		List<CAS> output_exp = null;

		if (request.getSession().getAttribute("login_info") == null) {
			try {
				output_exp = CasService.getOtherList(input_exp);
			} catch (Exception e) {
				return WebHelper.redirect(null, e.getLocalizedMessage());
			}
		} else {
			Member loginInfo = (Member) WebHelper.getSession("login_info", new Member());

			bookinput.setUser_info_user_no(loginInfo.getUser_no());
			// 조회
			bookinput.setCategory_id(input_exp.getDIV_COL());
			bookinput.setService_id(input_exp.getSVCID());

			bookUnique.setUser_info_user_no(loginInfo.getUser_no());

			// 저장
			try {
				output_exp = CasService.getOtherList(input_exp);
				outputUnique = bookMarkService.BookMarkSelectList(bookUnique);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 문화 창의 체험 끝

		// 교육 자기계발 시작
		CAS input_imp = new CAS();
		input_imp.setDIV_COL(keyword_imp);

		List<CAS> output_imp = null;

		if (request.getSession().getAttribute("login_info") == null) {
			try {
				output_imp = CasService.getOtherList(input_imp);
			} catch (Exception e) {
				return WebHelper.redirect(null, e.getLocalizedMessage());
			}
		} else {
			Member loginInfo = (Member) WebHelper.getSession("login_info", new Member());

			bookinput.setUser_info_user_no(loginInfo.getUser_no());
			// 조회
			bookinput.setCategory_id(input_imp.getDIV_COL());
			bookinput.setService_id(input_imp.getSVCID());

			bookUnique.setUser_info_user_no(loginInfo.getUser_no());

			// 저장
			try {
				output_imp = CasService.getOtherList(input_imp);
				outputUnique = bookMarkService.BookMarkSelectList(bookUnique);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 교육 자기계발 끝

		// 시설대관 시작
		CAS input_borrow = new CAS();
		input_borrow.setDIV_COL(keyword_borrow);

		List<CAS> output_borrow = null;

		if (request.getSession().getAttribute("login_info") == null) {
			try {
				output_borrow = CasService.getOtherList(input_borrow);
			} catch (Exception e) {
				return WebHelper.redirect(null, e.getLocalizedMessage());
			}
		} else {
			Member loginInfo = (Member) WebHelper.getSession("login_info", new Member());

			bookinput.setUser_info_user_no(loginInfo.getUser_no());
			// 조회
			bookinput.setCategory_id(input_borrow.getDIV_COL());
			bookinput.setService_id(input_borrow.getSVCID());

			bookUnique.setUser_info_user_no(loginInfo.getUser_no());

			// 저장
			try {
				output_borrow = CasService.getOtherList(input_borrow);
				outputUnique = bookMarkService.BookMarkSelectList(bookUnique);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 시설대관 끝

		// 크루 시작
		List<Crew> crew = null;

		try {
			// 데이터 조회하기
			crew = crewService.getCrewList(null);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		// 크루 끝

		// 문화체육 모델객체 주입
		model.addAttribute("keyword_exp", keyword_exp);
		model.addAttribute("keyword_imp", keyword_imp);
		model.addAttribute("keyword_borrow", keyword_borrow);

		model.addAttribute("output_exp", output_exp);
		model.addAttribute("output_imp", output_imp);
		model.addAttribute("output_borrow", output_borrow);
		model.addAttribute("serverTime", formattedDate);

		// 크루 모델객체 주입
		model.addAttribute("crew", crew);

		// 찜목록 확인
		model.addAttribute("outputUnique", outputUnique);

		return new ModelAndView("index");
	}

	/**
	 * 서울 둘레길
	 */
	@ResponseBody
	@RequestMapping(value = "/index/index_doolrea.do", method = RequestMethod.GET)
	public ModelAndView doolrea(Model model) {

		return new ModelAndView("index/index_doolrea");
	}

	/**
	 * 서울 둘레길
	 */
	@ResponseBody
	@RequestMapping(value = "/index/index_moonhwa.do", method = RequestMethod.GET)
	public ModelAndView moonhwa(Model model) {

		return new ModelAndView("index/index_moonhwa");
	}

	/**
	 * 서울 둘레길
	 */
	@ResponseBody
	@RequestMapping(value = "/index/index_jichun.do", method = RequestMethod.GET)
	public ModelAndView jichun(Model model) {

		return new ModelAndView("index/index_jichun");
	}

	/**
	 * 서울 둘레길
	 */
	@ResponseBody
	@RequestMapping(value = "/index/index_jarak.do", method = RequestMethod.GET)
	public ModelAndView jarak(Model model) {

		return new ModelAndView("index/index_jarak");
	}

	/**
	 * 서울 둘레길
	 */
	@ResponseBody
	@RequestMapping(value = "/index/index_hanyang.do", method = RequestMethod.GET)
	public ModelAndView hanyang(Model model) {

		return new ModelAndView("index/index_hanyang");
	}

}
