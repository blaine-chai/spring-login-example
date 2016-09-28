//package com.blainechai.controller;
//
//import com.blainechai.domain.UserAccount;
//import com.blainechai.repository.UserAccountRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.servlet.ModelAndView;
//
//import javax.servlet.http.HttpServletRequest;
//import java.util.List;
//
//@Controller
//@RequestMapping("/admin/user")
//public class UserController {
//
//    @Autowired
//    private UserAccountRepository userAccountRepository;
//
//    @RequestMapping(value = "")
//    public ModelAndView list() {
//        List<UserAccount> userList = userAccountRepository.findAll();
//        ModelAndView modelAndView = new ModelAndView("admin_user_list");
//        modelAndView.addObject("userList", userList);
//        return modelAndView;
//    }
//
//    @RequestMapping(value = "/search")
//    public ModelAndView deactivateList(HttpServletRequest request) {
//        List<UserAccount> result = null;
////        String searchInput = request.getParameter("searchInput");
////        String searchFilter = request.getParameter("searchFilter");
////        String activeFilter = request.getParameter("activeFilter");
////        if (searchInput.length() > 0) {
////            if (searchFilter.equals("account")) {
////                result = userAccountRepository.findByAccount(searchInput);
////            } else if (searchFilter.equals("number")) {
////                result = userAccountRepository.findByNumber(searchInput);
////            } else if (searchFilter.equals("uuid")) {
////                result = userAccountRepository.findByUuid(searchInput);
////            }
////        } else {
////            if (activeFilter != null) {
////                result = userAccountRepository.findByActive(false);
////            } else {
////                result = userAccountRepository.findAll();
////            }
////        }
//        ModelAndView modelAndView = new ModelAndView("admin_user_list");
//        modelAndView.addObject("userList", result);
//        return modelAndView;
//    }
//
//    @RequestMapping(value = "/modify")
//    public ModelAndView modifyUser(HttpServletRequest request) {
//        String uuid = request.getParameter("uuid");
//        ModelAndView modelAndView = new ModelAndView("admin_user_modify");
//        try {
////            modelAndView.addObject("userInfo", userAccountRepository.findByUuid(uuid).get(0));
//        } catch (ArrayIndexOutOfBoundsException e) {
//            modelAndView = new ModelAndView("redirect:" + "/admin/user");
//        }
//        return modelAndView;
//    }
//
//    @RequestMapping(value = "/update", method = RequestMethod.POST)
//    public String updateUser(HttpServletRequest request) {
//        String uuid = request.getParameter("uuid");
//        String number = request.getParameter("number");
//        String active = request.getParameter("active");
//        boolean activeChecked;
//        if (active != null)
//            activeChecked = false;
//        else
//            activeChecked = true;
//
////        UserAccount updateUser = userAccountRepository.findByUuid(uuid).get(0);
////        if (userAccountRepository.findByNumber(number).size() == 0 || updateUser.isActive() != activeChecked) {
////            updateUser.setNumber(number);
////            updateUser.setActive(activeChecked);
////            userAccountRepository.save(updateUser);
////
//////            UserAddress updateUserAddress = userAddressRepository.findByUuid(uuid).get(0);
//////            updateUserAddress.setUuid(updateUser.getUuid());
//////
//////            DeliveryAddress updateDeliveryAddress = deliveryAddressRepository.findByUuid(uuid).get(0);
//////            updateDeliveryAddress.setUuid(updateUser.getUuid());
//////
//////            userAddressRepository.save(updateUserAddress);
//////            deliveryAddressRepository.save(updateDeliveryAddress);
////            return "redirect:" + "/admin/user";
////        }
//        return "redirect:" + "/admin/user"; // 중복된 번호라고 언급해야함.
//    }
//
//    @RequestMapping(value = "/delete")
//    public String deleteUser(HttpServletRequest request) {
////        String uuid = request.getParameter("uuid");
////        userAccountRepository.deleteByUuid(uuid);
////        userAddressRepository.deleteByUuid(uuid);
////        deliveryAddressRepository.deleteByUuid(uuid);
//        return "redirect:" + "/admin/user";
//    }
//}