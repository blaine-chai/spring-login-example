package com.blainechai.controller;

import com.blainechai.constant.Constant;
import com.blainechai.constant.UserType;
import com.blainechai.controller.api.SocketComm;
import com.blainechai.domain.*;
import com.blainechai.model.*;
import com.blainechai.repository.*;
import com.blainechai.util.EncryptUtil;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static com.blainechai.util.LoggerUtil.*;

/**
 * Created by blainechai on 2016. 9. 5..
 */
@Controller
@RequestMapping("")
public class MainPageController {

    @Autowired
    private SessionRepository sessionRepository;

    @Autowired
    private UserAccountRepository userAccountRepository;

    @Autowired
    private UserHistoryRepository userHistoryRepository;

    @Autowired
    private UserTableOptionRepository tableOptionRepository;

    @Autowired
    private NicknameRepository nicknameRepository;

    @Autowired
    private UserBookmarkRepository userBookmarkRepository;

    @Autowired
    private AdminBookmarkRepository adminBookmarkRepository;

    @Autowired
    private CommonBookmarkRepository commonBookmarkRepository;

    @Autowired
    private AdminHistoryRepository adminHistoryRepository;

    @Autowired
    private CommonGroupNameRepository groupNameRepository;

    @Autowired
    private UserGroupRepository userGroupRepository;

    //    public static List<BookInfo> bookInfoList = new ArrayList<BookInfo>();
    public static ArrayList<String> keySet = new ArrayList<String>();
    public static String ip = "10.10.10.10";
    public static int port = 30000;

    public MainPageController() throws IOException {
        /*
        File f = new File("./text");
    	System.out.println("AAAAAAAAAAAAAAAAAAAAAA : " + f.getPath() + " : " + f.getCanonicalPath());

		String path = MainPageController.class.getResource("").getPath(); // 현재 클래스의 절대 경로를 가져온다.
		System.out.println(new File(path).getParentFile().getParent()); //--> 절대 경로가 출력됨
		File fileInSamePackage = new File(path + "test.txt"); // path 폴더 내의 test.txt 를 가리킨다
		System.out.println(new File(path).getParentFile().getParentFile().getParent()); //--> 절대 경로가 출력됨
		*/
//        String path = MainPageController.class.getResource("").getPath(); // 현재 클래스의 절대 경로를 가져온다.
//        BufferedReader in = new BufferedReader(new FileReader(new File(path).getParentFile().getParentFile().getParent() + File.separator + "IPandPort.txt"));

//        ip = in.readLine();
//        port = Integer.parseInt(in.readLine());
//        System.out.println(ip + " : " + port);
//        in.close();
        ip = "14.52.86.172";
        port = 3000;
    }

    @RequestMapping(value = {""})
    public ModelAndView login(HttpServletRequest request) {
        if (sessionRepository.findByJSessionId(request.getSession().getId()).size() > 0) {
            return new ModelAndView("redirect:" + "/main");
        }
        Map<String, ?> fm = RequestContextUtils.getInputFlashMap(request);
        if (fm != null) {
            String message = (String) fm.get("loginFail");
            return new ModelAndView("user_login").addObject("loginFail", message);
        } else {
            return new ModelAndView("user_login")
                    .addObject("adminAccountSize", userAccountRepository.findByType(UserType.ADMIN).size())
                    .addObject("loginFail", "false");
        }
    }

    @RequestMapping(value = {"/main"})
    public ModelAndView mainPage(HttpServletRequest request) {

        String sessionId = request.getSession().getId();
        String userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        ModelAndView modelAndView = new ModelAndView("main_alarm");
        modelAndView.addObject("colSize", tableOptionRepository.findByUserAccount_UserId(userId).get(0).getColSizes());
        modelAndView.addObject("userId", userId);
        modelAndView.addObject("userType", sessionRepository.findByJSessionId(sessionId).get(0).getType());
        return modelAndView;
    }


//
//    @RequestMapping(value = "/join", method = RequestMethod.POST)
//    public String userJoin(HttpServletRequest request) {
//        String userId = request.getParameter("userId");
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//        String phone = request.getParameter("phone");
//        try {
//            if (userAccountRepository.findByUserId(userId).size() <= 0) {
//                UserAccount userAccount = new UserAccount(userId, username, password, phone, UserType.USER);
//                userAccount = userAccountRepository.save(userAccount);
//                tableOptionRepository.save(new UserTableOption(userAccount, new int[]{50, 50, 50, 100, 100, 100, 100, 50, 50, 600, 50, 50}));
//                List<AdminBookmark> adminBookmarks = adminBookmarkRepository.findAll();
//                for (AdminBookmark adminBookmark : adminBookmarks) {
//                    commonBookmarkRepository.save(new CommonBookmark(userAccount, adminBookmark, 0));
//                }
//            } else {
//                return "redirect:" + "/error";
//            }
//        } catch (Exception e) {
//            return "redirect:" + "/error";
//        }
//        return "redirect:" + "/";
//    }

//    @RequestMapping(value = "/register")
//    public String registerPage(HttpServletRequest request) {
//        return "user_join";
//    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String userLogin(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        List<UserAccount> userAccountList = userAccountRepository.findByUserId(userId);

//        System.out.println(EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + userId + password + EncryptUtil.SECOND_KEY));
        if (userAccountList.size() > 0 && userAccountList.get(0).getUserId().equals(userId) && userAccountList.get(0).getHash().equals(EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + userId + password + EncryptUtil.SECOND_KEY))) {
            request.getSession().setAttribute("userId", userId);
            sessionRepository.save(new Session(request.getSession().getId(), userId, userAccountList.get(0).getType()));
            log(userId, "로그인");
            return "redirect:" + "/main";
        }
        redirectAttributes.addFlashAttribute("loginFail", "true");
        return "redirect:" + "/";
    }

    @RequestMapping(value = "/logout")
    public String userLogout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:" + "/";
    }

    //    @RequestMapping(value = {"/main/alarm/search-user-bookmark"})
//    public String getUserBookmark() {
//        return "main_alarm";
//    }
//    static int updateCount = 0;

//    @RequestMapping(value = {"/main/alarm/get-alarm-count"})
//    public ModelAndView getAlarm(HttpServletRequest request) {
//        updateCount++;
//        ModelAndView modelAndView = new ModelAndView("api").addObject("json", String.valueOf(updateCount));

    /**
     * 아래 주석부분이 실제 코드이므로 해제하고 개발하시면 됩니다.
     */

