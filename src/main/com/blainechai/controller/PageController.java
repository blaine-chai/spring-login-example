package com.blainechai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by blainechai on 2016. 9. 5..
 */
@Controller
@RequestMapping("/")
public class PageController {
//    @RequestMapping(value = "/add", method = RequestMethod.POST)
//    public ModelAndView

    @RequestMapping(value = {""})
    public String mainPage() {
        return "index";
    }
}
