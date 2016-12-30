package com.blainechai.controller;

import com.blainechai.constant.Constant;
import com.blainechai.constant.UserType;
import com.blainechai.controller.api.SocketComm;
import com.blainechai.domain.*;
import com.blainechai.model.BookInfo;
import com.blainechai.model.GroupApi;
import com.blainechai.model.UserAccountApi;
import com.blainechai.model.UserGroupApi;
import com.blainechai.repository.*;
import com.blainechai.util.EncryptUtil;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import static com.blainechai.util.LoggerUtil.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

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

//    @Autowired
//    private CommonGroupMapRepository groupMapRepository;

    @Autowired
    private UserGroupRepository userGroupRepository;

    @RequestMapping(value = {""})
    public ModelAndView adminLoginPage(HttpServletRequest request) {
        Map<String, ?> fm = RequestContextUtils.getInputFlashMap(request);
        if (sessionRepository.findByJSessionId(request.getSession().getId()).size() > 0) {
            if (UserType.isAdminUser(sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getType())) {
                return new ModelAndView("redirect:" + "/admin/main");
            }
        }
        if (fm != null) {
            String message = (String) fm.get("loginFail");
            return new ModelAndView("admin_login").addObject("loginFail", message);
        } else {
            return new ModelAndView("admin_login")
                    .addObject("adminAccountSize", userAccountRepository.findByType(UserType.ADMIN).size())
                    .addObject("loginFail", "false");

        }
    }

    @RequestMapping(value = "/join", method = RequestMethod.POST)
    public String adminJoin(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        log("Admin Id 최초 생성 - ID : " + userId);

        if (userAccountRepository.findByType(UserType.ADMIN).size() <= 0) {
            try {
                UserAccount adminAccount = new UserAccount(userId, username, password, "0", UserType.ADMIN);
                adminAccount = userAccountRepository.save(adminAccount);
                tableOptionRepository.save(new UserTableOption(adminAccount, new int[]{50, 50, 50, 100, 100, 100, 100, 50, 50, 600, 50, 50}));
                List<AdminBookmark> adminBookmarks = adminBookmarkRepository.findAll();
                for (AdminBookmark adminBookmark : adminBookmarks) {
                    commonBookmarkRepository.save(new CommonBookmark(adminAccount, adminBookmark, 0));
                }
            } catch (Exception e) {
                return "redirect:" + "/error";
            }
        }
        return "redirect:" + "/admin";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String adminLogin(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        List<UserAccount> adminAccountList = userAccountRepository.findByUserIdAndType(userId, UserType.ADMIN);
        if (adminAccountList.size() > 0 && adminAccountList.get(0).getUserId().equals(userId) && adminAccountList.get(0).getHash().equals(EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + userId + password + EncryptUtil.SECOND_KEY))) {
            request.getSession().setAttribute("userId", userId);
            sessionRepository.save(new Session(request.getSession().getId(), userId, UserType.ADMIN));
            log(userId, "로그인");
            return "redirect:" + "/admin/admin-account";
        }
//        }
        redirectAttributes.addFlashAttribute("loginFail", "true");

        return "redirect:" + "/admin";
    }

    @RequestMapping(value = "/logout")
    public String adminLogout(HttpServletRequest request) {
//        sessionRepository.deleteByJSessionId(request.getSession().getId());
        request.getSession().invalidate();
        return "redirect:" + "/admin";
    }

    @RequestMapping(value = "/main")
    public String adminMain(HttpServletRequest request, ModelMap model) {
//        model.addAttribute("userId", request.getSession().getAttribute("userId").toString());
        return "redirect:" + "/admin/admin-account";
    }

    @RequestMapping(value = "/admin-account")
    public ModelAndView list() {
        List<UserAccount> adminList = userAccountRepository.findByType(UserType.ADMIN);
        ModelAndView modelAndView = new ModelAndView("admin_administrator_list");
//        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/get")
    public ModelAndView adminAccountGet(HttpServletRequest request) {
        Gson gson = new Gson();
        String searchFilter = request.getParameter("searchFilter");
        String searchInput = request.getParameter("searchInput");
        ModelAndView modelAndView = new ModelAndView("api");
        List<UserAccount> adminList;
        List<UserAccountApi> adminAccountApis;
        if (searchFilter == null || searchInput == null) {
            adminList = userAccountRepository.findByType(UserType.ADMIN);
            adminAccountApis = getAdminAccountApis(adminList);
            modelAndView.addObject("json", gson.toJson(adminAccountApis));
            return modelAndView;
        }

        if (searchFilter.equals("userId")) {
            adminList = userAccountRepository.findByUserIdContainingAndType(searchInput, UserType.ADMIN);
            adminAccountApis = getAdminAccountApis(adminList);
        } else if (searchFilter.equals("username")) {
            adminList = userAccountRepository.findByUsernameContainingAndType(searchInput, UserType.ADMIN);
            adminAccountApis = getAdminAccountApis(adminList);
        } else {
            adminAccountApis = new ArrayList<UserAccountApi>();
        }
        modelAndView.addObject("json", gson.toJson(adminAccountApis));
        return modelAndView;
    }

    @RequestMapping(value = "/admin-account/delete", method = RequestMethod.POST)
    public ModelAndView adminAccountDelete(HttpServletRequest request) {
        String userId = request.getParameter("userId");
//        System.out.println(userId);
        String selfId = sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId();
        if (selfId.equals(userId)) {
            return new ModelAndView("api").addObject("json", "self");
        } else if (userAccountRepository.findByType(UserType.ADMIN).size() > 1) {
            log(selfId, "관리자 계정 삭제 - ID: " + userId);
            commonBookmarkRepository.deleteByUserAccount_UserId(userId);
            commonBookmarkRepository.deleteByAdminBookmark_AdminAccount_UserId(userId);
            adminBookmarkRepository.deleteByAdminAccount_UserId(userId);
            adminHistoryRepository.deleteByAdminAccount_userId(userId);
            sessionRepository.deleteByUserId(userId);
            userBookmarkRepository.deleteByUserAccount_UserId(userId);
            userGroupRepository.deleteByUserAccount_UserId(userId);
            userHistoryRepository.deleteByUserAccount_UserId(userId);
            tableOptionRepository.deleteByUserAccount_UserId(userId);
            userAccountRepository.deleteByUserId(userId);
            return new ModelAndView("api").addObject("json", true);
        } else {
            return new ModelAndView("api").addObject("json", false);
        }
    }


//    @RequestMapping(value = "/admin-account/search")
//    public ModelAndView adminAccountSearch(HttpServletRequest request) {
//        String searchFilter = request.getParameter("searchFilter");
//        String searchInput = request.getParameter("searchInput");
//        List<UserAccount> adminList = null;
//        if (searchFilter.equals("userId")) {
//            adminList = userAccountRepository.findByUserIdAndType(searchInput, UserType.ADMIN);
//        } else if (searchFilter.equals("username")) {
//            adminList = userAccountRepository.findByUsernameAndType(searchInput, UserType.ADMIN);
//        } else {
//            adminList = new ArrayList<UserAccount>();
//        }
//        ModelAndView modelAndView = new ModelAndView("admin_administrator_list");
//        modelAndView.addObject("adminList", adminList);
//        return modelAndView;
//    }

    @RequestMapping(value = "/admin-account/update", method = RequestMethod.POST)
    public ModelAndView updateAdminUser(HttpServletRequest request) {
        // admin_bookmark -> adminId
        // admin_history -> adminId
        // common_bookmark -> userId
        // common_session -> userId
        // user_bookmark -> userId
        // user_group -> userId
        // user_search_history -> userId
        // user_table_option -> user Id
//        String userIdOrg = sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId();

        Gson gson = new Gson();

        List<String> groupNames = gson.fromJson(request.getParameter("groupNames"), ArrayList.class);
        List<String> uncheckedGroupNames = gson.fromJson(request.getParameter("uncheckedGroupNames"), ArrayList.class);

        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserAccount adminAccount = userAccountRepository.findByUserId(userId).get(0);
        adminAccount.setUserId(userId);
        adminAccount.setUsername(username);
        if (!password.equals("********")) {
            adminAccount.setPassword(password);
        }

        adminAccount = userAccountRepository.save(adminAccount);

        List<AdminBookmark> bookmarks = adminBookmarkRepository.findByAdminAccount_UserId(userId);
        for (AdminBookmark bookmark : bookmarks) {
            bookmark.setAdminAccount(adminAccount);
        }
        adminBookmarkRepository.save(bookmarks);

        List<AdminHistory> adminHistories = adminHistoryRepository.findByAdminAccount_UserId(userId);
        for (AdminHistory adminHistory : adminHistories) {
            adminHistory.setAdminAccount(adminAccount);
        }
        adminHistoryRepository.save(adminHistories);

        List<CommonBookmark> commonBookmarks = commonBookmarkRepository.findByUserAccount_UserId(userId);
        for (CommonBookmark commonBookmark : commonBookmarks) {
            commonBookmark.setUserAccount(adminAccount);
        }
        commonBookmarkRepository.save(commonBookmarks);

        List<Session> sessions = sessionRepository.findByUserId(userId);
        for (Session session : sessions) {
            session.setUserId(userId);
        }
        sessionRepository.save(sessions);

        List<UserBookmark> userBookmarks = userBookmarkRepository.findByUserAccount_UserId(userId);
        for (UserBookmark userBookmark : userBookmarks) {
            userBookmark.setUserAccount(adminAccount);
        }
        userBookmarkRepository.save(userBookmarks);

        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userId);
        for (UserGroup userGroup : userGroups) {
            userGroup.setUserAccount(adminAccount);
        }
        userGroupRepository.save(userGroups);

        List<UserHistory> userHistories = userHistoryRepository.findByUserAccount_UserId(userId);
        for (UserHistory userHistory : userHistories) {
            userHistory.setUserAccount(adminAccount);
        }
        userHistoryRepository.save(userHistories);

        List<UserTableOption> userTableOptions = tableOptionRepository.findByUserAccount_UserId(userId);
        for (UserTableOption tableOption : userTableOptions) {
            tableOption.setUserAccount(adminAccount);
        }
        tableOptionRepository.save(userTableOptions);

        for (String groupNameStr : groupNames) {
            if (userGroupRepository.findByUserAccount_UserIdAndGroupName_GroupName(userId, groupNameStr).size() <= 0) {
                CommonGroupName commonGroupName = groupNameRepository.findByGroupName(groupNameStr).get(0);
                userGroupRepository.save(new UserGroup(commonGroupName, adminAccount));
            }
        }

        for (String groupNameStr : uncheckedGroupNames) {
            userGroupRepository.deleteByUserAccount_UserIdAndGroupName_GroupName(userId, groupNameStr);
        }

        return new ModelAndView("api").addObject("json", true); // 중복된 번호라고 언급해야함.
    }

    @RequestMapping(value = "/admin-account/join", method = RequestMethod.POST)
    public ModelAndView adminAccountJoin(HttpServletRequest request) {
        Gson gson = new Gson();
        List<String> groupNames = gson.fromJson(request.getParameter("groupNames"), ArrayList.class);
        List<String> uncheckedGroupNames = gson.fromJson(request.getParameter("uncheckedGroupNames"), ArrayList.class);

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

            for (String groupNameStr : groupNames) {
                if (userGroupRepository.findByUserAccount_UserIdAndGroupName_GroupName(userId, groupNameStr).size() <= 0) {
                    CommonGroupName commonGroupName = groupNameRepository.findByGroupName(groupNameStr).get(0);
                    userGroupRepository.save(new UserGroup(commonGroupName, userAccount));
                }
            }

        } else {
            return new ModelAndView("api").addObject("json", false);
        }
        return new ModelAndView("api").addObject("json", true);
    }


    @RequestMapping(value = "/user")
    public ModelAndView userList() {
        ModelAndView modelAndView = new ModelAndView("admin_user_list");
        modelAndView.addObject("adminList", getAllUserAccountApis());
        return modelAndView;
    }

    @RequestMapping(value = "/user/get")
    public ModelAndView userAccountGet(HttpServletRequest request) {
        Gson gson = new Gson();
        String searchFilter = request.getParameter("searchFilter");
        String searchInput = request.getParameter("searchInput");
        ModelAndView modelAndView = new ModelAndView("api");
        List<UserAccount> userAccounts;
        List<UserAccountApi> userAccountApis;
        if (searchFilter == null || searchInput == null) {
            userAccounts = userAccountRepository.findByType(UserType.USER);
            userAccountApis = getUserAccountApis(userAccounts);
            modelAndView.addObject("json", gson.toJson(userAccountApis));
            return modelAndView;
        }

        if (searchFilter.equals("userId")) {
            userAccounts = userAccountRepository.findByUserIdContainingAndType(searchInput, UserType.USER);
            userAccountApis = getUserAccountApis(userAccounts);
        } else if (searchFilter.equals("username")) {
            userAccounts = userAccountRepository.findByUsernameContainingAndType(searchInput, UserType.USER);
            userAccountApis = getUserAccountApis(userAccounts);
        } else {
            userAccountApis = new ArrayList<UserAccountApi>();
        }
        modelAndView.addObject("json", gson.toJson(userAccountApis));
        return modelAndView;
    }

    @RequestMapping(value = "/user/delete", method = RequestMethod.POST)
    public ModelAndView userDelete(HttpServletRequest request) {

        // common_bookmark -> userId
        // common_session -> userId
        // user_bookmark -> userId
        // user_group -> userId
        // user_search_history -> userId
        // user_table_option -> user Id
        try {
            String userId = request.getParameter("userId");
            commonBookmarkRepository.deleteByUserAccount_UserId(userId);
            sessionRepository.deleteByUserId(userId);
            userBookmarkRepository.deleteByUserAccount_UserId(userId);
            userGroupRepository.deleteByUserAccount_UserId(userId);
            userHistoryRepository.deleteByUserAccount_UserId(userId);
            tableOptionRepository.deleteByUserAccount_UserId(userId);
            userAccountRepository.deleteByUserId(request.getParameter("userId"));
            return new ModelAndView("api").addObject("json", true);
//        List<UserAccount> adminList = userAccountRepository.findAll();
        } catch (Exception e) {
            return new ModelAndView("api").addObject("json", false);
        }
    }