//        String sessionId = request.getSession().getId();
//        String userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
//        List<UserBookmark> userBookmarks = userBookmarkRepository.findByUserAccount_UserId(userId);
//        List<CommonBookmark> commonBookmarks = commonBookmarkRepository.findByUserAccount_UserId(userId);
//        int updateCount = 0;
//
//        List<String> resultUserBookmarkCountList = new ArrayList<String>();
//        for (int i = 0; i < resultUserBookmarkCountList.size(); i++) {
//            if (Integer.parseInt(resultUserBookmarkCountList.get(i)) > userBookmarks.get(i).getCount()) {
//                updateCount++;
//            }
//        }
//
//        List<String> resultCommonBookmarkCountList = new ArrayList<String>();
//        for (int i = 0; i < resultCommonBookmarkCountList.size(); i++) {
//            if (Integer.parseInt(resultCommonBookmarkCountList.get(i)) > commonBookmarks.get(i).getCount()) {
//                updateCount++;
//            }
//        }
//
//        ModelAndView modelAndView = new ModelAndView("api").addObject("json", String.valueOf(updateCount));
//
//        return modelAndView;
//    }
    @RequestMapping(value = {"/main/profile"})
    public ModelAndView profilePage(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        ModelAndView modelAndView = new ModelAndView("main_profiling");
        modelAndView.addObject("colSize", tableOptionRepository.findByUserAccount_UserId(sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId()).get(0).getColSizes());
        modelAndView.addObject("userId", userId);
        modelAndView.addObject("userType", sessionRepository.findByJSessionId(sessionId).get(0).getType());
        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userId);
        modelAndView.addObject("userGroups", userGroups);

        return modelAndView;
    }

    // 프로파일링에서 검색 버튼 클릭시 요청 들어옴
    // 저자 검색에 대한 내용 필요
    @RequestMapping(value = {"/main/profile/search-author"})
    public ModelAndView searchAuthor(HttpServletRequest request) {
        // 클라이언트로 부터 받아온 search keyword
        String userId = "";
        String sessionId = request.getSession().getId();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        }

        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userId);

        List<NicknameOption> nicknames = nicknameRepository.findAll();
        List<NicknameOption> nicknames2 = new ArrayList<NicknameOption>();
        boolean b = false;
        for (int j = 0; j < userGroups.size(); j++) {
            if (userGroups.get(j).getGroupName().getGroupName().equals(Constant.GROUP_NAME_ALL)) {
                b = true;
                break;
            }
        }
        if (!b) {
            for (int i = 0; i < nicknames.size(); i++) {
                //System.out.println(i + "  : NicknameOption : author = " + nicknames.get(i).getAuthor() + " : nickname =" + nicknames.get(i).getNickname());
                b = false;
                String tmp = nicknames.get(i).getAuthor().split("_")[0];
                for (int j = 0; j < userGroups.size(); j++) {
                    if (userGroups.get(j).getGroupName().getGroupName().equals(tmp)) {
                        b = true;
                        break;
                    }
                }
                //System.out.println(i + " : " + tmp + " : " + b);
                if (b) {
                    nicknames2.add(nicknames.get(i));
                }
                //System.out.println(i + " : " + tmp + " : " + nicknames2.size());
            }
        } else nicknames2.addAll(nicknames);

        Gson gson = new Gson();
        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", gson.toJson(nicknames2));
        return modelAndView;
    }

    //프로파일링에서 검색 후 저자-연관저자 리스트에서 대상 클릭시 요청 들어옴
    //from, to, 참조저자가 전달되야 함
    @RequestMapping(value = {"/main/profile/search-rel-author"})
    public ModelAndView searchRelAuthorByAuthor(HttpServletRequest request) {
        // 메인 서버와 통신
        // *author* 이용
        // 참조저자, from, to 값을 검색해옴
        Gson gson = new Gson();

        List<BookInfo> bookInfoList = new ArrayList<BookInfo>();

        String sessionId = request.getSession().getId();
        String userId = "";
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        }

        List<RelAuthorInfo> resultList = new ArrayList<RelAuthorInfo>(); // 메인서버에서의 검색 결과
        String[] from = null;
       /*
        resultList.add(new RelAuthorInfo("tom1", "10", "1"));
        */

        String id = request.getParameter("id");
        String author = request.getParameter("author");        // author
        String period = request.getParameter("period");        //period
        String sel = request.getParameter("sel");
        String p = request.getParameter("page");
        String msg = request.getParameter("msg");
        String data = request.getParameter("data");

        System.out.println("\tsearchRelAuthorByAuthor : userID=" + userId + "@" + id + " : sel=" + sel
                + " : page=" + p + " : author=" + author + " : period=" + period + " : msg=" + msg);

        int selInt = Integer.parseInt(sel);
        int pageInt = Integer.parseInt(p);

        SocketComm sc = null;
        if (selInt < 5) {
            String[] s = author.split(">");
            String strQuery = "indexB^" + s[0] + " & indexB^" + period + ">완전일치>" + s[1] + ">" + s[2];

            sc = new SocketComm(userId + "@" + id, ip, port, selInt, pageInt, strQuery);
        } else if (selInt == 16) {
            String[] s = msg.split(">");
            /*
            String strQuery = "";
            if (s[1].equals("전부")) strQuery = "indexB^" + s[0];
            else 	strQuery = "indexB^" + s[0] + " & indexC^" + s[1];
            sc = new SocketComm(userId + "@" + id, ip, port, selInt, pageInt, strQuery);
            */
            sc = new SocketComm(userId + "@" + id, ip, port, selInt, pageInt, "indexB^" + s[0]);
        } else {
            sc = new SocketComm(userId + "@" + id, ip, port, selInt, pageInt, author);
        }
        sc.runStart();

        String send = "";

        if (sc.beGetGood() == -2) send = "NoData";
        else if (sc.beGetGood() == -1) send = "NotOK";
        else {
            if (selInt == 1) send = "OK";
            else if ((selInt == 2) || (selInt == 12)) {
                send += msg;
                bookInfoList.clear();
                bookInfoList = sc.getR();
            } else if (selInt == 4) {
                int progressPer = sc.getProPercent();
                int cntTmp = sc.getCount();    // 카운트
                if (progressPer < 100) send = "NotOK";
                else send = cntTmp + "!@#$" + progressPer + "!@#$NOT";
            } else if (selInt == 9) send = "OK";
            else if (selInt == 10) {
                resultList = sc.getQ(id); // 메인서버에서의 검색 결과

                /*
                for (int i = 0; i < resultList.size(); i++) {
				    RelAuthorInfo tmpRA = resultList.get(i);
				    String tmpNickname = searchNicknameByAuthor(tmpRA.getRelAuthor());
				    tmpRA.setNickname(tmpNickname);
				}
                 */
                send = "OK";
            } else if (selInt == 15) {
                from = sc.getFrom(author.split(">")[1]);
                send = "OK";
            } else send = "OK";
        }

        //System.out.println("\tsearchRelAuthorByAuthor : userID=" + userId + "@" + id + " : sel=" + sel
        //		+ " : page=" + p + " : author=" + author + " : period=" + period + " : send=" + send);

        SendInfo si = null;
        if ((selInt < 5) || (selInt == 12))
            si = new SendInfo(id, author, period, sel, p, send, gson.toJson(bookInfoList), 1);
        else if ((selInt == 15) && (from != null))
            si = new SendInfo(id, author, period, sel, p, send, gson.toJson(from), 1);
        else
            si = new SendInfo(id, author, period, sel, p, send, gson.toJson(resultList), 1);

        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", gson.toJson(si));

        return modelAndView;
    }

    //저자와 연관저자를 키로 찾은 책의 정보를 보내줌
    @RequestMapping(value = {"/main/profile/search-rel-author-content"})
    public ModelAndView searchRelAuthorContent(HttpServletRequest request) {

        Gson gson = new Gson();

        String author = request.getParameter("author");
        String relAuthor = request.getParameter("rel-author");
        String period = request.getParameter("period");
        String id = request.getParameter("id");
        // 메인 서버와 통신
        // 저자와 연관저자로 검색 부분이 필요

        String userId = "";
        String sessionId = request.getSession().getId();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        }

        List<AuthorBookContent> resultList = new ArrayList<AuthorBookContent>(); //메인 서버에서의 검색 결과

        boolean isReady = true;

        String strQuery = "indexB^" + author + " | indexB^" + relAuthor + ">완전일치>" + period;

        SocketComm sc = new SocketComm(userId + "@" + id, ip, port, 1, 0, strQuery);
        sc.runStart();

        while (true) {
            //try {Thread.sleep(20000);} catch (InterruptedException e) {}
            sc = new SocketComm(userId + "@" + id, ip, port, 4, 0);
            sc.runStart();

            try {
                Thread.sleep(200);
            } catch (InterruptedException e) {
            }
            if (sc.getProPercent() == 100) break;
            else if (sc.beGetGood() == -2) {
                isReady = false;
                break;
            }
        }

        int count = sc.getCount();
        System.out.println("sss : " + sc.getCount());

        if (isReady) {
            sc = new SocketComm(userId + "@" + id, ip, port, 2, 0);
            sc.runStart();

            resultList = sc.getS();
        }
        SendInfo si = new SendInfo(id, author, period, "2", "0", "" + count, gson.toJson(resultList), 1);

        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", gson.toJson(si));

        return modelAndView;
    }


    @RequestMapping(value = {"/main/statistics"})
    public ModelAndView statisticsPage(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        ModelAndView modelAndView = new ModelAndView("main_statistics");
        modelAndView.addObject("colSize", tableOptionRepository.findByUserAccount_UserId(sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId()).get(0).getColSizes());
        modelAndView.addObject("userId", userId);
        modelAndView.addObject("userType", sessionRepository.findByJSessionId(sessionId).get(0).getType());
        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userId);
        modelAndView.addObject("userGroups", userGroups);
        return modelAndView;
    }

    @RequestMapping(value = {"/main/statistics/search-author"})
    public ModelAndView statisticsSearchAuthor(HttpServletRequest request) {
// 클라이언트로 부터 받아온 search keyword
        String searchKeyword = request.getParameter("keyword");
        // 메인 서버와 통신
        // 저자 검색 부분이 필요

        // 저자 검색 결과가 들어있는 리스트
        List<String> authorList = new ArrayList<String>();
        authorList.add("tom1");
        authorList.add("tom0");

        List<AuthorAndRelAuthor> resultList = searchNicknamesByAuthors(authorList);
        ModelAndView modelAndView = new ModelAndView("api");
        Gson gson = new Gson();
        modelAndView.addObject("json", gson.toJson(resultList));
        return modelAndView;
    }

    @RequestMapping(value = {"/main/statistics/search-total-data"})
    public ModelAndView getStatisticsTotal(HttpServletRequest request) {
        String id = request.getParameter("id");
        String searchPeriod = request.getParameter("searchPeriod");

        ArrayList<String> authorList = new ArrayList<String>();
        authorList.add("total");

        String userId = "";
        String sessionId = request.getSession().getId();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        }
        System.out.println("ZZZZZZZZZZ: timeE = " + searchPeriod);

        String[] dayMonth2 = searchPeriod.split("-");
        String[] dayMonth = dayMonth2[2].split("_");

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        System.out.println("ZZZZZZZZZZ: timeE = " + dayMonth2[0] + " :1: timeNow = " + dayMonth2[1]);

        Calendar c = Calendar.getInstance();
        try {
            c.setTime(formatter.parse(dayMonth2[0]));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String startTime = c.get(c.YEAR) + (String.format("%02d", c.get(c.MONTH) + 1)) + (String.format("%02d", c.get(c.DATE))) + "000000";

        c = Calendar.getInstance();
        try {
            c.setTime(formatter.parse(dayMonth2[1]));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        //if (dayMonth[1].equals("monthly")) c.add(c.MONTH, 1);
        //else c.add(c.DATE, 1);
        //if (dayMonth[1].equals("monthly")) c.add(c.MONTH, -19);
        //else c.add(c.DATE, -560);

        String endTime = c.get(c.YEAR) + (String.format("%02d", c.get(c.MONTH) + 1)) + (String.format("%02d", c.get(c.DATE))) + "235959";
        String msg = startTime + "-" + endTime + ">" + dayMonth2[2];

        SocketComm sc = new SocketComm(userId + "@" + id, ip, port, 23, 0, msg);
        sc.runStart();

        //String send = "";

        while (true) {
            //send = "OK";
            if (sc.beGetGood() >= 0) break;
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
            }
        }

        LinkedHashMap<String, Integer> hMap = null;
        if (dayMonth[1].equals("monthly"))
            hMap = graphDataprocessingByMonthly("total", startTime, endTime, sc.getStatitcsTime(), sc.getStatitcs());
        else
            hMap = graphDataprocessingByDaily("total", startTime, endTime, sc.getStatitcsTime(), sc.getStatitcs());

        ArrayList<LinkedHashMap<String, String>> resultList = getGraphDataByAuthorsAndPeriod("total", hMap);

        ModelAndView modelAndView = new ModelAndView("api");
        Gson gson = new Gson();
        modelAndView.addObject("json", gson.toJson(resultList));

        return modelAndView;
    }

    public LinkedHashMap<String, Integer> graphDataprocessingByMonthly(String author, String startTime, String endTime, String[] time, int[] value) {
        LinkedHashMap<String, Integer> hMap = new LinkedHashMap<String, Integer>();

        Calendar s = Calendar.getInstance();        //오늘 날짜를 기준으로..
        s.set(Integer.parseInt(startTime.substring(0, 4)), Integer.parseInt(startTime.substring(4, 6)) - 1, Integer.parseInt(startTime.substring(6, 8)));
        Calendar e = Calendar.getInstance();        //오늘 날짜를 기준으로..
        e.set(Integer.parseInt(endTime.substring(0, 4)), Integer.parseInt(endTime.substring(4, 6)) - 1, Integer.parseInt(endTime.substring(6, 8)));

        String timeS = "";
        String timeNow = "";
        String timeE = e.get(e.YEAR) + String.format("%02d", e.get(e.MONTH) + 1);

        for (int i = 0; i < value.length; i++) {
            timeS = s.get(s.YEAR) + String.format("%02d", s.get(s.MONTH) + 1);
            timeNow = time[i].substring(0, 6);
            while (timeS.compareTo(timeNow) < 0) {
                hMap.put(timeS, 0);

                s.add(s.MONTH, 1);
                timeS = s.get(s.YEAR) + String.format("%02d", s.get(s.MONTH) + 1);
            }
            if (timeE.compareTo(timeNow) < 0) {
                System.out.println(i + " :222: timeE = " + timeE + " :1: timeNow = " + timeNow);
                break;
            }
            if (timeS.compareTo(timeNow) == 0) {
                hMap.put(timeS, value[i]);
            }
            s.add(s.MONTH, 1);
        }

        timeS = s.get(s.YEAR) + String.format("%02d", s.get(s.MONTH) + 1);

        while (timeS.compareTo(timeE) <= 0) {
            hMap.put(timeS, 0);

            s.add(s.MONTH, 1);

            timeS = s.get(s.YEAR) + String.format("%02d", s.get(s.MONTH) + 1);
        }

        return hMap;
    }

    public LinkedHashMap<String, Integer> graphDataprocessingByDaily(String author, String startTime, String endTime, String[] time, int[] value) {
        LinkedHashMap<String, Integer> hMap = new LinkedHashMap<String, Integer>();

        Calendar s = Calendar.getInstance();        //오늘 날짜를 기준으로
        s.set(Integer.parseInt(startTime.substring(0, 4)), Integer.parseInt(startTime.substring(4, 6)) - 1, Integer.parseInt(startTime.substring(6, 8)));
        Calendar e = Calendar.getInstance();        //오늘 날짜를 기준으로..
        e.set(Integer.parseInt(endTime.substring(0, 4)), Integer.parseInt(endTime.substring(4, 6)) - 1, Integer.parseInt(endTime.substring(6, 8)));

        String timeS = "";
        String timeNow = "";
        String timeE = e.get(e.YEAR) + (String.format("%02d", e.get(e.MONTH) + 1)) + (String.format("%02d", e.get(e.DATE)));

        for (int i = 0; i < value.length; i++) {
            timeS = s.get(s.YEAR) + (String.format("%02d", s.get(s.MONTH) + 1)) + (String.format("%02d", s.get(s.DATE)));
            timeNow = time[i].substring(0, 8);
            while (timeS.compareTo(timeNow) < 0) {
                hMap.put(timeS, 0);
//                System.out.println(timeS + " : ");
                s.add(s.DATE, 1);
                timeS = s.get(s.YEAR) + (String.format("%02d", s.get(s.MONTH) + 1)) + (String.format("%02d", s.get(s.DATE)));
            }
            if (timeE.compareTo(timeNow) < 0) {
                System.out.println(i + " :222: timeE = " + timeE + " :1: timeNow = " + timeNow);
                break;
            }
            if (timeS.compareTo(timeNow) == 0) {
                //System.out.println(i + " :0: time = " + time[i] + " : value = " + value[i] + " : timeS = " + timeS);
                hMap.put(timeS, value[i]);
            }
            s.add(s.DATE, 1);
        }

        timeS = s.get(s.YEAR) + (String.format("%02d", s.get(s.MONTH) + 1)) + (String.format("%02d", s.get(s.DATE)));

        while (timeS.compareTo(timeE) <= 0) {
            hMap.put(timeS, 0);

            s.add(s.DATE, 1);
            timeS = s.get(s.YEAR) + (String.format("%02d", s.get(s.MONTH) + 1)) + (String.format("%02d", s.get(s.DATE)));
        }

        return hMap;
    }


