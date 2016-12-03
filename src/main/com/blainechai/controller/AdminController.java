package com.blainechai.controller;

import com.blainechai.constant.UserType;
import com.blainechai.domain.*;
import com.blainechai.model.GroupApi;
import com.blainechai.model.UserAccountApi;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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


    @RequestMapping(value = "/admin-account/search")
    public ModelAndView adminAccountSearch(HttpServletRequest request) {
        String searchFilter = request.getParameter("searchFilter");
        String searchInput = request.getParameter("searchInput");
        List<UserAccount> adminList = null;
        if (searchFilter.equals("userId")) {
            adminList = userAccountRepository.findByUserIdAndType(searchInput, UserType.ADMIN);
        } else if (searchFilter.equals("username")) {
            adminList = userAccountRepository.findByUsernameAndType(searchInput, UserType.ADMIN);
        } else {
            adminList = new ArrayList<UserAccount>();
        }
        ModelAndView modelAndView = new ModelAndView("admin_administrator_list");
        modelAndView.addObject("adminList", adminList);
        return modelAndView;
    }

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

    @RequestMapping(value = "/user/modify", method = RequestMethod.POST)
    public ModelAndView userModify(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        ModelAndView modelAndView = new ModelAndView("api");
        try {
            UserAccount userAccount = userAccountRepository.findByUserId(request.getParameter("userId")).get(0);
//            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
//            UserAccountApi userAccountApi = new UserAccountApi(userAccount, userGroups);
            List<CommonGroupName> groupNames = groupNameRepository.findAll();
            modelAndView.addObject("adminInfo", getUserAccountApi(userAccount));
            modelAndView.addObject("groupNames", groupNames);
        } catch (ArrayIndexOutOfBoundsException e) {
            modelAndView = new ModelAndView("redirect:" + "/admin/user");
        }
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


    @RequestMapping(value = "/user/search")
    public ModelAndView userSearch(HttpServletRequest request) {
        String searchFilter = request.getParameter("searchFilter");
        String searchInput = request.getParameter("searchInput");
        List<UserAccount> adminList = null;
        if (searchFilter.equals("userId")) {
            adminList = userAccountRepository.findByUserId(searchInput);
        } else if (searchFilter.equals("username")) {
            adminList = userAccountRepository.findByUsername(searchInput);
        } else {
            adminList = new ArrayList<UserAccount>();
        }
        List<UserAccountApi> userAccountApis = new ArrayList<UserAccountApi>();
        for (UserAccount userAccount : adminList) {
            userAccountApis.add(getUserAccountApi(userAccount));
        }
        ModelAndView modelAndView = new ModelAndView("admin_user_list");
        modelAndView.addObject("adminList", userAccountApis);
        return modelAndView;
    }

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
            if (groupName.equals(orgGroupName)) {
                return new ModelAndView("api").addObject("json", true);
            } else if (groupNameRepository.findByGroupName(groupName).size() <= 0) {
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
            userGroupRepository.deleteByGroupName_GroupName(request.getParameter("groupName"));
            groupNameRepository.deleteByGroupName(request.getParameter("groupName"));
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
        List<UserAccount> adminList = userAccountRepository.findByType(UserType.USER);
        List<UserAccountApi> userAccountApis = new ArrayList<UserAccountApi>();
        for (UserAccount userAccount : adminList) {
            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
            UserAccountApi userAccountApi = new UserAccountApi(userAccount, userGroups);
            userAccountApis.add(userAccountApi);
        }

        return userAccountApis;
    }

    private List<UserAccountApi> getUserAccountApis(List<UserAccount> userAccounts) {
//        List<UserAccount> adminList = userAccountRepository.findAll();
        List<UserAccountApi> userAccountApis = new ArrayList<UserAccountApi>();
        for (UserAccount userAccount : userAccounts) {
            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
            UserAccountApi userAccountApi = new UserAccountApi(userAccount, userGroups);
            userAccountApis.add(userAccountApi);
        }

        return userAccountApis;
    }

    private List<UserAccountApi> getAllAdminAccountApis() {
        List<UserAccount> adminList = userAccountRepository.findByType(UserType.ADMIN);
        List<UserAccountApi> userAccountApis = new ArrayList<UserAccountApi>();
        for (UserAccount userAccount : adminList) {
            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
            UserAccountApi userAccountApi = new UserAccountApi(userAccount, userGroups);
            userAccountApis.add(userAccountApi);
        }

        return userAccountApis;
    }

    private List<UserAccountApi> getAdminAccountApis(List<UserAccount> adminAccounts) {
//        List<UserAccount> adminList = userAccountRepository.findAll();
        List<UserAccountApi> adminAccountApis = new ArrayList<UserAccountApi>();
        for (UserAccount adminAccount : adminAccounts) {
            List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(adminAccount.getUserId());
            UserAccountApi adminAccountApi = new UserAccountApi(adminAccount, userGroups);
            adminAccountApis.add(adminAccountApi);
        }

        return adminAccountApis;
    }

    private UserAccountApi getUserAccountApi(UserAccount userAccount) {
        List<UserGroup> userGroups = userGroupRepository.findByUserAccount_UserId(userAccount.getUserId());
        return new UserAccountApi(userAccount, userGroups);
    }
}
