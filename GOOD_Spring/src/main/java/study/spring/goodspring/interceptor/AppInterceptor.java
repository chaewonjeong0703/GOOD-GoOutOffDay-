package study.spring.goodspring.interceptor;

import java.net.URLDecoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.spring.goodspring.helper.WebHelper;
import study.spring.goodspring.model.Member;
import study.spring.goodspring.model.UserTrafficLog;
import study.spring.goodspring.service.UserTrafficLogService;
import uap_clj.java.api.Browser;
import uap_clj.java.api.Device;
import uap_clj.java.api.OS;

@Slf4j
public class AppInterceptor implements HandlerInterceptor {
	long startTime = 0, endTime = 0;

	/** WebHelper 객체 주입 */
	@Autowired
	WebHelper webHelper;
	@Autowired
	UserTrafficLogService userTrafficLogService;

	/**
	 * Controller 실행 요청 전에 수행되는 메서드 클라이언트의 요청을 컨트롤러에 전달 하기 전에 호출된다. return 값으로
	 * boolean 값을 전달하는데 false 인 경우 controller를 실행 시키지 않고 요청을 종료한다. 보통 이곳에서 각종 체크작업과
	 * 로그를 기록하는 작업을 진행한다.
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// log.debug("AppInterceptor.preHandle 실행됨");
		// WebHelper의 초기화는 모든 컨트롤러마다 개별적으로 호출되어야 한다.
		// Interceptor에서 이 작업을 수행하면 모든 메서드마다 수행하는 동일 작업을 일괄처리할 수 있다.
		webHelper.init(request, response);

		// 컨트롤러 실행 직전에 현재 시각을 저장한다.
		startTime = System.currentTimeMillis();

		/** 1) 클라이언트의 요청 정보 확인하기 */
		// 현재 URL 획득
		String url_tmp = request.getRequestURL().toString();

		// GET방식인지, POST방식인지 조회한다.
		String methodName = request.getMethod();

		// URL에서 "?"이후에 전달되는 GET파라미터 문자열을 모두 가져온다.
		String queryString = request.getQueryString();

		// 완전한url 값을 저장할 변수
		String url = null;
		
		/** UserTrafficLog 이벤트 추가 (page_in || keyword)  */
		
		// 사용자의 세션정보를 미리 담아둔다.
		Member loginInfo = (Member) webHelper.getSession("login_info");
		
		boolean isKeyword=false;
		// 가져온 값이 있다면 URL과 결합하여 완전한 URL을 구성한다.
		if (queryString != null) {
			url = url_tmp + "?" + queryString;

			// 만약 사용자가 로그인된 상태이고, queryString에 keyword 파라미터가 있으면,
			// log_category='keyword'를 log_content='keyword의 값'을 넣는다.
			if (loginInfo != null) {
				
				if (url.contains("keyword")) {
					String keyword_str = ""; // 검색어 값을 담을 변수
					String keyword_url = ""; // 검색이 발생한 페이지의 경로
						// 'keyword='뒤에 붙는 값을 모두 keyword변수에 담는다.				
						keyword_str = queryString.substring(queryString.indexOf("keyword") + 8);
						// 만약 keyword뒤에 추가로 파라미터가 있으면 (contains("&"))
						// 'keyword='의 바로 뒤 부터 첫번째 '&'까지의 값을 keyword_str 변수에 담는다.
						if(keyword_str.contains("&")) {
							keyword_str = keyword_str.substring(0, keyword_str.indexOf("&"));							
						}
					
					//.do로 끝나는 페이지와 그렇지 않은 페이지의 경로를 구분하여 kewword_Url에 담는다.
					if (url_tmp.lastIndexOf(".do") != -1) {

						keyword_url = url_tmp.substring(url_tmp.indexOf("goodspring") + 11, url_tmp.lastIndexOf(".do"));
					} else {
						keyword_url = url_tmp.substring(url_tmp.indexOf("goodspring") + 11, url.indexOf("?"));

						if (keyword_url == "" || keyword_url == "/") {
							keyword_url = "index";
						}
					}
					//검색어가 한글인 경우를 위해 keyword_str는 utf-8 decoding 필요.
					keyword_str= URLDecoder.decode(keyword_str, "utf-8");
					
					//파싱된 keyword와 kewword_Url을 합쳐서 addKeyword 메서드에 전달.
					String keyword= keyword_url+"?keyword="+keyword_str;
					
					if(keyword_str!=null && keyword_str!="") {
					UserTrafficLog input = new UserTrafficLog();
					input.setUser_info_user_no(loginInfo.getUser_no());
					input.setLog_category(keyword);
					userTrafficLogService.addKeyword(input);
					}
					isKeyword=true;
				}
			}

		}
		/**
		 * 로그인 되어있고, keyword값을 db에 추가하지 않았다면(isKeyword==false), 사용자가 컨트롤러로 요청을 보낸 url과 사용자번호를 UserTrafficLog 테이블에
		 * log_content='page_in'으로 추가
		 */