//    @RequestMapping(value = {"/main/statistics/search-author-total-data"})
//    public ModelAndView getStatisticsAuthorTotal(HttpServletRequest request) {
//        String searchPeriod = request.getParameter("searchPeriod");
//
//        ArrayList<String> authorList = new ArrayList<String>();
//        authorList.add("total");
//
//        ArrayList<LinkedHashMap<String, String>> resultList = getGraphDataByAuthorsAndPeriod(authorList, searchPeriod);
//
//        ModelAndView modelAndView = new ModelAndView("api");
//        Gson gson = new Gson();
//        modelAndView.addObject("json", gson.toJson(resultList));
//        return modelAndView;
//    }

    @RequestMapping(value = {"/main/statistics/search-author-data"})
    public ModelAndView getStatisticsAuthor(HttpServletRequest request) {

        Gson gson = new Gson();

        String id = request.getParameter("id");
        String sel = request.getParameter("sel");
        int selInt = Integer.parseInt(sel);
        String authorJson = request.getParameter("authorJson");
        String keyword = request.getParameter("keyword");
        System.out.println("keyword : " + keyword);

        String userId = "";
        String sessionId = request.getSession().getId();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        }
        SocketComm sc = null;
        String send = "";
        ArrayList<LinkedHashMap<String, String>> resultList = new ArrayList<LinkedHashMap<String, String>>();

        // userId로 검색한 그룹의 리스트
        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userId);

        if (selInt <= 1) {
            String msg = request.getParameter("msg");
            msg = wordParse(msg);

            String[] s = msg.split(">");
            String groupChecked = "";
            if (!s[4].equals(Constant.GROUP_NAME_ALL)) {
                for (int j = 0; j < userGroups.size(); j++) {
                    if (userGroups.get(j).getGroupName().getGroupName().equals(s[4])) {
                        groupChecked = " & indexC^" + s[4];
                        break;
                    }
                }
            }
            msg = s[0] + groupChecked + ">" + s[1] + ">" + s[2] + ">" + s[3];

            sc = new SocketComm(userId + "@" + id, ip, port, 21, 0, msg);
            sc.runStart();

            send = "OK";
        } else {

            sc = new SocketComm(userId + "@" + id, ip, port, 22, 0);
            sc.runStart();

            if (sc.beGetGood() >= 0) {
                String msg = request.getParameter("msg");
                msg = wordParse(msg);

                System.out.println("msg : " + msg);

                String[] s = msg.split(">");
                System.out.println("resultList : " + resultList);

                String[] s1 = s[2].split("-");
                String[] s2 = s[3].split("_");

                Calendar c = Calendar.getInstance();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                try {
                    c.setTime(formatter.parse(s1[0]));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                String startTime = c.get(c.YEAR) + (String.format("%02d", c.get(c.MONTH) + 1)) + (String.format("%02d", c.get(c.DATE))) + "000000";
                System.out.println("startTime : " + startTime);

                try {
                    c.setTime(formatter.parse(s1[1]));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                if (s2[1].equals("monthly")) c.add(c.MONTH, 1);
                else c.add(c.DATE, 1);

                String endTime = c.get(c.YEAR) + (String.format("%02d", c.get(c.MONTH) + 1)) + (String.format("%02d", c.get(c.DATE))) + "235959";
                System.out.println("endTime : " + endTime);

                send = "OK";

                LinkedHashMap<String, Integer> hMap = null;
                if (s2[1].equals("monthly"))
                    hMap = graphDataprocessingByMonthly(keyword, startTime, endTime, sc.getStatitcsTime(), sc.getStatitcs());
                else
                    hMap = graphDataprocessingByDaily(keyword, startTime, endTime, sc.getStatitcsTime(), sc.getStatitcs());

                ArrayList<LinkedHashMap<String, String>> authorJsonTmp
                        = (ArrayList<LinkedHashMap<String, String>>) gson.fromJson(authorJson, ArrayList.class);
                resultList = getGraphDataByAuthorsAndPeriod(authorJsonTmp, keyword, hMap);
            } else if (sc.beGetGood() == -1) send = "NotOK";
            else send = "NoData";
        }

        SendInfo si = new SendInfo(id, sel, send, keyword, gson.toJson(resultList));

        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", gson.toJson(si));

        return modelAndView;
    }

    private ArrayList<LinkedHashMap<String, String>> getGraphDataByAuthorsAndPeriod
            (ArrayList<LinkedHashMap<String, String>> authorJsonTmp, String author, LinkedHashMap<String, Integer> hMap) {
        ArrayList<LinkedHashMap<String, String>> resultList = new ArrayList<LinkedHashMap<String, String>>();

        Set<String> hSet = hMap.keySet();
        Iterator<String> iter = hSet.iterator();
        int i = 0;
        while (iter.hasNext()) {
            LinkedHashMap<String, String> tMap = (new LinkedHashMap<String, String>());
            String keyData = iter.next();

            if (authorJsonTmp == null) {
                tMap.put("index", keyData);
                tMap.put(author, String.valueOf(hMap.get(keyData)));
            } else {
                tMap.putAll(authorJsonTmp.get(i));
                tMap.put(author, String.valueOf(hMap.get(keyData)));
            }

            resultList.add(tMap);
            i++;
        }
        System.out.println("resultList : " + resultList);

        return resultList;
    }

    private ArrayList<LinkedHashMap<String, String>> getGraphDataByAuthorsAndPeriod(String author, LinkedHashMap<String, Integer> hMap) {
        ArrayList<LinkedHashMap<String, String>> resultList = new ArrayList<LinkedHashMap<String, String>>();

        Set<String> hSet = hMap.keySet();
        Iterator<String> iter = hSet.iterator();
        while (iter.hasNext()) {
            LinkedHashMap<String, String> tMap = (new LinkedHashMap<String, String>());
            String keyData = iter.next();

            tMap.put("index", keyData);
            tMap.put(author, String.valueOf(hMap.get(keyData)));

            resultList.add(tMap);
        }

        return resultList;
    }

/*    private ArrayList<LinkedHashMap<String, String>> getGraphDataByAuthorsAndPeriod(ArrayList<String> authorList, String searchPeriod) {
        ArrayList<LinkedHashMap<String, String>> resultList = new ArrayList<LinkedHashMap<String, String>>();

        switch (Integer.parseInt(searchPeriod)) {
            case SEARCH_PERIOD.daily:
                for (int i = 0; i < 30; i++) {
                    LinkedHashMap<String, String> tMap = (new LinkedHashMap<String, String>());
                    tMap.put("index", String.valueOf(i));
                    Random random = new Random();
                    for (String author : authorList) {
                        tMap.put(author, String.valueOf(random.nextInt(700)));
                    }
                    resultList.add(tMap);
                }
                break;
            case SEARCH_PERIOD.weekly:
                for (int i = 0; i < 7; i++) {
                    LinkedHashMap<String, String> tMap = (new LinkedHashMap<String, String>());
                    tMap.put("index", String.valueOf(i));
                    Random random = new Random();
                    for (String author : authorList) {
                        tMap.put(author, String.valueOf(random.nextInt(1000)));
                    }
                    resultList.add(tMap);
                }
                break;
            case SEARCH_PERIOD.monthly:
                for (int i = 0; i < 12; i++) {
                    LinkedHashMap<String, String> tMap = (new LinkedHashMap<String, String>());
                    tMap.put("index", String.valueOf(i));
                    Random random = new Random();
                    for (String author : authorList) {
                        tMap.put(author, String.valueOf(random.nextInt(2000)));
                    }
                    resultList.add(tMap);
                }
                break;
            case SEARCH_PERIOD.yearly:
                for (int i = 0; i < 10; i++) {
                    LinkedHashMap<String, String> tMap = (new LinkedHashMap<String, String>());
                    tMap.put("index", String.valueOf(i));
                    Random random = new Random();
                    for (String author : authorList) {
                        tMap.put(author, String.valueOf(random.nextInt(3000)));
                    }
                    resultList.add(tMap);
                }
                break;
        }

        return resultList;
    }*/

    @RequestMapping(value = {"/main/status"})
    public String statusPage() {
        return "main_system_status";
    }

    @RequestMapping(value = {"/main/search"})
    public ModelAndView searchPage(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        ModelAndView modelAndView = new ModelAndView("main_search");
        modelAndView.addObject("userId", userId);
        modelAndView.addObject("colSize", tableOptionRepository.findByUserAccount_UserId(sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId()).get(0).getColSizes());
        modelAndView.addObject("userType", sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getType());
        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userId);
        modelAndView.addObject("userGroups", userGroups);
        return modelAndView;
    }

