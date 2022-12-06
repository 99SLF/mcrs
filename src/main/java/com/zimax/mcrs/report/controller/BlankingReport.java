package com.zimax.mcrs.report.controller;

import com.zimax.mcrs.report.service.Blanking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 李伟杰
 * @date 2022/12/5 10:59
 */
@RestController
@ResponseBody
@RequestMapping("/blanking")
public class BlankingReport {
    @Autowired
    private Blanking blanking;
}