//    @RequestMapping(value = "/user/search")
//    public ModelAndView userSearch(HttpServletRequest request) {
//        String searchFilter = request.getParameter("searchFilter");
//        String searchInput = request.getParameter("searchInput");
//        List<UserAccount> adminList = null;
//        if (searchFilter.equals("userId")) {
//            adminList = userAccountRepository.findByUserId(searchInput);
//        } else if (searchFilter.equals("username")) {
//            adminList = userAccountRepository.findByUsername(searchInput);
//        } else {
//            adminList = new ArrayList<UserAccount>();
//        }
//        List<UserAccountApi> userAccountApis = new ArrayList<UserAccountApi>();
//        for (UserAccount userAccount : adminList) {
//            userAccountApis.add(getUserAccountApi(userAccount));
//        }
//        ModelAndView modelAndView = new ModelAndView("admin_user_list");
//        modelAndView.addObject("adminList", userAccountApis);
//        return modelAndView;
//    }

    @RequestMapping(value = "/user/update", method = RequestMethod.POST)
    public ModelAndView userUpdate(HttpServletRequest request) {
        Gson gson = new Gson();
        List<String> groupNames = gson.fromJson(request.getParameter("groupNames"), ArrayList.class);
        List<String> uncheckedGroupNames = gson.fromJson(request.getParameter("uncheckedGroupNames"), ArrayList.class);

//        String userIdOrg = sessionRepository.findByJSessionId(request.getSession().getId()).get(0).getUserId();
        // common_bookmark -> userId
        // common_session -> userId
        // user_bookmark -> userId
        // user_group -> userId
        // user_search_history -> userId
        // user_table_option -> user Id

        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserAccount userAccount = userAccountRepository.findByUserId(userId).get(0);
        userAccount.setUserId(userId);
        userAccount.setUsername(username);
        if (!password.equals("********")) {
            userAccount.setPassword(password);
        }

        userAccount = userAccountRepository.save(userAccount);

        List<CommonBookmark> commonBookmarks = commonBookmarkRepository.findByUserAccount_UserId(userId);
        for (CommonBookmark commonBookmark : commonBookmarks) {
            commonBookmark.setUserAccount(userAccount);
        }
        commonBookmarkRepository.save(commonBookmarks);

        List<Session> sessions = sessionRepository.findByUserId(userId);
        for (Session session : sessions) {
            session.setUserId(userId);
        }
        sessionRepository.save(sessions);

        List<UserBookmark> userBookmarks = userBookmarkRepository.findByUserAccount_UserId(userId);
        for (UserBookmark userBookmark : userBookmarks) {
            userBookmark.setUserAccount(userAccount);
        }
        userBookmarkRepository.save(userBookmarks);

        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userId);
        for (UserGroup userGroup : userGroups) {
            userGroup.setUserAccount(userAccount);
        }
        userGroupRepository.save(userGroups);

        List<UserHistory> userHistories = userHistoryRepository.findByUserAccount_UserId(userId);
        for (UserHistory userHistory : userHistories) {
            userHistory.setUserAccount(userAccount);
        }
        userHistoryRepository.save(userHistories);

        List<UserTableOption> userTableOptions = tableOptionRepository.findByUserAccount_UserId(userId);
        for (UserTableOption tableOption : userTableOptions) {
            tableOption.setUserAccount(userAccount);
        }
        tableOptionRepository.save(userTableOptions);

        for (String groupNameStr : groupNames) {
            if (userGroupRepository.findByUserAccount_UserIdAndGroupName_GroupName(userId, groupNameStr).size() <= 0) {
                CommonGroupName commonGroupName = groupNameRepository.findByGroupName(groupNameStr).get(0);
                userGroupRepository.save(new UserGroup(commonGroupName, userAccount));
            }
        }

        for (String groupNameStr : uncheckedGroupNames) {
            userGroupRepository.deleteByUserAccount_UserIdAndGroupName_GroupName(userId, groupNameStr);
        }

        return new ModelAndView("api").addObject("json", true);
    }

    @RequestMapping(value = "/user/join", method = RequestMethod.POST)
    public ModelAndView userJoin(HttpServletRequest request) {
        Gson gson = new Gson();
        List<String> groupNames = gson.fromJson(request.getParameter("groupNames"), ArrayList.class);
        List<String> uncheckedGroupNames = gson.fromJson(request.getParameter("uncheckedGroupNames"), ArrayList.class);

        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
//        String phone = request.getParameter("phone");
        if (userAccountRepository.findByUserId(userId).size() <= 0) {
            UserAccount userAccount = new UserAccount(userId, username, password, "0", UserType.USER);
            userAccount = userAccountRepository.save(userAccount);
            tableOptionRepository.save(new UserTableOption(userAccount, new int[]{50, 50, 50, 100, 100, 100, 100, 50, 50, 600, 50, 50}));
            List<AdminBookmark> adminBookmarks = adminBookmarkRepository.findAll();
            for (AdminBookmark adminBookmark : adminBookmarks) {
                commonBookmarkRepository.save(new CommonBookmark(userAccount, adminBookmark, 0));
            }

            for (String groupNameStr : groupNames) {
                if (userGroupRepository.findByUserAccount_UserIdAndGroupName_GroupName(userId, groupNameStr).size() <= 0) {
                    CommonGroupName commonGroupName = groupNameRepository.findByGroupName(groupNameStr).get(0);
                    userGroupRepository.save(new UserGroup(commonGroupName, userAccount));
                }
            }
        } else {
            return new ModelAndView("api").addObject("json", false);
        }
        return new ModelAndView("api").addObject("json", true);
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

    @RequestMapping(value = "/group-name/get")
    public ModelAndView groupNameGet(HttpServletRequest request) {
        Gson gson = new Gson();
        ModelAndView modelAndView = new ModelAndView("api");
        try {
            modelAndView.addObject("json", gson.toJson(groupNameRepository.findAll()));
        } catch (ArrayIndexOutOfBoundsException e) {
            modelAndView.addObject("json", false);
        }
        return modelAndView;
    }


    @RequestMapping(value = "/group-name/update")
    public ModelAndView groupNameUpdate(HttpServletRequest request) {
        try {
            String groupName = request.getParameter("groupName");
            String orgGroupName = request.getParameter("orgGroupName");
            if (orgGroupName.equals(Constant.GROUP_NAME_ALL)) {
                return new ModelAndView("api").addObject("json", Constant.GROUP_NAME_ALL + " 그룹은 수정할 수 없습니다.");
            } else if (groupName.equals(orgGroupName)) {    //그룹명의 변동이 없는 경우
                return new ModelAndView("api").addObject("json", true);
            } else if (groupNameRepository.findByGroupName(groupName).size() <= 0) {    //그룹명이 이미 존재하는지 확인
                CommonGroupName commonGroupName = groupNameRepository.findByGroupName(orgGroupName).get(0);
                List<UserGroup> userGroups = userGroupRepository.findByGroupName(commonGroupName);
                commonGroupName.setGroupName(groupName);
                commonGroupName = groupNameRepository.save(commonGroupName);
//                UserGroup userGroup;
                for (int i = 0; i < userGroups.size(); i++) {
                    userGroups.get(i).getGroupName().setGroupName(groupName);
//                    userGroup = userGroupRepository.save(userGroups.get(i));
                    userGroupRepository.save(userGroups.get(i));
                }
                return new ModelAndView("api").addObject("json", true);
            } else return new ModelAndView("api").addObject("json", false);
        } catch (Exception e) {
            return new ModelAndView("api").addObject("json", false);
        }
    }

    @RequestMapping(value = "/group-name/add")
    public ModelAndView groupNameAdd(HttpServletRequest request) {
        String groupName = request.getParameter("groupName");
        ModelAndView modelAndView = new ModelAndView("api");
        if (groupNameRepository.findByGroupName(groupName).size() <= 0) {
            groupNameRepository.save(new CommonGroupName(groupName));
//                modelAndView.addObject("groupList", groupNameRepository.findAll());
            return new ModelAndView("api").addObject("json", true);
        } else {
            return new ModelAndView("api").addObject("json", false);
        }
    }


    @RequestMapping(value = "/group-name/delete", method = RequestMethod.POST)
    public ModelAndView groupNameDelete(HttpServletRequest request) {
        try {
            String groupName = request.getParameter("groupName");

            if (groupName.equals(Constant.GROUP_NAME_ALL)) {
                return new ModelAndView("api").addObject("json", Constant.GROUP_NAME_ALL + " 그룹은 삭제할 수 없습니다.");
            }
            userGroupRepository.deleteByGroupName_GroupName(groupName);
            groupNameRepository.deleteByGroupName(groupName);
            ModelAndView modelAndView = new ModelAndView("admin_group_name_list");
//        List<CommonGroupName> groupNames = groupNameRepository.findAll();
//        modelAndView.addObject("groupList", groupNames);
            return new ModelAndView("api").addObject("json", true);
        } catch (Exception e) {
            return new ModelAndView("api").addObject("json", false);
        }
    }

    @RequestMapping(value = "/user-group/get")
    public ModelAndView userGroupGet(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        Gson gson = new Gson();
        ModelAndView modelAndView = new ModelAndView("api");
        List<CommonGroupName> commonGroupNames = groupNameRepository.findAll();
        List<GroupApi> groupApis = new ArrayList<GroupApi>();
        try {
            if (userId == null) {
                for (CommonGroupName commonGroupName : commonGroupNames) {
                    groupApis.add(new GroupApi(commonGroupName.getGroupName(), false));
                }
            } else {
                UserAccountApi userAccountApi = getUserAccountApi(userAccountRepository.findByUserId(userId).get(0));

                for (CommonGroupName commonGroupName : commonGroupNames) {
                    if (userAccountApi.hasGroupName(commonGroupName.getGroupName())) {
                        groupApis.add(new GroupApi(commonGroupName.getGroupName(), true));
                    } else {
                        groupApis.add(new GroupApi(commonGroupName.getGroupName(), false));
                    }
                }
            }
            modelAndView.addObject("json", gson.toJson(groupApis));
        } catch (ArrayIndexOutOfBoundsException e) {
            modelAndView.addObject("json", false);
        }

        return modelAndView;
    }


    private List<UserAccountApi> getAllUserAccountApis() {
        Map<String, String> groupNameMap = getGroupMap();
        List<UserAccount> adminList = userAccountRepository.findByType(UserType.USER);
        List<UserAccountApi> userAccountApis = new ArrayList<UserAccountApi>();
        for (UserAccount userAccount : adminList) {
            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
            List<UserGroupApi> userGroupApis = new ArrayList<UserGroupApi>();
            for (UserGroup userGroup : userGroups) {
                UserGroupApi tmpGroupApi = new UserGroupApi(userGroup.getGroupName().getGroupName(), groupNameMap.get(userGroup.getGroupName().getGroupName()));
                userGroupApis.add(tmpGroupApi);
            }
            UserAccountApi userAccountApi = new UserAccountApi(userAccount, userGroupApis);
            userAccountApis.add(userAccountApi);
        }

        return userAccountApis;
    }

    private List<UserAccountApi> getUserAccountApis(List<UserAccount> userAccounts) {
//        List<UserAccount> adminList = userAccountRepository.findAll();
        Map<String, String> groupNameMap = getGroupMap();
        List<UserAccountApi> userAccountApis = new ArrayList<UserAccountApi>();
        for (UserAccount userAccount : userAccounts) {
            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
            List<UserGroupApi> userGroupApis = new ArrayList<UserGroupApi>();

            for (UserGroup userGroup : userGroups) {
                UserGroupApi tmpGroupApi = new UserGroupApi(userGroup.getGroupName().getGroupName(), groupNameMap.get(userGroup.getGroupName().getGroupName()));
                userGroupApis.add(tmpGroupApi);
            }
            UserAccountApi userAccountApi = new UserAccountApi(userAccount, userGroupApis);
            userAccountApis.add(userAccountApi);
        }

        return userAccountApis;
    }
//
//    private List<UserAccountApi> getAllAdminAccountApis() {
//        List<UserAccount> adminList = userAccountRepository.findByType(UserType.ADMIN);
//        List<UserAccountApi> userAccountApis = new ArrayList<UserAccountApi>();
//        for (UserAccount userAccount : adminList) {
//            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
//            UserAccountApi userAccountApi = new UserAccountApi(userAccount, userGroups);
//            userAccountApis.add(userAccountApi);
//        }
//
//        return userAccountApis;
//    }

    private List<UserAccountApi> getAdminAccountApis(List<UserAccount> adminAccounts) {
//        List<UserAccount> adminList = userAccountRepository.findAll();
        Map<String, String> groupNameMap = getGroupMap();


        List<UserAccountApi> adminAccountApis = new ArrayList<UserAccountApi>();
        for (UserAccount adminAccount : adminAccounts) {
            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(adminAccount.getUserId());

            List<UserGroupApi> userGroupApis = new ArrayList<UserGroupApi>();

            for (UserGroup userGroup : userGroups) {
                UserGroupApi tmpGroupApi = new UserGroupApi(userGroup.getGroupName().getGroupName(), groupNameMap.get(userGroup.getGroupName().getGroupName()));
                userGroupApis.add(tmpGroupApi);
            }
            UserAccountApi adminAccountApi = new UserAccountApi(adminAccount, userGroupApis);
            adminAccountApis.add(adminAccountApi);
        }

        return adminAccountApis;
    }

    private UserAccountApi getUserAccountApi(UserAccount userAccount) {
        Map<String, String> groupNameMap = getGroupMap();

        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
        List<UserGroupApi> userGroupApis = new ArrayList<UserGroupApi>();

        for (UserGroup userGroup : userGroups) {
            UserGroupApi tmpGroupApi = new UserGroupApi(userGroup.getGroupName().getGroupName(), groupNameMap.get(userGroup.getGroupName().getGroupName()));
            userGroupApis.add(tmpGroupApi);
        }
        return new UserAccountApi(userAccount, userGroupApis);
    }

    private UserGroupApi getUserGroupApi(UserGroup userGroup) {
        return new UserGroupApi(userGroup.getGroupName().getGroupName(), groupNameRepository.findByGroupName(userGroup.getGroupName().getGroupName()).get(0).getGroupId());
    }


    @RequestMapping(value = "/test")
    public ModelAndView nicknameTestPage(HttpServletRequest request) {
        return new ModelAndView("test");
    }

    @RequestMapping(value = "/test/nickname/add")
    public ModelAndView addNickname(HttpServletRequest request) {
        Gson gson = new Gson();

        int authorCount = 0;
        int stringCount = 0;

        try {
            authorCount = Integer.parseInt(request.getParameter("author-count"));
            stringCount = Integer.parseInt(request.getParameter("string-count"));
            if (Math.log(authorCount) / Math.log(10) >= stringCount) {
                return new ModelAndView("api").addObject("json", "글자수가 더 커야합니다.");
            }
            ArrayList<NicknameOption> nickList = new ArrayList<NicknameOption>();
            for (int i = 0; i < authorCount; i++) {

                if (nicknameRepository.findByAuthor("" + i).size() <= 0) {
                    String nickname = null;
                    do {
                        nickname = getRandomString(stringCount);
                    } while (nicknameRepository.findByNickname(nickname).size() > 0);
                    NicknameOption tmpNick = new NicknameOption("" + i, nickname, "9", "");
                    nickList.add(tmpNick);
                }
            }
            nicknameRepository.save(nickList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("api").addObject("json", gson.toJson(nicknameRepository.findAll()));
    }

    @RequestMapping(value = "/test/nickname/get")
    public ModelAndView getTestNickname(HttpServletRequest request) {

        return new ModelAndView("api").addObject("json", new Gson().toJson(nicknameRepository.findAll()));
    }

    @RequestMapping(value = "/test/nickname/delete")
    public ModelAndView deleteAllNickname(HttpServletRequest request) {
        Gson gson = new Gson();

        nicknameRepository.deleteAll();

        return new ModelAndView("api").addObject("json", gson.toJson(nicknameRepository.findAll()));
    }

    @RequestMapping(value = "/test/search")
    public ModelAndView searchNickname(HttpServletRequest request) {
        Gson gson = new Gson();
        try {
            int searchSize = Integer.parseInt(request.getParameter("search-data-count"));
            ArrayList<BookInfo> bookInfoList = new ArrayList<BookInfo>();
            for (int i = 0; i < searchSize; i++) {
                Random random = new Random();
                String author = String.valueOf(random.nextInt(3000));
                String referencedAuthor = String.valueOf(random.nextInt(3000));
                bookInfoList.add(new BookInfo("", "", "", "", author, referencedAuthor, "", "", "", "", ""));
            }
            ArrayList<BookInfo> bookInfoList1 = new ArrayList<BookInfo>(bookInfoList);

            long start = System.currentTimeMillis();
            for (BookInfo bookInfo : bookInfoList) {
                List<NicknameOption> nicknames = nicknameRepository.findByAuthor(bookInfo.getAuthor());
                //find in nickname table and if nickname exist, add to BookInfo
                if (nicknames.size() > 0) {
                    bookInfo.setAuthNickname(nicknames.get(0).getNickname());
                }
            }
            for (BookInfo bookInfo : bookInfoList) {
                List<NicknameOption> nicknames = nicknameRepository.findByAuthor(bookInfo.getReferencedAuthor());
                //find in nickname table and if nickname exist, add to BookInfo
                if (nicknames.size() > 0) {
                    bookInfo.setRefNickname(nicknames.get(0).getNickname());
                }
            }
            long end = System.currentTimeMillis();

            long runningTime1 = end - start;

//            System.out.println(gson.toJson(bookInfoList1));
            start = System.currentTimeMillis();
            fillNicknamesOfBookList(bookInfoList1);
            end = System.currentTimeMillis();

            long runningTime2 = end - start;

            return new ModelAndView("api").addObject("json",
                    "기존 결과: " + runningTime1 + " ms\n" +
                            "<br>신규 결과: " + runningTime2 + " ms\n" +
                            "<br>기존 결과 데이터: " + gson.toJson(bookInfoList) + "\n" +
                            "신규 결과 데이터: " + gson.toJson(bookInfoList1));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("api").addObject("json", "실패");
    }

    private String getRandomString(int length) {
        char[] charaters = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
//        char[] charaters = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
        StringBuilder sb = new StringBuilder();
        Random rn = new Random();
        for (int i = 0; i < length; i++) {
            sb.append(charaters[rn.nextInt(charaters.length)]);
        }
        return sb.toString();
    }

    private List<BookInfo> fillNicknamesOfBookList(List<BookInfo> bookInfoList) {
        List<NicknameOption> nicknames = nicknameRepository.findAll();

        for (BookInfo bookInfo : bookInfoList) {
            for (NicknameOption nicknameOption : nicknames) {
                if (bookInfo.getAuthor().equals(nicknameOption.getAuthor())) {
                    bookInfo.setAuthNickname(nicknameOption.getNickname());
                    System.out.println(bookInfo.getReferencedAuthor());
                    if (!bookInfo.getRefNickname().equals("")) {
                        break;
                    }
                } else if (bookInfo.getReferencedAuthor().equals(nicknameOption.getAuthor())) {
                    bookInfo.setRefNickname(nicknameOption.getNickname());
                    if (!bookInfo.getAuthNickname().equals("")) {
                        break;
                    }
                }
            }
        }

        return bookInfoList;
    }


//    @RequestMapping(value = "/group-map/refresh")
//    public ModelAndView groupMap(HttpServletRequest request) {
//        ModelAndView modelAndView = new ModelAndView("admin_group_map_list");
//
////        System.out.println(System.getProperty("user.dir"));
////        File dir1 = new File("group.conf");
////        List<CommonGroupName> commonGroupNames = new ArrayList<CommonGroupName>();
////        try {
////            System.out.println("Current dir : " + dir1.getCanonicalPath());
////            BufferedReader in = new BufferedReader(new FileReader(dir1));
////            String s;
////
////            while ((s = in.readLine()) != null) {
////                CommonGroupName commonGroupName = new CommonGroupName(s.split(" ")[0], s.split(" ")[1]);
////                commonGroupNames.add(commonGroupName);
////            }
////            in.close();
////        } catch (Exception e) {
////            e.printStackTrace();
////        }
//
////        modelAndView.addObject("groupList", commonGroupNames);
//        return modelAndView;
//    }

    @RequestMapping(value = "/group-name/refresh")
    public ModelAndView getGroupMap(HttpServletRequest request) throws NumberFormatException, IOException {
        ModelAndView modelAndView = new ModelAndView("api");
        Gson gson = new Gson();


        System.out.println(System.getProperty("user.dir"));
        List<CommonGroupName> commonGroupNames = new ArrayList<CommonGroupName>();
        //try {
            //BufferedReader in = new BufferedReader(new FileReader(dir1));
            //String s;
        	//while ((s = in.readLine()) != null) {
	    	String path = MainPageController.class.getResource("").getPath(); // 현재 클래스의 절대 경로를 가져온다.
	        BufferedReader in = new BufferedReader(new FileReader(new File(path).getParentFile().getParentFile().getParent() + File.separator + "IPandPort.txt"));

	        String ip = in.readLine();
	        int port = Integer.parseInt(in.readLine());
	        System.out.println(ip + " : " + port);

	        SocketComm sc = new SocketComm("userName@group", ip, port, 99, 0);
			sc.runStart();
			String str = "";
			if (sc.beGetGood() >= 0) str = sc.getGroup();
			else 	str = "";

	    	String[] ss = "AAA A`BBB B`CCC C".split("`");
	    	for (int i=0; i < ss.length; i++) {
                CommonGroupName commonGroupName = new CommonGroupName(ss[i].split(" ")[0], ss[i].split(" ")[1]);
                commonGroupNames.add(commonGroupName);
            }
            //in.close();
        //} catch (Exception e) {
        //    e.printStackTrace();
		//}

        Map<String, String> groupIdMap = getGroupIdMap();
        System.out.println(gson.toJson(commonGroupNames));
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
        modelAndView.addObject("json", gson.toJson(groupNameRepository.findAll()));
        return modelAndView;
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
}
