package com.blainechai.controller;

import com.blainechai.constant.Type;
import com.blainechai.domain.AdminAccount;
import com.blainechai.domain.Session;
import com.blainechai.domain.UserAccount;
import com.blainechai.repository.SessionRepository;
import com.blainechai.repository.UserAccountRepository;
import com.blainechai.util.EncryptUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

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
//
//    @Autowired
//    private ContractRepository contractRepository;
//
//    @Autowired
//    private RecycleItemRepository recycleItemRepository;
//
//    @Autowired
//    private ErrandCategoryRepository errandCategoryRepository;
//
//    @Autowired
//    private ErrandItemRepository errandItemRepository;

//    @RequestMapping(value = {""})
//    public String adminLogin(ModelMap model, HttpServletRequest request) {
////        System.out.println(sessionRepository.findByJSessionId(request.getSession().getId()).size());
//        if (sessionRepository.findByJSessionId(request.getSession().getId()).size() > 0) {
//            return "redirect:" + "/admin/main";
//        }
//        model.addAttribute("adminAccountSize", userAccountRepository.findAll().size());
//        return "admin_login";
//    }

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
    public String searchPage() {
        return "main_search";
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
            userAccountRepository.save(new UserAccount(userId, username, password, phone));
        } catch (Exception e) {
            return "redirect:" + "/error";
        }
//            saveDefaultValue();
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

        System.out.println(EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + userId + password + EncryptUtil.SECOND_KEY));
        if (userAccountList.size() > 0 && userAccountList.get(0).getUserId().equals(userId) && userAccountList.get(0).getHash().equals(EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + userId + password + EncryptUtil.SECOND_KEY))) {
            request.getSession().setAttribute("userId", userId);
            sessionRepository.save(new Session(request.getSession().getId(), userId, Type.USER));
            return "redirect:" + "/main";
        }
//                for (int i = 0; i < userAccountList.size(); i++) {
//            UserAccount userAccount = userAccountList.get(i);
//            if (userAccount.getUserId().equals(userId) && userAccount.getHash().equals(EncryptUtil.getSHA256(password))) {
//                request.getSession().setAttribute("userId", userId);
//                sessionRepository.save(new Session(request.getSession().getId(), userId, Type.USER));
//                return "redirect:" + "/main";
//            }
        return "redirect:" + "/";
    }

    @RequestMapping(value = "/logout")
    public String userLogout(HttpServletRequest request) {
//        sessionRepository.deleteByJSessionId(request.getSession().getId());
        request.getSession().invalidate();
        return "redirect:" + "/";
    }

//
//    @RequestMapping(value = "/admin-account")
//    public ModelAndView list() {
//        List<UserAccount> userAccountList = userAccountRepository.findAll();
//        ModelAndView modelAndView = new ModelAndView("admin_administator_list");
//        modelAndView.addObject("userAccountList", userAccountList);
//        return modelAndView;
//    }
//
//    @RequestMapping(value = "/admin-account/modify", method = RequestMethod.POST)
//    public ModelAndView modify(HttpServletRequest request) {
//        System.out.println(request.getParameter("userId"));
//        ModelAndView modelAndView = new ModelAndView("admin_administator_modify");
//        try {
//            modelAndView.addObject("adminInfo", userAccountRepository.findByUserId(request.getParameter("userId")).get(0));
//        } catch (ArrayIndexOutOfBoundsException e) {
//            modelAndView = new ModelAndView("redirect:" + "/admin/admin-account");
//        }
//        return modelAndView;
//    }
//
//    @RequestMapping(value = "/admin-account/delete", method = RequestMethod.POST)
//    public ModelAndView delete(HttpServletRequest request) {
//        userAccountRepository.deleteByUserId(request.getParameter("userId"));
//        ModelAndView modelAndView = new ModelAndView("admin_administator_list");
//        List<UserAccount> userAccountList = userAccountRepository.findAll();
//        modelAndView.addObject("userAccountList", userAccountList);
//        return modelAndView;
//    }
//
//
//    @RequestMapping(value = "/admin-account/search")
//    public ModelAndView search(HttpServletRequest request) {
//        List<UserAccount> userAccountList = userAccountRepository.findByUserId(request.getParameter("userId"));
//        ModelAndView modelAndView = new ModelAndView("admin_administator_list");
//        modelAndView.addObject("userAccountList", userAccountList);
//        return modelAndView;
//    }
//
//    @RequestMapping(value = "/admin-account/update", method = RequestMethod.POST)
//    public String updateUser(HttpServletRequest request) {
//        String userId = request.getParameter("userId");
//        String username = request.getParameter("username");
//        UserAccount userAccount = userAccountRepository.findByUserId(userId).get(0);
//        userAccount.setUserId(userId);
//        userAccount.setUsername(username);
//        userAccountRepository.save(userAccount);
//        return "redirect:" + "/admin/admin-account"; // 중복된 번호라고 언급해야함.
//    }

    @RequestMapping(value = "/error")
    public String errorPage(){
        return "error";
    }

}