		if (loginInfo != null && isKeyword==false) {
			if (url_tmp.lastIndexOf(".do") != -1) {

				String url2 = url_tmp.substring(url_tmp.indexOf("goodspring") + 11, url_tmp.lastIndexOf(".do"));
				UserTrafficLog input = new UserTrafficLog();
				input.setUser_info_user_no(loginInfo.getUser_no());
				input.setLog_category(url2);
				userTrafficLogService.pageIn(input);
			} else {
				String url2 = url_tmp.substring(url_tmp.indexOf("goodspring") + 11);

				if (url2 == "" || url2 == "/") {
					url2 = "index";
					UserTrafficLog input = new UserTrafficLog();
					input.setUser_info_user_no(((Member) webHelper.getSession("login_info")).getUser_no());
					input.setLog_category(url2);
					userTrafficLogService.pageIn(input);
				}
			}
		}
		/** UserTrafficLog 이벤트 추가 끝(page_in || keyword)  */
		
		// 획득한 정보를 로그로 표시한다.
		log.debug(String.format("[%s] %s", methodName, url_tmp));

		/** 2) 클라이언트가 전달한 모든 파라미터 확인하기 */
		Map<String, String[]> params = request.getParameterMap();

		for (String key : params.keySet()) {
			String[] value = params.get(key);
			log.debug(String.format("(p) <-- %s = %s", key, String.join(",", value)));
		}

		/** 3) 클라이언트가 머물렀던 이전 페이지와 이전 페이지에 머문 시간 확인하기 */
		// 이전에 머물렀던 페이지
		String referer = request.getHeader("referer");

		// 이전 종료 시간이 0보다 크다면 새로운 시작시간과의 차이는 이전 페이지에 머문 시간을 의미한다.
		if (referer != null && endTime > 0) {
			log.debug(String.format("- REFERER : time=%d, url=%s", startTime - endTime, referer));
		}

		/** 4) 접속한 클라이언트의 장치 정보를 로그로 기록 */
		// 접근한 클라이언트의 HTTP 헤더 정보 가져오기

		// "uap" 라이브러리의 기능을 통해 UserAgent 정보 파싱
		String ua = request.getHeader("User-Agent");
		// -> import uap_clj.java.api.Browser;
		Map<String, String> browser = Browser.lookup(ua);
		// -> import uap_clj.java.api.OS;
		Map<String, String> os = (Map<String, String>) OS.lookup(ua);
		// -> import uap_clj.java.api.Device;
		Map<String, String> device = (Map<String, String>) Device.lookup(ua);

		// 추출된 정보들을 출력하기 위해 문자열로 묶기
		String browserStr = String.format("- Browser: {family=%s, patch=%s, major=%s, minor=%s}", browser.get("family"),
				browser.get("patch"), browser.get("major"), browser.get("minor"));

		String osStr = String.format("- OS: {family=%s, patch=%s, patch_minor=%s, major=%s, minor=%s}",
				os.get("family"), os.get("patch"), os.get("patch_minor"), os.get("major"), os.get("minor"));

		String deviceStr = String.format("- Device: {family=%s, model=%s, brand=%s}", device.get("family"),
				device.get("model"), device.get("brand"));

		// 로그 저장
		log.debug(browserStr);
		log.debug(osStr);
		log.debug(deviceStr);
		return HandlerInterceptor.super.preHandle(request, response, handler);

	}

	/**
	 * view 단으로 forward 되기 전에 수행. 컨트롤러 로직이 실행된 이후 호출된다. 컨트롤러 단에서 에러 발생 시 해당 메서드는
	 * 수행되지 않는다. request로 넘어온 데이터 가공 시 많이 사용된다.
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// log.debug("AppInterceptor.postHandle 실행됨");
		// 컨트롤러 종료시의 시각을 가져온다.
		endTime = System.currentTimeMillis();
		// 시작시간과 종료시간 사이의 차이를 구하면 페이지의 실행시간을 구할 수 있다.
		log.debug(String.format("running time: %d(ms)\n", endTime - startTime));
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

	/**
	 * 컨트롤러 종료 후 view가 정상적으로 랜더링 된 후 제일 마지막에 실행이 되는 메서드.
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// log.debug("AppInterceptor.afterCompletion 실행됨");
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}

}