//    @RequestMapping(value = {"/main/status"})
//    public String statusPage() {
//        return "main_system_status";
//    }

    @RequestMapping(value = "/main/history/add")
    public ModelAndView addHistory(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId = "";
        List<Session> sessions = sessionRepository.findByJSessionId(sessionId);
        if (sessions.size() > 0) {
//            for (Session session : sessions) {
//                //admin type에 대한 체크가 들어가야함
//            }
            Session session = sessions.get(0);
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            String word = request.getParameter("data");
            if (userHistoryRepository.findByUserAccount_UserIdAndWord(userId, word).size() <= 0) {
                UserHistory userHistory = new UserHistory(userAccountRepository.findByUserId(userId).get(0),
                        request.getParameter("data"), new java.util.Date().getTime());
                userHistoryRepository.save(userHistory);

            }
            if (UserType.isAdminUser(session.getType()) && adminHistoryRepository.findByAdminAccount_UserIdAndWord(userId, word).size() <= 0) {
                AdminHistory adminHistory = new AdminHistory(userAccountRepository.findByUserId(userId).get(0),
                        request.getParameter("data"), new java.util.Date().getTime());
                adminHistoryRepository.save(adminHistory);
            }
        }
        return new ModelAndView("api").addObject("json", "");
    }

    @RequestMapping(value = "/main/searching")
    public ModelAndView searchItems(HttpServletRequest request) {
        Gson gson = new Gson();
        String id = request.getParameter("id");
        String job = request.getParameter("job");
        String jobOrder = request.getParameter("jobOrder");
        String sel = request.getParameter("sel");
        int selInt = Integer.parseInt(sel);
        String p = request.getParameter("page");
        int pageInt = Integer.parseInt(p);
        String msg = request.getParameter("msg");

        List<BookInfo> bookInfoList = new ArrayList<BookInfo>();
        String sessionId = request.getSession().getId();
        String userId = "";
        List<Session> sessions = sessionRepository.findByJSessionId(sessionId);
        if (sessions.size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
        } else {
            return new ModelAndView("api").addObject("json", "");
        }

        // userId로 검색한 그룹의 리스트
        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userId);

        String send = "";

        SocketComm sc = null;
        boolean isGroup = false;
        if (selInt < 100) {
            if (selInt <= 1) {
                System.out.println("\tAAAA : msg = " + msg);
                msg = wordParse(msg);
                System.out.println("\tAAAA : msg = " + msg);
                String[] s = msg.split(">");
                String groupChecked = "";
                if (!s[4].equals("전부")) {
                    for (int j = 0; j < userGroups.size(); j++) {
                        if (userGroups.get(j).getGroupName().getGroupName().equals(s[4])) {
                            groupChecked = "indexC^" + s[4];
                            break;
                        }
                    }
                }
                for (int j = 0; j < userGroups.size(); j++) {
                    if (userGroups.get(j).getGroupName().getGroupName().equals(s[4])) {
                        isGroup = true;
                    }
                    if (userGroups.get(j).getGroupName().getGroupName().equals(Constant.GROUP_NAME_ALL))
                        isGroup = true;
                }
                if (groupChecked.equals(""))
                    msg = s[0] + ">" + s[1] + ">" + s[2] + ">" + s[3] + ">";
                else
                    msg = s[0] + " & " + groupChecked + ">" + s[1] + ">" + s[2] + ">" + s[3] + ">";

                System.out.println("\tAAAA : msg = " + msg);
                sc = new SocketComm(userId + "@" + id, ip, port, selInt, pageInt, msg);
            } else if ((selInt == 6) || (selInt == 8) || (selInt == 13)) {
                System.out.println("\tBBBB : msg = " + msg);
                sc = new SocketComm(userId + "@" + id, ip, port, selInt, pageInt, msg);
            } else
                sc = new SocketComm(userId + "@" + id, ip, port, selInt, pageInt);

            sc.runStart();
            long time = System.currentTimeMillis();
            //int progress = 29;

            if (sc.beGetGood() >= 0) {
                if (selInt <= 1) {
                    if (isGroup) send += "OK";                    // query
                    else send += "NotGroup";
                } else if ((selInt == 2) || (selInt == 12)) {
                    send += msg;
                    bookInfoList = sc.getR();
// 수정
                    fillNicknamesOfBookList(bookInfoList);

                    for (BookInfo bookInfo : bookInfoList) {
                        List<NicknameOption> nicknames = nicknameRepository.findByAuthor(bookInfo.getGroupName() + "_" + bookInfo.getAuthor());
                        //find in nickname table and if nickname exist, add to BookInfo
                        if (nicknames.size() > 0) {
                            bookInfo.setAuthNickname(nicknames.get(0).getNickname());
                        }
                    }
                    for (BookInfo bookInfo : bookInfoList) {
                        List<NicknameOption> nicknames = nicknameRepository.findByAuthor(bookInfo.getGroupName() + "_" + bookInfo.getReferencedAuthor());
                        //find in nickname table and if nickname exist, add to BookInfo
                        if (nicknames.size() > 0) {
                            bookInfo.setRefNickname(nicknames.get(0).getNickname());
                        }
                    }
                } else if (selInt == 3) send += sc.getKetSet();    // 연관문자
                else if (selInt == 4) {
                    int progressPer = sc.getProPercent();
                    int cntTmp = sc.getCount();    // 카운트
                    if ((cntTmp < 50) && (progressPer < 100)) send = "NotOK";
                    else {
                        if (progressPer < 100) send = cntTmp + "!@#$" + progressPer + "!@#$OK";
                        else send = cntTmp + "!@#$" + progressPer + "!@#$NOT";
                    }
                } else if (selInt == 14) {
                    int progressPer = sc.getProPercent();
                    int cntTmp = sc.getCount();    // 카운트
                    if (progressPer < 100) send = "NotOK";
                    else
                        send = cntTmp + "!@#$" + progressPer;
                } else if (selInt == 6) {
                    send += "OK";
                } else send += "EXPORT";        // R
            } else if (sc.beGetGood() == -2) {
                send = "NoData";
            } else {
                send = "NotOK";
            }
        } else {
            send = "OK";
        }

        //System.out.println(sc.beGetGood() + " :: " + send);
        System.out.println("333 : " + id + " : " + job + " : " + jobOrder + " : " + sel + " : " + p);

        SendInfo si = new SendInfo(id, job, jobOrder, sel, p, send, gson.toJson(bookInfoList));
        List<SendInfo> bookInfoString = new ArrayList<SendInfo>();
        bookInfoString.add(si);

        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", gson.toJson(bookInfoString));


        return modelAndView;
    }

    @RequestMapping(value = "/main/relative-word")
    public ModelAndView relativeWord(HttpServletRequest request) {
        Gson gson = new Gson();
        ObjectMapper om = new ObjectMapper();
        try {
            Map myMap = om.readValue(request.getParameter("data"), new TypeReference<Map<String, Object>>() {
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
/*
        BasicCom bc = new BasicCom(0, 0);
        bc.start();
        try {
            bc.join();
        } catch (Exception e) {
            e.printStackTrace();
        }
        */
        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", gson.toJson(keySet));

        return modelAndView;
    }

    @RequestMapping(value = "/main/admin-history/get")
    public ModelAndView adminHistoryGet(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId;
        Gson gson = new Gson();
        List<HistoryApi> historyApis = new ArrayList<HistoryApi>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            List<AdminHistory> adminHistories;
            adminHistories = adminHistoryRepository.findByAdminAccount_UserId(userId);

            if (adminHistories != null) {
                for (AdminHistory adminHistory : adminHistories) {
                    historyApis.add(new HistoryApi(adminHistory, !adminBookmarkRepository.findByWord(adminHistory.getWord()).isEmpty()));
                }
            }
        }
        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", gson.toJson(historyApis));


        return modelAndView;
    }

    @RequestMapping(value = "/main/admin-history/delete")
    public ModelAndView adminHistoryDelete(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("api");
        Gson gson = new Gson();
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            adminHistoryRepository.deleteById(id);
        } catch (Exception e) {
            System.out.println(e.getStackTrace());
        }
        String sessionId = request.getSession().getId();
        String userId;
        List<AdminHistory> adminHistories;
        List<HistoryApi> historyApis = new ArrayList<HistoryApi>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            adminHistories = adminHistoryRepository.findByAdminAccount_UserId(userId);

            if (adminHistories != null) {
                for (AdminHistory adminHistory : adminHistories) {
                    historyApis.add(new HistoryApi(adminHistory, !adminBookmarkRepository.findByWord(adminHistory.getWord()).isEmpty()));
                }
            }
        }
        modelAndView.addObject("json", gson.toJson(historyApis));
        return modelAndView;
    }

    @RequestMapping(value = "/main/user-history/delete")
    public ModelAndView userHistoryDelete(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("api");
        Gson gson = new Gson();
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            userHistoryRepository.deleteById(id);
        } catch (Exception e) {
            System.out.println(e.getStackTrace());
        }
        String sessionId = request.getSession().getId();
        String userId;
        List<UserHistory> userHistories;
        List<HistoryApi> historyApis = new ArrayList<HistoryApi>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            userHistories = userHistoryRepository.findByUserAccount_UserId(userId);

            if (userHistories != null) {
                for (UserHistory uHistory : userHistories) {
                    historyApis.add(new HistoryApi(uHistory));
                }
            }
        }
        modelAndView.addObject("json", gson.toJson(historyApis));
