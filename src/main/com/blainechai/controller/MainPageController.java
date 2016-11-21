package com.blainechai.controller;

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

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

/**
 * Created by blainechai on 2016. 9. 5..
 */
@Controller
@RequestMapping("")
public class MainPageController {
    //    @RequestMapping(value = "/add", method = RequestMethod.POST)
//    public ModelAndView
    @Autowired
    private SessionRepository sessionRepository;

    @Autowired
    private UserAccountRepository userAccountRepository;

    @Autowired
    private UserHistoryRepository userHistoryRepository;

    @Autowired
    private UserTableOptionRepository tableOptionRepository;

    @Autowired
    private BookHistoryRepository bookHistoryRepository;

    @Autowired
    private NicknameRepository nicknameRepository;

    @Autowired
    private UserBookmarkRepository userBookmarkRepository;

    public static List<BookInfo> bookInfoList = new ArrayList<BookInfo>();
    public static ArrayList<String> keySet = new ArrayList<String>();


    @RequestMapping(value = {""})
    public String login() {
        return "user_login";
    }

    @RequestMapping(value = {"/main"})
    public ModelAndView mainPage(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("main_alarm");
        modelAndView.addObject("colSize", tableOptionRepository.findByUserAccount_UserId(sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId()).get(0).getColSizes());

        return modelAndView;
    }

    @RequestMapping(value = {"/main/alarm/search-user-bookmark"})
    public String getUserBookmark() {
        return "main_alarm";
    }

    @RequestMapping(value = {"/main/profile"})
    public String profilePage() {
        return "main_profiling";
    }

