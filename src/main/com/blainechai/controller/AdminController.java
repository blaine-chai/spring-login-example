package com.blainechai.controller;

import com.blainechai.constant.UserType;
import com.blainechai.domain.*;
import com.blainechai.model.UserAccountApi;
import com.blainechai.repository.*;
import com.blainechai.util.EncryptUtil;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserAccountRepository userAccountRepository;

    @Autowired
    private SessionRepository sessionRepository;

    @Autowired
    private UserTableOptionRepository tableOptionRepository;

    @Autowired
    private AdminBookmarkRepository adminBookmarkRepository;

    @Autowired
    private CommonBookmarkRepository commonBookmarkRepository;

    @Autowired
    private CommonGroupNameRepository groupNameRepository;

    @Autowired
    private UserGroupRepository userGroupRepository;

    @RequestMapping(value = {""})
    public String adminLogin(ModelMap model, HttpServletRequest request) {
//        System.out.println(sessionRepository.findByJSessionId(request.getSession().getId()).size());
        if (sessionRepository.findByJSessionId(request.getSession().getId()).size() > 0) {
            if (UserType.isAdminUser(sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getType())) {
                return "redirect:" + "/admin/main";
            }
        }
        model.addAttribute("adminAccountSize", userAccountRepository.findByType(UserType.ADMIN).size());
        return "admin_login";
    }

    @RequestMapping(value = "/join", method = RequestMethod.POST)
    public String adminJoin(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
//        String phone = request.getParameter("p")
        try {
            UserAccount adminAccount = new UserAccount(userId, username, password, "0", UserType.ADMIN);
            adminAccount = userAccountRepository.save(adminAccount);
            tableOptionRepository.save(new UserTableOption(adminAccount, new int[]{50, 50, 50, 100, 100, 100, 100, 50, 50, 600, 50, 50}));
            List<AdminBookmark> adminBookmarks = adminBookmarkRepository.findAll();
            for (AdminBookmark adminBookmark : adminBookmarks) {
                commonBookmarkRepository.save(new CommonBookmark(adminAccount, adminBookmark, 0));
            }
//        }
        } catch (Exception e) {
            return "redirect:" + "/error";
        }
        return "redirect:" + "/admin";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String adminLogin(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        List<UserAccount> adminAccountList = userAccountRepository.findByType(UserType.ADMIN);
        for (int i = 0; i < adminAccountList.size(); i++) {
            UserAccount adminAccount = adminAccountList.get(i);
            if (adminAccountList.size() > 0 && adminAccountList.get(0).getUserId().equals(userId) && adminAccountList.get(0).getHash().equals(EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + userId + password + EncryptUtil.SECOND_KEY))) {
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
        List<UserAccount> adminList = userAccountRepository.findByType(UserType.ADMIN);
        ModelAndView modelAndView = new ModelAndView("admin_administrator_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/modify", method = RequestMethod.POST)
    public ModelAndView modify(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("admin_administrator_modify");
        try {
            modelAndView.addObject("adminInfo", userAccountRepository.findByUserId(request.getParameter("userId")).get(0));
        } catch (ArrayIndexOutOfBoundsException e) {
            modelAndView = new ModelAndView("redirect:" + "/admin/admin-account");
        }
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/delete", method = RequestMethod.POST)
    public ModelAndView delete(HttpServletRequest request) {
        userAccountRepository.deleteByUserId(request.getParameter("userId"));
        ModelAndView modelAndView = new ModelAndView("admin_administrator_list");
        List<UserAccount> adminList = userAccountRepository.findByType(UserType.ADMIN);
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }


    @RequestMapping(value = "/admin-account/search")
    public ModelAndView search(HttpServletRequest request) {
        List<UserAccount> adminList = userAccountRepository.findByUserId(request.getParameter("userId"));
        ModelAndView modelAndView = new ModelAndView("admin_administrator_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/update", method = RequestMethod.POST)
    public String updateUser(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        UserAccount adminAccount = userAccountRepository.findByUserId(userId).get(0);
        adminAccount.setUserId(userId);
        adminAccount.setUsername(username);
        userAccountRepository.save(adminAccount);
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
        if (userAccountRepository.findByUserId(userId).size() <= 0) {
            UserAccount userAccount = new UserAccount(userId, username, password, "0", UserType.ADMIN);
            userAccount = userAccountRepository.save(userAccount);
            tableOptionRepository.save(new UserTableOption(userAccount, new int[]{50, 50, 50, 100, 100, 100, 100, 50, 50, 600, 50, 50}));
            List<AdminBookmark> adminBookmarks = adminBookmarkRepository.findAll();
            for (AdminBookmark adminBookmark : adminBookmarks) {
                commonBookmarkRepository.save(new CommonBookmark(userAccount, adminBookmark, 0));
            }
        } else {
            return "redirect:" + "/error";
        }
        return "redirect:" + "/admin/admin-account";
    }


    @RequestMapping(value = "/user")
    public ModelAndView userList() {
        List<UserAccount> adminList = userAccountRepository.findAll();
        List<UserAccountApi> userAccountApis = new ArrayList<UserAccountApi>();
        for (UserAccount userAccount : adminList) {
            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
            UserAccountApi userAccountApi = new UserAccountApi(userAccount, userGroups);
            userAccountApis.add(userAccountApi);
        }
        ModelAndView modelAndView = new ModelAndView("admin_user_list");
        modelAndView.addObject("adminList", userAccountApis);
        return modelAndView;
    }

    @RequestMapping(value = "/user/modify", method = RequestMethod.POST)
    public ModelAndView userModify(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("admin_user_modify");
        try {
            UserAccount userAccount = userAccountRepository.findByUserId(request.getParameter("userId")).get(0);
            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
            UserAccountApi userAccountApi = new UserAccountApi(userAccount, userGroups);
            List<CommonGroupName> groupNames = groupNameRepository.findAll();
            modelAndView.addObject("adminInfo", userAccountApi);
            modelAndView.addObject("groupNames", groupNames);
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
        Gson gson = new Gson();
        List<String> groupNames = gson.fromJson(request.getParameter("groupNames"), ArrayList.class);
        List<String> uncheckedGroupNames = gson.fromJson(request.getParameter("uncheckedGroupNames"), ArrayList.class);
        try {
            String userId = request.getParameter("userId");
            String username = request.getParameter("username");
            UserAccount userAccount = userAccountRepository.findByUserId(userId).get(0);
            userAccount.setUserId(userId);
            userAccount.setUsername(username);
            userAccount = userAccountRepository.save(userAccount);
            for (String groupNameStr : groupNames) {
                if (userGroupRepository.findByUserAccount_UserIdAndGroupName_GroupName(userId, groupNameStr).size() <= 0) {
                    CommonGroupName commonGroupName = groupNameRepository.findByGroupName(groupNameStr).get(0);
                    userGroupRepository.save(new UserGroup(commonGroupName, userAccount));
                }
            }
            for (String groupNameStr : uncheckedGroupNames) {
                userGroupRepository.deleteByUserAccount_UserIdAndGroupName_GroupName(userId, groupNameStr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
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
        if (userAccountRepository.findByUserId(userId).size() <= 0) {
            UserAccount userAccount = new UserAccount(userId, username, password, phone, UserType.USER);
            userAccount = userAccountRepository.save(userAccount);
            tableOptionRepository.save(new UserTableOption(userAccount, new int[]{50, 50, 50, 100, 100, 100, 100, 50, 50, 600, 50, 50}));
            List<AdminBookmark> adminBookmarks = adminBookmarkRepository.findAll();
            for (AdminBookmark adminBookmark : adminBookmarks) {
                commonBookmarkRepository.save(new CommonBookmark(userAccount, adminBookmark, 0));
            }
        } else {
            return "redirect:" + "/error";
        }
        return "redirect:" + "/admin/user";
    }


    @RequestMapping(value = "/group-name")
    public ModelAndView groupName(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("admin_group_name_list");

        modelAndView.addObject("groupList", groupNameRepository.findAll());
        return modelAndView;
    }

//    @RequestMapping(value = "/group/register")
//    public ModelAndView groupRegister(HttpServletRequest request){
//        ModelAndView modelAndView = new ModelAndView("admin_group_");
//    }


    @RequestMapping(value = "/group-name/modify")
    public ModelAndView groupNameModify(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("admin_group_name_modify");
        try {
            modelAndView.addObject("groupInfo", groupNameRepository.findByGroupName(request.getParameter("groupName")).get(0));
        } catch (ArrayIndexOutOfBoundsException e) {
            modelAndView = new ModelAndView("redirect:" + "/admin/group-name");
        }
        return modelAndView;

    }

    @RequestMapping(value = "/group-name/update")
    public String groupNameUpdate(HttpServletRequest request) {
        String groupName = request.getParameter("groupName");
        CommonGroupName commonGroupName = groupNameRepository.findByGroupName(groupName).get(0);
        commonGroupName.setGroupName(groupName);
        groupNameRepository.save(commonGroupName);
        return "redirect:" + "/admin/group-name";

    }

    @RequestMapping(value = "/group-name/add")
    public ModelAndView groupNameAdd(HttpServletRequest request) {
        groupNameRepository.save(new CommonGroupName(request.getParameter("groupName")));
        ModelAndView modelAndView = new ModelAndView("admin_group_name_list");
        modelAndView.addObject("groupList", groupNameRepository.findAll());
        return modelAndView;
    }


    @RequestMapping(value = "/group-name/delete", method = RequestMethod.POST)
    public ModelAndView groupNameDelete(HttpServletRequest request) {
        groupNameRepository.deleteByGroupName(request.getParameter("groupName"));
        ModelAndView modelAndView = new ModelAndView("admin_group_name_list");
        List<CommonGroupName> groupNames = groupNameRepository.findAll();
        modelAndView.addObject("groupList", groupNames);
        return modelAndView;
    }

    @RequestMapping(value = "/group-name/register")
    public String groupNameRegister(HttpServletRequest request) {
        return "admin_group_name_register";

    }
}