//        modelAndView.addObject("json", gson.toJson(rtnArray));
        return modelAndView;
    }

    @RequestMapping(value = "/main/user-history/get")
    public ModelAndView userHistoryGet(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId;
        List<UserHistory> userHistories;
        Gson gson = new Gson();
        List<HistoryApi> historyApis = new ArrayList<HistoryApi>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            userHistories = userHistoryRepository.findByUserAccount_UserId(userId);

            if (userHistories != null) {
                for (UserHistory uHistory : userHistories) {
                    historyApis.add(new HistoryApi(uHistory));
                }
            }
        }
        ModelAndView modelAndView = new ModelAndView("api");
//        modelAndView.addObject("json", gson.toJson(rtnArray));
//        System.out.println(historyApis.size());
        modelAndView.addObject("json", gson.toJson(historyApis));


        return modelAndView;
    }

    @RequestMapping(value = "/main/admin-bookmark/delete")
    public ModelAndView adminBookmarkDelete(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String adminId;
//        Gson gson = new Gson();
//        List<UserHistoryApi> userHistoryApis = new ArrayList<UserHistoryApi>();

        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            adminId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            String word = request.getParameter("data");
            List<AdminHistory> adminHistories = adminHistoryRepository.findByWord(word);
            for (AdminHistory adminHistory : adminHistories) {
                adminHistory.setAdminBookmark(null);
                adminHistoryRepository.save(adminHistory);
            }
            commonBookmarkRepository.deleteByAdminBookmark_Word(word);
            adminBookmarkRepository.deleteByWord(word);

//            System.out.println(word);
        }
        return new ModelAndView("api").addObject("json", "");
    }

    @RequestMapping(value = "/main/common-bookmark/count/update")
    public ModelAndView commonBookmarkCountUpdate(HttpServletRequest request) {
        String id = request.getParameter("id");
        String sessionId = request.getSession().getId();
        String userId;
//        System.out.println("!!!!!!@@@");
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
//            System.out.println(id + "@@@@@@@");
            List<CommonBookmark> commonBookmarks = commonBookmarkRepository.findById(Long.parseLong(id));
//            System.out.println("@@@@@");
            if (commonBookmarks.size() > 0) {
                CommonBookmark commonBookmark = commonBookmarks.get(0);
                String msg = wordParse(searchWordParse(commonBookmark.getAdminBookmark().getWord()));

                SocketComm sc = new SocketComm(userId + "@" + "A_" + System.currentTimeMillis(), ip, port, 18, 0, msg);
                sc.runStart();
                int result = sc.beGetGood();

                //System.out.println("ALRAM96!!common!!!! msg : " + result);
                commonBookmark.setCount(result);
                commonBookmarkRepository.save(commonBookmark);

            }
        }
        return new ModelAndView("api").addObject("json", "");
    }

    @RequestMapping(value = "/main/common-bookmark/get")
    public ModelAndView adminBookmarkGet(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId;
        List<CommonBookmark> commonBookmarks;
        Gson gson = new Gson();
        List<HistoryApi> historyApis = new ArrayList<HistoryApi>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            commonBookmarks = commonBookmarkRepository.findByUserAccount_UserId(userId);

            if (commonBookmarks != null) {
                List<String> resultCommonBookmarkCountList = new ArrayList<String>();
                //commmonbookmark들에 대한 개수 검색결과 리스트

                SocketComm sc = null;
                for (int i = 0; i < commonBookmarks.size(); i++) {

                    String msg = wordParse(searchWordParse(commonBookmarks.get(i).getAdminBookmark().getWord()));

                    sc = new SocketComm(userId + "@" + "A_" + System.currentTimeMillis(), ip, port, 18, 0, msg);
                    sc.runStart();
                    int result = sc.beGetGood();
                    System.out.println("common-bookmark/get :: AAAAA : " + i + " : " + msg + "  => " + result + "  => " + commonBookmarks.get(i).getCount());


                    if (result > commonBookmarks.get(i).getCount()) {
                        historyApis.add(new HistoryApi(commonBookmarks.get(i), true)); //date가 update된 경우
                    } else {
                        historyApis.add(new HistoryApi(commonBookmarks.get(i), false));
                    }
                }
            }
        }
        ModelAndView modelAndView = new ModelAndView("api");