    // 프로파일링에서 검색 버튼 클릭시 요청 들어옴
    // 저자 검색에 대한 내용 필요
    @RequestMapping(value = {"/main/profile/search-author"})
    public ModelAndView searchAuthor(HttpServletRequest request) {
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

    //프로파일링에서 검색 후 저자-연관저자 리스트에서 대상 클릭시 요청 들어옴
    //from, to, 참조저자가 전달되야 함
    @RequestMapping(value = {"/main/profile/search-rel-author"})
    public ModelAndView searchRelAuthorByAuthor(HttpServletRequest request) {
        String author = request.getParameter("author");
        // 메인 서버와 통신
        // *author* 이용
        // 참조저자, from, to 값을 검색해옴

        List<RelAuthorInfo> resultList = new ArrayList<RelAuthorInfo>(); // 메인서버에서의 검색 결과

        resultList.add(new RelAuthorInfo("tom1", "10", "1"));
        resultList.add(new RelAuthorInfo("tom0", "10", "1"));
        resultList.add(new RelAuthorInfo("tom2", "10", "1"));
        resultList.add(new RelAuthorInfo("tom1", "10", "1"));
        resultList.add(new RelAuthorInfo("tom0", "10", "1"));
        resultList.add(new RelAuthorInfo("tom1", "10", "1"));


        for (int i = 0; i < resultList.size(); i++) {
            RelAuthorInfo tmpRA = resultList.get(i);
            String tmpNickname = searchNicknameByAuthor(tmpRA.getRelAuthor());
            tmpRA.setNickname(tmpNickname);
        }

        ModelAndView modelAndView = new ModelAndView("api");
        Gson gson = new Gson();
        modelAndView.addObject("json", gson.toJson(resultList));
        return modelAndView;
    }


    //저자와 연관저자를 키로 찾은 책의 정보를 보내줌
    @RequestMapping(value = {"/main/profile/search-rel-author-content"})
    public ModelAndView searchRelAuthorContent(HttpServletRequest request) {
        String author = request.getParameter("author");
        String relAuthor = request.getParameter("rel-author");
        // 메인 서버와 통신
        // 저자와 연관저자로 검색 부분이 필요


        List<AuthorBookContent> resultList = new ArrayList<AuthorBookContent>(); //메인 서버에서의 검색 결과

        resultList.add(new AuthorBookContent("tom", "bob", "hihihihi", "20110101"));
        resultList.add(new AuthorBookContent("tom", "bob", "hihihihi", "20110101"));
        resultList.add(new AuthorBookContent("tom", "bob", "hihihihi", "20110101"));
        resultList.add(new AuthorBookContent("tom", "bob", "hihihihi", "20110101"));
        resultList.add(new AuthorBookContent("tom", "bob", "hihihihi", "20110101"));
        resultList.add(new AuthorBookContent("tom", "bob", "hihihihi", "20110101"));
        resultList.add(new AuthorBookContent("tom", "bob", "hihihihi", "20110101"));

        ModelAndView modelAndView = new ModelAndView("api");
        Gson gson = new Gson();
        modelAndView.addObject("json", gson.toJson(resultList));
        return modelAndView;
    }


    @RequestMapping(value = {"/main/statistics"})
    public String statisticsPage() {
        return "main_statistics";
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
        String searchPeriod = request.getParameter("searchPeriod");

        ArrayList<String> authorList = new ArrayList<String>();
        authorList.add("total");

        ArrayList<LinkedHashMap<String, String>> resultList = getGraphDataByAuthorsAndPeriod(authorList, searchPeriod);

        ModelAndView modelAndView = new ModelAndView("api");
        Gson gson = new Gson();
        modelAndView.addObject("json", gson.toJson(resultList));
        return modelAndView;
    }

    @RequestMapping(value = {"/main/statistics/search-author-total-data"})
    public ModelAndView getStatisticsAuthorTotal(HttpServletRequest request) {
        String searchPeriod = request.getParameter("searchPeriod");

        ArrayList<String> authorList = new ArrayList<String>();
        authorList.add("total");

        ArrayList<LinkedHashMap<String, String>> resultList = getGraphDataByAuthorsAndPeriod(authorList, searchPeriod);

        ModelAndView modelAndView = new ModelAndView("api");
        Gson gson = new Gson();
        modelAndView.addObject("json", gson.toJson(resultList));
        return modelAndView;
    }

    @RequestMapping(value = {"/main/statistics/search-author-data"})
    public ModelAndView getStatisticsAuthor(HttpServletRequest request) {
        String authorJson = request.getParameter("author");
        Gson gson = new Gson();
        ArrayList<String> authorList = (ArrayList<String>) gson.fromJson(authorJson, ArrayList.class);
        String searchPeriod = request.getParameter("searchPeriod");

        System.out.println(searchPeriod);

        ArrayList<LinkedHashMap<String, String>> resultList = getGraphDataByAuthorsAndPeriod(authorList, searchPeriod);

        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", gson.toJson(resultList));
        return modelAndView;
    }

    @RequestMapping(value = {"/main/search"})
    public ModelAndView searchPage(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("main_search");
        modelAndView.addObject("colSize", tableOptionRepository.findByUserAccount_UserId(sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId()).get(0).getColSizes());
        return modelAndView;
    }

    @RequestMapping(value = {"/main/search1"})
    public String searchPage1() {
        return "main_search_1";
    }

    @RequestMapping(value = {"/main/status"})
    public String statusPage() {
        return "main_system_status";
    }


    @RequestMapping(value = "/join", method = RequestMethod.POST)
    public String userJoin(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        try {
            UserAccount userAccount = new UserAccount(userId, username, password, phone);
            userAccountRepository.save(userAccount);
            tableOptionRepository.save(new UserTableOption(userAccount, new int[]{50, 50, 50, 100, 100, 100, 100, 50, 50, 600, 50, 50}));
        } catch (Exception e) {
            return "redirect:" + "/error";
        }
        return "redirect:" + "/";
    }

    @RequestMapping(value = "/register")
    public String registerPage(HttpServletRequest request) {
        return "user_join";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String userLogin(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        List<UserAccount> userAccountList = userAccountRepository.findByUserId(userId);

//        System.out.println(EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + userId + password + EncryptUtil.SECOND_KEY));
        if (userAccountList.size() > 0 && userAccountList.get(0).getUserId().equals(userId) && userAccountList.get(0).getHash().equals(EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + userId + password + EncryptUtil.SECOND_KEY))) {
            request.getSession().setAttribute("userId", userId);
            sessionRepository.save(new Session(request.getSession().getId(), userId, UserType.USER));
            return "redirect:" + "/main";
        }
        return "redirect:" + "/";
    }

    @RequestMapping(value = "/logout")
    public String userLogout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:" + "/";
    }

