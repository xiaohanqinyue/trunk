package com.ldu.controller;

import com.ldu.service.CatelogService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

/**
 * Created by David on 2018/11/9.
 */
@Controller
public class CatelogController {
    @Resource
    private CatelogService catelogService;

}