//        modelAndView.addObject("json", gson.toJson(rtnArray));
        modelAndView.addObject("json", gson.toJson(historyApis));

        return modelAndView;
    }

    @RequestMapping(value = "/main/admin-bookmark/add")
    public ModelAndView adminBookmarkAdd(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String adminId;

        String id = request.getParameter("id");
        String msg = request.getParameter("msg");
        String word = request.getParameter("data");

        msg = wordParse(searchWordParse(word));
        System.out.println("userBookmarkAdd : id = " + id + " : msg = " + msg);

        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            adminId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            List<UserAccount> adminAccounts = userAccountRepository.findByUserId(adminId);
            if (adminAccounts.size() > 0) {
                List<AdminHistory> adminHistories = adminHistoryRepository.findByAdminAccount_UserIdAndWord(adminId, word);
                if (adminHistories.size() > 0 && adminBookmarkRepository.findByWord(word).size() <= 0) {
                    AdminHistory adminHistory = adminHistories.get(0);
                    AdminBookmark tmpAdminBookmark = adminBookmarkRepository.save(new AdminBookmark(adminAccounts.get(0), word));
                    adminHistory.setAdminBookmark(tmpAdminBookmark);
                    adminHistoryRepository.save(adminHistory);
                    List<UserAccount> allUsers = userAccountRepository.findAll();
                    for (UserAccount userAccount : allUsers) {
                        commonBookmarkRepository.save(new CommonBookmark(userAccount, tmpAdminBookmark, 0));
                    }
                    SocketComm sc = new SocketComm(adminId + "@" + "A_" + System.currentTimeMillis(), ip, port, 19, 0, msg);
                    sc.runStart();
                }
            }
        }
        return new ModelAndView("api").addObject("json", "");
    }

    @RequestMapping(value = "/main/user-bookmark/delete")
    public ModelAndView userBookmarkDelete(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId;
//        Gson gson = new Gson();
//        List<UserHistoryApi> userHistoryApis = new ArrayList<UserHistoryApi>();

        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            String word = request.getParameter("data");
            List<UserHistory> userHistories = userHistoryRepository.findByUserAccount_UserIdAndWord(userId, word);
            if (userHistories.size() > 0) {
                UserHistory userHistory = userHistories.get(0);
                userHistory.setUserBookmark(null);
                userHistoryRepository.save(userHistory);
            }
            userBookmarkRepository.deleteByUserAccount_UserIdAndWord(userId, word);
        }
        return new ModelAndView("api").addObject("json", "");
    }

    @RequestMapping(value = "/main/user-bookmark/add")
    public ModelAndView userBookmarkAdd(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId;

        String id = request.getParameter("id");
        String msg = request.getParameter("msg");
        String word = request.getParameter("data");

        msg = wordParse(searchWordParse(word));
        //System.out.println("userBookmarkAdd : id = " + id + " : msg = " + msg);

        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            List<UserHistory> userHistories = userHistoryRepository.findByUserAccount_UserIdAndWord(userId, word);
            if (userHistories.size() > 0) {
                UserHistory userHistory = userHistories.get(0);
                UserBookmark tmpBookmark = userBookmarkRepository.save(new UserBookmark(userHistory));
                userHistory.setUserBookmark(tmpBookmark);
                userHistoryRepository.save(userHistory);

                SocketComm sc = new SocketComm(userId + "@" + "A_" + System.currentTimeMillis(), ip, port, 19, 0, msg);
                sc.runStart();
            }
        }
        return new ModelAndView("api").addObject("json", "");
    }

    @RequestMapping(value = "/main/user-bookmark/count/update")
    public ModelAndView userBookmarkCountUpdate(HttpServletRequest request) {
        String id = request.getParameter("id");
        String sessionId = request.getSession().getId();
        String userId;
//        System.out.println("!!!!!!@@@");
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
//            System.out.println(id + "@@@@@@@");
            List<UserBookmark> userBookmarks = userBookmarkRepository.findById(Long.parseLong(id));
//            System.out.println("@@@@@");
            if (userBookmarks.size() > 0) {

                UserBookmark userBookmark = userBookmarks.get(0);

                String msg = wordParse(searchWordParse(userBookmark.getWord()));

                SocketComm sc = new SocketComm(userId + "@" + "A_" + System.currentTimeMillis(), ip, port, 18, 0, msg);
                sc.runStart();
                int result = sc.beGetGood();
                System.out.println("ALRAM97!!user!!!! msg : " + result);

                userBookmark.setCount(result);
                userBookmarkRepository.save(userBookmark);
            }
        }
        return new ModelAndView("api").addObject("json", "");
    }

    @RequestMapping(value = "/main/user-bookmark/get")
    public ModelAndView userBookmarkGet(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId;
        List<UserBookmark> userBookmarks;
        Gson gson = new Gson();
        List<HistoryApi> historyApis = new ArrayList<HistoryApi>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            userBookmarks = userBookmarkRepository.findByUserAccount_UserId(userId);

            if (userBookmarks != null) {
                //bookmark들에 대해 새로운 데이터 개수를 받아오는 부분 필요
                SocketComm sc = null;
                for (int i = 0; i < userBookmarks.size(); i++) {
//                    historyApis.add(new HistoryApi(userBookmarks.get(i), false));

                    String msg = wordParse(searchWordParse(userBookmarks.get(i).getWord()));
                    sc = new SocketComm(userId + "@" + "A_" + System.currentTimeMillis(), ip, port, 18, 0, msg);
                    sc.runStart();
                    int result = sc.beGetGood();
                    System.out.println("user-bookmark/get :: AAAAA : " + i + " : " + msg + " => " + result + "  => " + userBookmarks.get(i).getCount());

                    if (result > userBookmarks.get(i).getCount()) {
                        historyApis.add(new HistoryApi(userBookmarks.get(i), true)); //데이터가 업데이트 된 경우
                    } else {
                        historyApis.add(new HistoryApi(userBookmarks.get(i), false));
                    }
                }
                if (userBookmarks.size() > 0) {
                    //sc = new SocketComm(userId + "@" + "A_" + System.currentTimeMillis(), ip, port, 5, 0);
                    //sc.runStart();
                }

            }
        }
        ModelAndView modelAndView = new ModelAndView("api");
