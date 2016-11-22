package com.blainechai.controller;

import com.blainechai.constant.UserType;
import com.blainechai.domain.Session;
import com.blainechai.domain.UserAccount;
import com.blainechai.repository.AdminAccountRepository;
import com.blainechai.domain.AdminAccount;
import com.blainechai.repository.SessionRepository;
import com.blainechai.repository.UserAccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminAccountRepository adminAccountRepository;

    @Autowired
    private UserAccountRepository userAccountRepository;

    @Autowired
    private SessionRepository sessionRepository;
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

    @RequestMapping(value = {""})
    public String adminLogin(ModelMap model, HttpServletRequest request) {
//        System.out.println(sessionRepository.findByJSessionId(request.getSession().getId()).size());
        if (sessionRepository.findByJSessionId(request.getSession().getId()).size() > 0 && sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getType().equals(UserType.ADMIN)) {
            return "redirect:" + "/admin/main";
        }
        model.addAttribute("adminAccountSize", adminAccountRepository.findAll().size());
        return "admin_login";
    }

    @RequestMapping(value = "/join", method = RequestMethod.POST)
    public String adminJoin(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (adminAccountRepository.findAll().size() <= 0) {
            adminAccountRepository.save(new AdminAccount(userId, username, password));
//            saveDefaultValue();
        }
        return "redirect:" + "/admin";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String adminLogin(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        List<AdminAccount> adminAccountList = adminAccountRepository.findAll();
        for (int i = 0; i < adminAccountList.size(); i++) {
            AdminAccount adminAccount = adminAccountList.get(i);
            if (adminAccount.getUserId().equals(userId) && adminAccount.getPassword().equals(password)) {
                request.getSession().setAttribute("userId", userId);
                sessionRepository.save(new Session(request.getSession().getId(), userId, UserType.ADMIN));
                return "redirect:" + "/admin/main";
            }
        }
        return "redirect:" + "/error";
    }

    @RequestMapping(value = "/logout")
    public String adminLogout(HttpServletRequest request) {
//        sessionRepository.deleteByJSessionId(request.getSession().getId());
        request.getSession().invalidate();
        return "redirect:" + "/admin";
    }

    @RequestMapping(value = "/main")
    public String adminMain(HttpServletRequest request, ModelMap model) {
        model.addAttribute("userId", request.getSession().getAttribute("userId").toString());
        return "admin_main";
    }

    @RequestMapping(value = "/admin-account")
    public ModelAndView list() {
        List<AdminAccount> adminList = adminAccountRepository.findAll();
        ModelAndView modelAndView = new ModelAndView("admin_administrator_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/modify", method = RequestMethod.POST)
    public ModelAndView modify(HttpServletRequest request) {
        System.out.println(request.getParameter("userId"));
        ModelAndView modelAndView = new ModelAndView("admin_administrator_modify");
        try {
            modelAndView.addObject("adminInfo", adminAccountRepository.findByUserId(request.getParameter("userId")).get(0));
        } catch (ArrayIndexOutOfBoundsException e) {
            modelAndView = new ModelAndView("redirect:" + "/admin/admin-account");
        }
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/delete", method = RequestMethod.POST)
    public ModelAndView delete(HttpServletRequest request) {
        adminAccountRepository.deleteByUserId(request.getParameter("userId"));
        ModelAndView modelAndView = new ModelAndView("admin_administrator_list");
        List<AdminAccount> adminList = adminAccountRepository.findAll();
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }


    @RequestMapping(value = "/admin-account/search")
    public ModelAndView search(HttpServletRequest request) {
        List<AdminAccount> adminList = adminAccountRepository.findByUserId(request.getParameter("userId"));
        ModelAndView modelAndView = new ModelAndView("admin_administrator_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/update", method = RequestMethod.POST)
    public String updateUser(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        AdminAccount adminAccount = adminAccountRepository.findByUserId(userId).get(0);
        adminAccount.setUserId(userId);
        adminAccount.setUsername(username);
        adminAccountRepository.save(adminAccount);
        return "redirect:" + "/admin/admin-account"; // 중복된 번호라고 언급해야함.
    }

    @RequestMapping(value = "/admin-account/register")
    public String adminRegisterPage(HttpServletRequest request) {
        return "admin_administrator_join";
    }

    @RequestMapping(value = "/admin-account/join", method = RequestMethod.POST)
    public String adminAccountJoin(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        adminAccountRepository.save(new AdminAccount(userId, username, password));
        return "redirect:" + "/admin/admin-account";
    }


    @RequestMapping(value = "/user")
    public ModelAndView userList() {
        List<UserAccount> adminList = userAccountRepository.findAll();
        ModelAndView modelAndView = new ModelAndView("admin_user_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

    @RequestMapping(value = "/user/modify", method = RequestMethod.POST)
    public ModelAndView userModify(HttpServletRequest request) {
        System.out.println(request.getParameter("userId"));
        ModelAndView modelAndView = new ModelAndView("admin_user_modify");
        try {
            modelAndView.addObject("adminInfo", userAccountRepository.findByUserId(request.getParameter("userId")).get(0));
        } catch (ArrayIndexOutOfBoundsException e) {
            modelAndView = new ModelAndView("redirect:" + "/admin/user");
        }
        return modelAndView;
    }

    @RequestMapping(value = "/user/delete", method = RequestMethod.POST)
    public ModelAndView userDelete(HttpServletRequest request) {
        userAccountRepository.deleteByUserId(request.getParameter("userId"));
        ModelAndView modelAndView = new ModelAndView("admin_user_list");
        List<UserAccount> adminList = userAccountRepository.findAll();
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }


    @RequestMapping(value = "/user/search")
    public ModelAndView userSearch(HttpServletRequest request) {
        List<UserAccount> adminList = userAccountRepository.findByUserId(request.getParameter("userId"));
        ModelAndView modelAndView = new ModelAndView("admin_user_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

    @RequestMapping(value = "/user/update", method = RequestMethod.POST)
    public String userUpdate(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        UserAccount userAccount = userAccountRepository.findByUserId(userId).get(0);
        userAccount.setUserId(userId);
        userAccount.setUsername(username);
        userAccountRepository.save(userAccount);
        return "redirect:" + "/admin/user";
    }

    @RequestMapping(value = "/user/register")
    public String registerPage(HttpServletRequest request) {
        return "admin_user_join";
    }

    @RequestMapping(value = "/user/join", method = RequestMethod.POST)
    public String userJoin(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String type = request.getParameter("type");
        try {
            userAccountRepository.save(new UserAccount(userId, username, password, phone, type));
        } catch (Exception e) {
            return "redirect:" + "/error";
        }
//            saveDefaultValue();
        return "redirect:" + "/admin/user";
    }
}
