package com.ldu.service;

import com.ldu.pojo.User;

import java.io.InputStream;
import java.util.List;

public interface UserService {
    public void addUser(User user);
    public User getUserByPhone(String phone);
    public void updateUserName(User user);
    int updateGoodsNum(Integer id,Integer goodsNum);
    public void deleteUser(Integer id);
    User selectByPrimaryKey(Integer id);
    public List<User> getPageUser(int pageNum,int pageSize);
    public List<User> getUserList();
    public int getUserNum();
    InputStream getInputStream() throws Exception;
}