//        modelAndView.addObject("json", gson.toJson(rtnArray));
        modelAndView.addObject("json", gson.toJson(historyApis));

        return modelAndView;
    }

    @RequestMapping(value = "/main/table-option/update")
    public ModelAndView userTableUpdate(HttpServletRequest request) {

//        System.out.println(request.getParameter("colSize"));
        ObjectMapper om = new ObjectMapper();
        try {
            String userId = sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId();
            UserTableOption tableOption = tableOptionRepository.findByUserAccount_UserId(userId).get(0);

//            Map a= om.readValue(request.getParameter("colSize"), new TypeReference<Map<String, Object>>() {
//            });
            tableOption.setColSizes((ArrayList) om.readValue(request.getParameter("colSize"), new TypeReference<List>() {
            }));
            tableOptionRepository.save(tableOption);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("api");
    }

    @RequestMapping(value = "/main/nickname/update")
    public ModelAndView updateNickname(HttpServletRequest request) {
        String nickname = request.getParameter("nickname");
        String author = request.getParameter("author");
//        String nickname = request.getParameter("nickname");
        String priority = request.getParameter("priority");
        String note = request.getParameter("note");

        System.out.println("/nickname/update : " + nickname + " : " + author + " : " + priority + " : " + note);


        List<NicknameOption> nicknameOptions = nicknameRepository.findByAuthor(author);
        ModelAndView modelAndView = new ModelAndView("api");
        if (nicknameOptions.size() <= 0) {
            NicknameOption nicknameOption = new NicknameOption(author, nickname, priority, note);
            nicknameRepository.save(nicknameOption);
        } else {
            NicknameOption nicknameOption = nicknameOptions.get(0);
            nicknameOption.setNickname(nickname);
            nicknameOption.setPriority(priority);
            nicknameOption.setNote(note);
            nicknameOption.setLastModifiedDate();
            nicknameRepository.save(nicknameOption);
        }
        modelAndView.addObject("json", true);

        return modelAndView;
    }

    @RequestMapping(value = "/main/nickname/get")
    public ModelAndView getNickname(HttpServletRequest request) {
        String author = request.getParameter("author");
        List<NicknameOption> nicknameOptions = nicknameRepository.findByAuthor(author);
        Gson gson = new Gson();
        ModelAndView modelAndView = new ModelAndView("api");
        if (nicknameOptions.size() <= 0) {
            modelAndView.addObject("json", false);
        } else {
            modelAndView.addObject("json", gson.toJson(nicknameOptions.get(0)));
        }
        return modelAndView;
    }

    @RequestMapping(value = "/main/nickname/check")
    public ModelAndView checkNickname(HttpServletRequest request) {
        String nickname = request.getParameter("nickname");
        String author = request.getParameter("author");
        boolean result;
        List<NicknameOption> nicknameOptions = nicknameRepository.findByNickname(nickname);
        if (nicknameOptions.size() <= 0) {
            result = true;
        } else if (nicknameOptions.get(0).getAuthor().equals(author)) {
            result = true;
        } else {
            result = false;
        }

        //        Gson gson = new Gson();
        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", result);
        return modelAndView;
    }


    @RequestMapping(value = "/main/nickname/delete")
    public ModelAndView deleteNickname(HttpServletRequest request) {
        String author = request.getParameter("author");

        nicknameRepository.deleteByAuthor(author);
        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", true);

        return modelAndView;
    }

    @RequestMapping(value = "/error")
    public String errorPage() {
        return "error";
    }

//    @RequestMapping(value = "/test")
//    public String testPage() {
//        return "test";
//    }

    private List<AuthorAndRelAuthor> searchNicknamesByAuthors(List<String> authorList) {
        List<AuthorAndRelAuthor> resultList = new ArrayList<AuthorAndRelAuthor>();
        for (String author : authorList) {
            List<NicknameOption> tmpNicknameList = nicknameRepository.findByAuthor(author);
            if (tmpNicknameList.size() > 0) {
                resultList.add(new AuthorAndRelAuthor(author, tmpNicknameList.get(0).getNickname()));
            } else {
                resultList.add(new AuthorAndRelAuthor(author, ""));
            }
        }
        return resultList;
    }

    private String searchNicknameByAuthor(String author) {
        List<NicknameOption> tmpNicknameList = nicknameRepository.findByAuthor(author);
        String nickname = "";
        if (tmpNicknameList.size() > 0) {
            nickname = tmpNicknameList.get(0).getNickname();
        }
        return nickname;
    }

    public String wordParse(String str) {
        String[] s = str.split(">");
        String groups = s[s.length - 1];

        String first = " <AND> ";
        String second = " <OR> ";
        String firstAdd = " & ";
        String secondAdd = " | ";

        s = str.split(first);
        String word = "";

        for (int i = 0; i < s.length; i++) {
            String[] s1 = s[i].split(second);
            if (s1.length > 1) {
                for (int j = 0; j < s1.length; j++) {
                    word += wordParse2(s1[j], groups);
                    if (j != s1.length - 1) word += secondAdd;
                }
            } else word += wordParse2(s[i], groups);

            if (i != s.length - 1) word += firstAdd;
        }
        //System.out.println("End : " + str);
        //System.out.println("End : " + word);
        return word;
    }

    public String wordParse2(String str2, String groups) {
        String word = "";
        String basic = "\\^";

        String first = " & ";
        String second = " \\| ";
        String firstAdd = " & ";
        String secondAdd = " | ";

        String[] str = str2.split(basic);
        if (str.length == 1) return word;
        if (str[1].equals("")) return word;

        String[] s = str[1].split(first);

        for (int i = 0; i < s.length; i++) {
            String[] s1 = s[i].split(second);
            if (s1.length > 1) {
                for (int j = 0; j < s1.length; j++) {
                    if (!str[0].equals("indexB")) word += str[0] + "^" + s1[j];
                    else word += str[0] + "^" + getAuthorByNickname(s1[j], groups);

                    //System.out.println("BBBBBBBBBB : word : " + str[0] + "^" + s1[j]);
                    if (j != s1.length - 1) word += secondAdd;
                }
            } else {
                //System.out.println("CCCCCCCCCCCCC : word : " + str[0] + " : " + s[i]);
                if (!str[0].equals("indexB")) word += str[0] + "^" + s[i];
                else {
                    word += str[0] + "^" + getAuthorByNickname(s[i], groups);
                }
                //System.out.println("CCCCCCCCCCCCC : word : " + str[0] + "^" + s[i]);
            }

            if (i != s.length - 1) word += firstAdd;
        }

        //System.out.println("AAAAAAAAAAAAA : word : " + word);
        return word;
    }

    public String searchWordParse(String word) {
        String[] s = word.split("\":\"");
        String[] t = null;
        String SearchWord = "";

        t = s[s.length - 1].split("\"");
        String groups = t[0];        // 그룹명

        int k = 1;
        while (true) {
            t = s[k + 1].split("\"");
            if (s[k].contains("내용")) SearchWord += "indexA^" + t[0];
            else if (s[k].contains("저자")) SearchWord += "indexB^" + t[0];

            //else if (s[k].contains("참조")) SearchWord += "indexC^" + t[0];
            //System.out.println(SearchWord + " : " + s[k+2]);

            if (!s[k + 2].contains("SEL")) {
                if (s[k + 2].contains("O R")) SearchWord += " <OR> ";
                else if (s[k + 2].contains("AND")) SearchWord += " <AND> ";
                k = k + 3;
            } else break;
        }
        k = k + 3;
        if (!groups.equals("전부"))
            SearchWord += " <AND> indexC^" + groups;

        if (s[k].contains("문자포함")) SearchWord += ">문자포함";
        else if (s[k].contains("형태소")) SearchWord += ">형태소";
        else if (s[k].contains("완전일치")) SearchWord += ">완전일치";
        SearchWord += ">" + groups;

        //System.out.println(word + " => " + SearchWord);
        return SearchWord;
    }

    private String getAuthorByNickname(String name, String groups) {
        String author = "";

        String[] t = name.split(">", 2);
        String[] t1 = t[0].split("_", 2);
        if (t1.length >= 2) return name;

        String nickname = t[0];

        //System.out.println("ZZZZ :" + name + " : " + nickname + " : " + t.length);

        List<NicknameOption> nicknameOptions = nicknameRepository.findByNickname(nickname);
        if (nicknameOptions.size() > 0) {
            author = nicknameOptions.get(0).getAuthor();
        }

        if (author.equals("")) author = groups + "_" + name;

        if (t.length > 1) author = author + ">" + t[1];
        //System.out.println("ZZZZ :" + author);

        return author;
    }

    private List<BookInfo> fillNicknamesOfBookList(List<BookInfo> bookInfoList) {
        List<NicknameOption> nicknames = nicknameRepository.findAll();

        for (BookInfo bookInfo : bookInfoList) {
            for (NicknameOption nicknameOption : nicknames) {
                if (nicknameOption.getAuthor()
                        .equals(bookInfo.getGroupName() + "_" + bookInfo.getAuthor())) {
                    bookInfo.setAuthNickname(nicknameOption.getNickname());
                    System.out.println(bookInfo.getReferencedAuthor());
                    if (!bookInfo.getRefNickname().equals("")) {
                        break;
                    }
                } else if (bookInfo.getReferencedAuthor()
                        .equals(bookInfo.getGroupName() + "_" + bookInfo.getReferencedAuthor())) {
                    bookInfo.setRefNickname(nicknameOption.getNickname());
                    if (!bookInfo.getAuthNickname().equals("")) {
                        break;
                    }
                }
            }
        }

        return bookInfoList;
    }

    private Map<String, String> getGroupMap() {
        List<CommonGroupName> groupNames = groupNameRepository.findAll();
        Map<String, String> groupMap = new LinkedHashMap<String, String>();

        for (CommonGroupName groupName : groupNames) {
            groupMap.put(groupName.getGroupName(), groupName.getGroupId());
        }
        return groupMap;
    }

    private Map<String, String> getGroupIdMap() {
        List<CommonGroupName> groupNames = groupNameRepository.findAll();
        Map<String, String> groupMap = new LinkedHashMap<String, String>();

        for (CommonGroupName groupName : groupNames) {
            groupMap.put(groupName.getGroupId(), groupName.getGroupName());
        }
        return groupMap;
    }

//    private final class SEARCH_PERIOD {
//        final static int daily = 0, weekly = 1, monthly = 2, yearly = 3;
//    }


    private void refreshGroupList(String filePath) {
//        Gson gson = new Gson();
        File dir1 = new File(filePath);
        List<CommonGroupName> commonGroupNames = new ArrayList<CommonGroupName>();
        try {
            System.out.println("Current dir : " + dir1.getCanonicalPath());
            BufferedReader in = new BufferedReader(new FileReader(dir1));
            String s;

            while ((s = in.readLine()) != null) {
                CommonGroupName commonGroupName = new CommonGroupName(s.split(" ")[0], s.split(" ")[1]);
                commonGroupNames.add(commonGroupName);
            }
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        Map<String, String> groupIdMap = getGroupIdMap();
//        System.out.println(gson.toJson(commonGroupNames));
        for (CommonGroupName group : commonGroupNames) {
            String groupName = groupIdMap.get(group.getGroupId());
            if (groupName == null) {
                groupNameRepository.save(new CommonGroupName(group.getGroupName(), group.getGroupId()));
            } else {
                CommonGroupName groupName1 = groupNameRepository.findByGroupId(group.getGroupId()).get(0);
                groupName1.setGroupName(group.getGroupName());
                groupNameRepository.save(groupName1);
            }
        }

        List<String> orgGroupIdList = new ArrayList<String>(groupIdMap.keySet());
        for (String orgGroupId : orgGroupIdList) {
            boolean isExist = false;

            for (CommonGroupName tarGroupName : commonGroupNames) {
                if (tarGroupName.getGroupId().equals(orgGroupId)) {
                    isExist = true;
                }
            }

            if (!isExist && !orgGroupId.equals(Constant.GROUP_NAME_ALL)) {
                userGroupRepository.deleteByGroupName_GroupId(orgGroupId);
                groupNameRepository.deleteByGroupId(orgGroupId);
            }
        }

        if (groupNameRepository.findByGroupName(Constant.GROUP_NAME_ALL).size() <= 0) {
            groupNameRepository.save(new CommonGroupName(Constant.GROUP_NAME_ALL, Constant.GROUP_ID_ALL));
        }
    }
}