    @RequestMapping(value = "/main/searching")
    public ModelAndView searchItems(HttpServletRequest request) {
        Gson gson = new Gson();
        Object o = request.getParameter("data");
//        System.out.println(request.getParameter("data"));
        ObjectMapper om = new ObjectMapper();
        try {
            Map myMap = om.readValue(request.getParameter("data"), new TypeReference<Map<String, Object>>() {
            });
//            System.out.println(myMap.get("typeInfo"));
//            System.out.println(((Map) ((ArrayList) myMap.get("data")).get(0)).get("category"));

        } catch (Exception e) {

        }

        BasicCom bc = new BasicCom(0, 0);
        bc.start();
        try {
            bc.join();
        } catch (Exception e) {
            e.printStackTrace();
        }
        int progress = 75;
        ModelAndView modelAndView = new ModelAndView("api");

        for (BookInfo bookInfo : bookInfoList) {
            List<NicknameOption> nicknames = nicknameRepository.findByAuthor(bookInfo.getAuthor());
            //find in nickname table and if nickname exist, add to BookInfo
            if (nicknames.size() > 0) {
                bookInfo.setNickname(nicknames.get(0).getNickname());
            }
        }
        modelAndView.addObject("json", gson.toJson(bookInfoList));

        String sessionId = request.getSession().getId();
        String userId;
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            String word = request.getParameter("data");
            if (userHistoryRepository.findByUserAccount_UserIdAndWord(userId, word).size() <= 0) {
                UserHistory userHistory = new UserHistory(userAccountRepository.findByUserId(userId).get(0),
                        request.getParameter("data"), new java.util.Date().getTime());
                userHistoryRepository.save(userHistory);
            }
        }

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

        BasicCom bc = new BasicCom(0, 0);
        bc.start();
        try {
            bc.join();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", gson.toJson(keySet));

        return modelAndView;
    }

