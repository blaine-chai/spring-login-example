package com.blainechai.controller;

import com.blainechai.repository.AdminAccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminAccountRepository adminAccountRepository;
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
        if (request.getSession().getAttribute("username") != null)
            return "redirect:" + "/admin/main";
//        model.addAttribute("adminAccountSize", adminAccountRepository.findAll().size());
        return "admin_login";
    }

    @RequestMapping(value = "/join")
    public String adminJoin(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
//        if (adminAccountRepository.findAll().size() <= 0) {
//            adminAccountRepository.save(new AdminAccount(username, password));
//            saveDefaultValue();
//        }
        return "redirect:" + "/admin";
    }

    @RequestMapping(value = "/login")
    public String adminLogin(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
//        List<AdminAccount> adminAccountList = adminAccountRepository.findAll();
//        for (int i = 0; i < adminAccountList.size(); i++) {
//            AdminAccount adminAccount = adminAccountList.get(i);
//            if (adminAccount.getUsername().equals(username) && adminAccount.getPassword().equals(password)) {
                request.getSession().setAttribute("username", username);
                return "redirect:" + "/admin/main";
//            }
//        }
//        return "redirect:" + "/error";
    }

    @RequestMapping(value = "/logout")
    public String adminLogout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:" + "/admin";
    }

    @RequestMapping(value = "/main")
    public String adminMain(HttpServletRequest request, ModelMap model) {
        model.addAttribute("username", request.getSession().getAttribute("username").toString());
        return "admin_main";
    }

}
