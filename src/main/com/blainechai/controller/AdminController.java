package com.blainechai.controller;

import com.blainechai.constant.Constant;
import com.blainechai.constant.Type;
import com.blainechai.domain.Session;
import com.blainechai.domain.UserAccount;
import com.blainechai.repository.AdminAccountRepository;
import com.blainechai.domain.AdminAccount;
import com.blainechai.repository.SessionRepository;
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
        if (request.getSession().getAttribute("JSESSIONID") != null)
            return "redirect:" + "/admin/main";
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
                sessionRepository.save(new Session(request.getSession().getId(), userId, Type.ADMIN));
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
        ModelAndView modelAndView = new ModelAndView("admin_administator_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/modify", method = RequestMethod.POST)
    public ModelAndView modify() {
        List<AdminAccount> adminList = adminAccountRepository.findAll();
        ModelAndView modelAndView = new ModelAndView("admin_administator_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/delete", method = RequestMethod.POST)
    public ModelAndView delete(HttpServletRequest request) {
        adminAccountRepository.deleteByUserId(request.getAttribute("userId").toString());
        ModelAndView modelAndView = new ModelAndView("admin_administator_list");
        List<AdminAccount> adminList = adminAccountRepository.findAll();
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }


    @RequestMapping(value = "/admin-account/search")
    public ModelAndView search(HttpServletRequest request) {
        List<AdminAccount> adminList = adminAccountRepository.findByUserId(request.getAttribute("userId").toString());
        ModelAndView modelAndView = new ModelAndView("admin_administator_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }
}
