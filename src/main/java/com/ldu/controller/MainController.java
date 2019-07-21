package com.ldu.controller;

import com.ldu.pojo.User;
import com.ldu.util.UserGrid;
import com.ldu.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by David on 2018/11/9.
 */
@Controller
public class MainController {
    /**
     * page：第几页    pageSize：每页的个数
     */
    @Resource
    private UserService userService;
    @RequestMapping(value = "/api/v1/users")
    @ResponseBody
    public UserGrid getUserList(@RequestParam(value = "page",required = false) Integer page,
                                @RequestParam(value = "pageSize",required = false) Integer pageSize,
                                @RequestParam(value = "username",required = false) String username) {
        System.out.println("username:"+username);
        int total = userService.getUserNum();  //查询所有用户的数量
        String pageStr = page + "";
        String pageSizeStr = pageSize + "";
        if("".equals(pageStr))
            page = 1;
        if("".equals(pageSizeStr))
            pageSize = 10;
        List<User> data = userService.getPageUser(1,10);
        System.out.println("data:"+data.size());
        UserGrid userGrid = new UserGrid();
        userGrid.setRows(data);
        userGrid.setTotal(total);
        //userGrid.setCurrent(page);  //当前页面号
        //userGrid.setRowCount(pageSize);  //每页的个数
        return userGrid;
    }
}
