package com.ldu.controller;

import com.ldu.pojo.User;
import com.ldu.pojo.Goods;
import com.ldu.pojo.Catelog;
import com.ldu.service.*;
import com.ldu.util.*;
import com.ldu.service.CatelogService;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.List;


@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    @Resource
    private UserService userService;

    @Resource
    private CatelogService catelogService;
    @Resource
    private GoodsService goodsService;
    @Resource
    private ImageService imageService;

    @RequestMapping(value = "/adminLogin",method = RequestMethod.GET)
    public String adminLogin() {
        return "/admin/adminLogin";//17862821585    shikun1103+.
    }
    @RequestMapping(value = "/adminIndex",method = RequestMethod.GET)
    public String adminIndexTo() {
        return "/admin/adminIndex";
    }
    @RequestMapping(value = "/userList",method = RequestMethod.GET)
    public String userList() {
        return "/admin/userList";
    }
    @RequestMapping(value = "/goodsList",method = RequestMethod.GET)
    public String goodsList() {
        return "/admin/goodsList";
    }
    @RequestMapping(value = "/catelogList",method = RequestMethod.GET)
    public String catelogList() {
        return "/admin/catelogList";
    }

//    @RequestMapping(value = "/adminLogin",method = RequestMethod.GET)
//    public String adminLogin(HttpServletRequest request) {
//        User cur_user = userService.getUserByPhone(request.getParameter("username"));
//        String url=request.getHeader("Referer");
//        if(cur_user != null) {
//            String pwd = MD5.md5(request.getParameter("password")); //对填写的用户密码进行md5加密
//            if(pwd.equals(cur_user.getPassword())) {   //cur_user.getPassword()为数据库中用户的密码
//                request.getSession().setAttribute("cur_admin",cur_user);
//                //return new ModelAndView("redirect:"+url);
//                return "/admin/adminIndex";
//            }
//        }
//        //return new ModelAndView("redirect:"+url);
//        return "redirect:"+url;
//    }

    @RequestMapping(value = "/adminLoginTo",method = RequestMethod.GET)
    public String adminLoginTo(HttpServletRequest request) {
        User cur_user = userService.getUserByPhone(request.getParameter("username"));
        String url=request.getHeader("Referer");
        if(cur_user != null&&cur_user.getPower()>10) {
            String pwd = MD5.md5(request.getParameter("password")); //对填写的用户密码进行md5加密
            if(pwd.equals(cur_user.getPassword())) {   //cur_user.getPassword()为数据库中用户的密码
                request.getSession().setAttribute("cur_admin",cur_user);
                //return new ModelAndView("redirect:"+url);
                return "/admin/adminIndex";
            }
        }
        //return new ModelAndView("redirect:"+url);
        return "redirect:"+url;
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpServletRequest request) {
        User cur_user=(User)request.getSession().getAttribute("cur_user");
        request.getSession().setAttribute("cur_admin",null);
        if(cur_user.getPower()>10){
            request.getSession().setAttribute("cur_user",null);
        }

        return "redirect:/goods/homeGoods";
    }





    @RequestMapping(value="/getUserInfo",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public User getUserById(@RequestParam("userId") int userId){
        User user = userService.selectByPrimaryKey(userId);
        return user;
    }


    //管理员登录信息
    @RequestMapping(value = "/login")
    public String loginValidate(HttpServletRequest request) {
        String url=request.getHeader("Referer");
        //从session中获取出当前用户
        User cur_user = (User)request.getSession().getAttribute("cur_user");
        //用户权限小于90，必需要以管理员的身份
        if(cur_user.getPower()<90){
            return "redirect:/admin/adminLogin";
        }
        //大于90直接可以进去后台
        request.getSession().setAttribute("cur_admin",cur_user);
        return "admin/adminIndex";
    }








    @RequestMapping(value="/getCatelogInfo",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public Catelog getCatelogById(@RequestParam("catelogId") int catelogId){
        Catelog catelog = catelogService.selectByPrimaryKey(catelogId);
        return catelog;
    }


    @RequestMapping(value="/getGoodInfo",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public Goods getGoodById(@RequestParam("goodId") int GoodId){
        Goods good = goodsService.getGoodsByPrimaryKey(GoodId);
        return good;
    }

    @RequestMapping(value = "/users",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public UserGrid getUserList(@RequestParam("current") int current,@RequestParam("rowCount") int rowCount) {
        int total = userService.getUserNum();
        List<User>  list = userService.getPageUser(current,rowCount);
        UserGrid userGrid = new UserGrid();
        userGrid.setCurrent(current);
        userGrid.setRowCount(rowCount);
        userGrid.setRows(list);
        userGrid.setTotal(total);
        return userGrid;
    }

    @RequestMapping(value = "/goods",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public GoodsGrid getGoodsList(@RequestParam("current") int current, @RequestParam("rowCount") int rowCount) {
        int total = goodsService.getAllGoods().size();
        List<Goods>  list = goodsService.getPageGood(current,rowCount);
        GoodsGrid goodsGrid = new GoodsGrid();
        goodsGrid.setCurrent(current);
        goodsGrid.setRowCount(rowCount);
        goodsGrid.setRows(list);
        goodsGrid.setTotal(total);
        return goodsGrid;
    }

    //添加商品类别信息
    @RequestMapping(value = "/addCatelog")
    public String addUser(HttpServletRequest request) {
        String url=request.getHeader("Referer");   //获取来源页地址
        String name=request.getParameter("catelogName");
        System.out.print(name);
        Catelog catelog=catelogService.selectByname(name);
        if(catelog==null) {
            Catelog catelog1=new Catelog();
            catelog1.setName(name);
            catelog1.setNumber(0);//初始状态商品数量都为1
            catelog1.setStatus(1);
            catelogService.addCatelog(catelog1);
        }
        return "redirect:"+url;  //重定向回来源页
    }


    //得到商品类别信息
    @RequestMapping(value = "/catelogs",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public CatelogGrid getcatelogList(@RequestParam("current") int current,@RequestParam("rowCount") int rowCount) {
        int total = catelogService.getAllCatelogs();
        List<Catelog>  list = catelogService.getPageCatelog(current,rowCount);
        CatelogGrid catelogGrid = new CatelogGrid();
        catelogGrid.setCurrent(current);
        catelogGrid.setRowCount(rowCount);
        catelogGrid.setRows(list);
        catelogGrid.setTotal(total);
        return catelogGrid;
    }


    //将用户信息导出到Excel
    @RequestMapping("/exportUser")
    public void export(HttpServletResponse response) throws Exception{
        InputStream is=userService.getInputStream();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("contentDisposition", "attachment;filename=AllUsers.xls");
        ServletOutputStream output = response.getOutputStream();
        IOUtils.copy(is,output);
    }



    //更新用户信息
    @RequestMapping("/UpdateUser")
    public ModelAndView updateInfo(HttpServletRequest request, User user, ModelMap modelMap) {
        String id=request.getParameter("userId");
        String phone=request.getParameter("userPhone");
        String userName=request.getParameter("userName");
        String password=request.getParameter("userPassword");
        String qq=request.getParameter("userQQ");
        String userCreateAt=request.getParameter("userCreateAt");
        String userGoodnums=request.getParameter("userGoodnums");
        String power=request.getParameter("userPower");
        //   System.out.println(id+""+phone+""+userName+""+password+""+qq+""+goodnums);
        User cur_user=new User();
        cur_user.setId(Integer.parseInt(id));
        cur_user.setPhone(phone);
        cur_user.setUsername(userName);
        cur_user.setPassword(password);
        cur_user.setQq(qq);
        cur_user.setCreateAt(userCreateAt);
        cur_user.setGoodsNum(Integer.parseInt(userGoodnums));
        cur_user.setPower(Integer.parseInt(power));
        System.out.println(cur_user.getId()+"\t"+cur_user.getPhone()+"\t"+cur_user.getUsername()+"\t"+cur_user.getPassword()+"\t"+cur_user.getQq()+"\t"+cur_user.getGoodsNum());
        userService.updateUserName(cur_user);//执行修改操作
        return new ModelAndView("redirect:/admin/userList");
    }



    //更新商品信息
    @RequestMapping("/UpdateGood")
    public ModelAndView updateGoodInfo(HttpServletRequest request, User user, ModelMap modelMap) {
        String id=request.getParameter("goodId");
        String catelogId=request.getParameter("catelogId");
        String userId=request.getParameter("userId");
        String goodsName=request.getParameter("goodsName");
        String goodsPrice=request.getParameter("goodsPrice");
        String realPrice=request.getParameter("realPrice");
        String startTime=request.getParameter("startTime");
        String publishTime=request.getParameter("publishTime");
        String endTime=request.getParameter("endTime");
        String describle=request.getParameter("describle");

        Goods cur_good=new Goods();
        cur_good.setId(Integer.parseInt(id));
        cur_good.setCatelogId(Integer.parseInt(catelogId));
        cur_good.setUserId(Integer.parseInt(userId));
        cur_good.setName(goodsName);
        cur_good.setPrice(Float.valueOf(goodsPrice));
        cur_good.setRealPrice(Float.valueOf(realPrice));
        cur_good.setStartTime(startTime);
        cur_good.setPolishTime(publishTime);
        cur_good.setEndTime(endTime);
        cur_good.setDescrible(describle);

        goodsService.updateGoodsByPrimaryKeyWithBLOBs(cur_good.getId(),cur_good);//执行修改操作
        return new ModelAndView("redirect:/admin/goodsList");
    }

    //更新商品类别信息
    @RequestMapping("/UpdateCatelog")
    public ModelAndView updateCatelog(HttpServletRequest request, ModelMap modelMap) {
        String id=request.getParameter("catelogId");
        String name=request.getParameter("catelogName");
        String number=request.getParameter("catelogNum");
        String status=request.getParameter("catelogSta");
        //   System.out.println(id+""+phone+""+userName+""+password+""+qq+""+goodnums);
        Catelog cur_catelog=new Catelog();
        cur_catelog.setId(Integer.parseInt(id));
        cur_catelog.setName(name);
        cur_catelog.setNumber(Integer.parseInt(number));
        cur_catelog.setStatus(Integer.parseInt(status));
        System.out.print(cur_catelog.getId()+"\t"+cur_catelog.getName()+"\t"+cur_catelog.getNumber()+"\t"+cur_catelog.getStatus());
        catelogService.updateByPrimaryKey(cur_catelog);//执行修改操作
        return new ModelAndView("redirect:/admin/catelogList");
    }


    //删除用户
    @RequestMapping(value="/delUser",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public  void delUserInfo(@RequestParam("userId") int userId){
        System.out.print(userId);
        userService.deleteUser(userId);
    }


    //删除用户
    @RequestMapping(value="/delCatelog",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public  void delCatelogInfo(@RequestParam("catelogId") int catelogId){
        catelogService.deleteCatelog(catelogId);
    }

    //删除商品
    @RequestMapping(value="/delGood",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public  void delGoodInfo(@RequestParam("goodId") int goodId){

        Goods goods = goodsService.getGoodsByPrimaryKey(goodId);
        Integer userId=goods.getUserId();
        User cur_user=userService.selectByPrimaryKey(userId);
        int number = cur_user.getGoodsNum();
        Integer calelog_id = goods.getCatelogId();
        Catelog catelog = catelogService.selectByPrimaryKey(calelog_id);
        catelogService.updateCatelogNum(calelog_id,catelog.getNumber()-1);
        userService.updateGoodsNum(cur_user.getId(),number-1);
        cur_user.setGoodsNum(number-1);
        imageService.deleteImagesByGoodsPrimaryKey(goodId);
        goodsService.deleteGoodsByPrimaryKey(goodId);


    }
}