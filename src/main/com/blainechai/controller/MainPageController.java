package com.blainechai.controller;

import com.blainechai.constant.UserType;
import com.blainechai.controller.api.SocketComm;
import com.blainechai.domain.*;
import com.blainechai.model.BookInfo;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

    public static List<BookInfo> bookInfoList = new ArrayList<BookInfo>();
    public static ArrayList<String> keySet = new ArrayList<String>();


    @RequestMapping(value = {""})
    public String login() {
        return "user_login";
    }

    @RequestMapping(value = {"/main"})
    public String mainPage() {
        return "main_alarm";
    }

    @RequestMapping(value = {"/main/profile"})
    public String profilePage() {
        return "main_profiling";
    }

    @RequestMapping(value = {"/main/statistics"})
    public String statisticsPage() {
        return "main_statistics";
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

    @RequestMapping(value = "/search")
    public ModelAndView searchItems(HttpServletRequest request) {
        Gson gson = new Gson();
        Object o = request.getParameter("data");
//        System.out.println(request.getParameter("data"));
        ObjectMapper om = new ObjectMapper();
        try {
            Map myMap = om.readValue(request.getParameter("data").toString(), new TypeReference<Map<String, Object>>() {
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
            UserHistory userHistory = new UserHistory(userAccountRepository.findByUserId(userId).get(0),
                    request.getParameter("data"), new java.util.Date().getTime());
            userHistoryRepository.save(userHistory);
        }

        return modelAndView;
    }

    @RequestMapping(value = "/relative-word")
    public ModelAndView relativeWord(HttpServletRequest request) {
        Gson gson = new Gson();
        ObjectMapper om = new ObjectMapper();
        try {
            Map myMap = om.readValue(request.getParameter("data").toString(), new TypeReference<Map<String, Object>>() {
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

    @RequestMapping(value = "/r-check")
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
        modelAndView.addObject("json", "");
        return modelAndView;
    }

    @RequestMapping(value = "/e-check")
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

        return modelAndView;
    }

    @RequestMapping(value = "/user-history/update")
    public ModelAndView userHistoryUpdate(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("api");

        return modelAndView;
    }

    @RequestMapping(value = "/user-history/get")
    public ModelAndView userHistoryGet(HttpServletRequest request) {
        String sessionId = request.getSession().getId();
        String userId;
        List<UserHistory> userHistories = new ArrayList<UserHistory>();
        Gson gson = new Gson();
        ArrayList<String> rtnArray = new ArrayList<String>();
        if (sessionRepository.findByJSessionId(sessionId).size() > 0) {
            userId = sessionRepository.findByJSessionId(sessionId).get(0).getUserId();
            userHistories = userHistoryRepository.findByUserAccount_UserId(userId);

            if (userHistories != null) {
                for (UserHistory uHistory : userHistories) {
                    ObjectMapper om = new ObjectMapper();
                    try {
                        Map myMap = om.readValue(uHistory.getWord(), new TypeReference<Map<String, Object>>() {
                        });
                        ArrayList<Map> searchOptions = (ArrayList) myMap.get("data");
                        String rtnText = "";
                        if (searchOptions.size() > 0) {
                            rtnText += searchOptions.get(0).get("input").toString();
                            if (!searchOptions.get(0).get("operator").toString().equals("SEL")) {
                                rtnText += " " + searchOptions.get(0).get("operator").toString();
                            }
                        }
                        for (int i = 1; i < searchOptions.size(); i++) {
                            rtnText += " " + searchOptions.get(i).get("input").toString();
                            if (!searchOptions.get(i).get("operator").toString().equals("SEL")) {
                                rtnText += " " + searchOptions.get(i).get("operator").toString();
                            }
                        }
                        rtnArray.add(rtnText);
                    } catch (Exception e) {
                    }
                }
            }
        }
        ModelAndView modelAndView = new ModelAndView("api");
//        modelAndView.addObject("json", gson.toJson(rtnArray));
        modelAndView.addObject("json", gson.toJson(userHistories));


        return modelAndView;
    }

    @RequestMapping(value = "/table-option/update")
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


        ModelAndView modelAndView = new ModelAndView("api");

        return modelAndView;
    }

    @RequestMapping(value = "/nickname/update")
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

    @RequestMapping(value = "/nickname/get")
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

    @RequestMapping(value = "/nickname/check")
    public ModelAndView checkNickname(HttpServletRequest request) {
        String nickname = request.getParameter("nickname");
        boolean result;
        if (nicknameRepository.findByNickname(nickname).size() <= 0) {
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
}