    @RequestMapping(value = "/main/r-check")
    public ModelAndView readCheck(HttpServletRequest request) {
        String bookId = request.getParameter("bookId");
        String userId = sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId();
        try {

            if (bookHistoryRepository.findByUserAccount_UserIdAndBookId(userId, bookId).size() <= 0) {
                bookHistoryRepository.save(new BookHistory(userAccountRepository.findByUserId(userId).get(0), bookId, 5, true, false));
            } else {
                BookHistory bookHistory = bookHistoryRepository.findByUserAccount_UserIdAndBookId(userId, bookId).get(0);
                bookHistory.setR(true);
                bookHistoryRepository.save(bookHistory);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", true);
        return modelAndView;
    }

    @RequestMapping(value = "/main/e-check")
    public ModelAndView priorityGet(HttpServletRequest request) {
        String bookId = request.getParameter("bookId");
        String userId = sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId();
        if (bookHistoryRepository.findByUserAccount_UserIdAndBookId(userId, bookId).size() <= 0) {
            bookHistoryRepository.save(new BookHistory(userAccountRepository.findByUserId(userId).get(0), bookId, 5, false, true));
        } else {
            BookHistory bookHistory = bookHistoryRepository.findByUserAccount_UserIdAndBookId(userId, bookId).get(0);
            bookHistory.setE(true);
            bookHistoryRepository.save(bookHistory);
        }

        ModelAndView modelAndView = new ModelAndView("api");
        modelAndView.addObject("json", true);
        return modelAndView;
    }

    @RequestMapping(value = "/main/user-history/delete")
    public ModelAndView userHistoryUpdate(HttpServletRequest request) {
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
        List<UserHistoryApi> userHistoryApis = new ArrayList<UserHistoryApi>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            userHistories = userHistoryRepository.findByUserAccount_UserId(userId);

            if (userHistories != null) {
                for (UserHistory uHistory : userHistories) {
                    userHistoryApis.add(new UserHistoryApi(uHistory));
                }
            }
        }
        modelAndView.addObject("json", gson.toJson(userHistoryApis));
//        modelAndView.addObject("json", gson.toJson(rtnArray));
        return modelAndView;
    }

    @RequestMapping(value = "/main/user-history/get")
    public ModelAndView userHistoryGet(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId;
        List<UserHistory> userHistories;
        Gson gson = new Gson();
        List<UserHistoryApi> userHistoryApis = new ArrayList<UserHistoryApi>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            userHistories = userHistoryRepository.findByUserAccount_UserId(userId);

            if (userHistories != null) {
                for (UserHistory uHistory : userHistories) {
                    userHistoryApis.add(new UserHistoryApi(uHistory));
                }
            }
        }
        ModelAndView modelAndView = new ModelAndView("api");
//        modelAndView.addObject("json", gson.toJson(rtnArray));
        modelAndView.addObject("json", gson.toJson(userHistoryApis));


        return modelAndView;
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

        String word = request.getParameter("data");
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            List<UserHistory> userHistories = userHistoryRepository.findByUserAccount_UserIdAndWord(userId, word);
            if (userHistories.size() > 0) {
                UserHistory userHistory = userHistories.get(0);
                UserBookmark tmpBookmark = userBookmarkRepository.save(new UserBookmark(userHistory));
                userHistory.setUserBookmark(tmpBookmark);
                userHistoryRepository.save(userHistory);
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
        List<UserHistoryApi> userHistoryApis = new ArrayList<UserHistoryApi>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            userBookmarks = userBookmarkRepository.findByUserAccount_UserId(userId);

            if (userBookmarks != null) {
                for (UserBookmark bookmark : userBookmarks) {
                    userHistoryApis.add(new UserHistoryApi(bookmark));
                }
            }
        }
        ModelAndView modelAndView = new ModelAndView("api");
//        modelAndView.addObject("json", gson.toJson(rtnArray));
        modelAndView.addObject("json", gson.toJson(userHistoryApis));

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

    @RequestMapping(value = "/error")
    public String errorPage() {
        return "error";
    }

    @RequestMapping(value = "/test")
    public String testPage() {
        return "test";
    }

    class BasicCom extends Thread {
        //private int ddl = 0;
        private int ddl = 0;
        private int page = 0;

        private boolean stop = false;
        private SocketComm soComm = null;

        public BasicCom(int ddl, int page) {
            this.ddl = ddl;
            this.page = page;
        }

        public void setStop() {
            stop = true;
        }

        public void exeThread(int sel) {
            if (stop) return;
            int count = 0;

            soComm = new SocketComm(sel); // query or stop 전송
            soComm.start();
        }

        public void exeThread(int sel, int p) {
            System.out.println("\texeThread :222 " + sel);
            if (stop) return;
            int count = 0;

            soComm = new SocketComm(sel, p);
            soComm.start();
            while (true) {
                try {
                    Thread.sleep(50);
                } catch (InterruptedException e) {
                }
                if (!soComm.isAlive()) {
                    if (stop || soComm.beGetGood()) break;
                    else {
                        System.out.println("\tRe Call : " + count);
                        soComm = new SocketComm(sel, p);
                        soComm.start();
                    }
                } else count++;

                if (count > 1000) {
                    stop = true;
                    System.out.println("\tddl : " + sel + "   > Error : Call Count Over!");
                    break;
                }
            }

            if (!stop) {
                if (sel == 2) {        // 페이지 가져오기
                    String[][] r = soComm.getR();
                    System.out.println();
                    System.out.println("번호  우선순위  그룹\t발행일자\t\t저장일자\t저자\t참조저자\tR   E\t\t\t\t내용\t\t\t\t비고1\t비고2");
                    bookInfoList.clear();
                    for (int i = 0; i < r.length; i++) {
                        bookInfoList.add(new BookInfo(r[i]));
                        System.out.println(r[i]);
                    }
                } else if (sel == 3)    // 연관문자 가져오기
                {
//                    ArrayList<String> keySet = soComm.getKetSet();

                    keySet = soComm.getKetSet();

                    System.out.println("\t연관 문자 Get!!");
                    for (int i = 0; i < keySet.size(); i++) {
                        System.out.println(i + "\t" + keySet.get(i));
                    }
                } else if (sel == 4)    // 검색 count 가져오기
                {
                    int cnt = soComm.getViewCount();
                    System.out.println("count : " + cnt);
                }
            }
            System.out.println();
            System.out.println("\texeThread END:222 " + sel);
        }

        public void run() {
            BufferedReader inMonitor = new BufferedReader(new InputStreamReader(System.in));
            long time = System.currentTimeMillis();

            if (ddl == 0)            // 검색
            {
                System.out.println("QUERY");
                exeThread(0);            // query 전송
                exeThread(3, 0);        // 연관문자 가져오기
                exeThread(4, 0);        // 검색 count 가져오기
                exeThread(2, 0);        // 0 페이지 가져오기
            }
            if (ddl == 1)            // 재검색
            {
                System.out.println("QUERY2");
                exeThread(0);            // query 전송
                exeThread(4, 0);        // 검색 count 가져오기
                exeThread(2, 0);        // 0 페이지 가져오기
            } else if (ddl == 2) {        // 특정 page 페이지 가져오기
                System.out.println("VIEW");
                exeThread(2, page);
            } else if (ddl == 3) {        // 연관문자 가져오기
                System.out.println("KEYS");
                exeThread(3, 0);
            } else if (ddl == 5) {
                System.out.println("STOP");
                exeThread(5);        // stop
            }

            //if(stop){ exeThread(5); }	// stop 전송

            System.out.println("\t소요시간  :: " + (System.currentTimeMillis() - time));
        }
    }

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


    private ArrayList<LinkedHashMap<String, String>> getGraphDataByAuthorsAndPeriod(ArrayList<String> authorList, String searchPeriod) {
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
    }

    final class SEARCH_PERIOD {
        final static int daily = 0, weekly = 1, monthly = 2, yearly = 3;
    }
}

