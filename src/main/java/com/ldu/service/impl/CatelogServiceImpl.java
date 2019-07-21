package com.ldu.service.impl;

import com.github.pagehelper.PageHelper;
import com.ldu.dao.CatelogMapper;
import com.ldu.pojo.Catelog;
import com.ldu.pojo.User;
import com.ldu.service.CatelogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by David on 2018/11/9.
 */
@Service("catelogService")
public class CatelogServiceImpl implements CatelogService {

    @Resource
    private CatelogMapper catelogMapper;

    public void addCatelog(Catelog catelog) {
        catelogMapper.insert(catelog);
    }
    public int getCount(Catelog catelog) {
        int count = catelogMapper.getCount(catelog);
        return count;
    }
    public List<Catelog> getAllCatelog() {
        List<Catelog> catelogs = catelogMapper.getAllCatelog();
        return catelogs;

    }

    public Catelog selectByname(String name){
        Catelog catelog=catelogMapper.selectByname(name);
        return catelog;
    }

    public void deleteCatelog(Integer id){
        catelogMapper.deleteByPrimaryKey(id);
    }

    public int getAllCatelogs() {
        List<Catelog> catelogs = catelogMapper.getAllCatelog();
        return catelogs.size();
    }

    //获取出当前页用户   pageNum：第几页    pageSize：每页的个数
    public List<Catelog> getPageCatelog(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum,pageSize);//分页核心代码
        List<Catelog> data= catelogMapper.getAllCatelog();
        return data;
    }

    public Catelog selectByPrimaryKey(Integer id){
        Catelog catelog = catelogMapper.selectByPrimaryKey(id);
        return catelog;
    }
    public int updateByPrimaryKey(Catelog catelog) {
        return  catelogMapper.updateByPrimaryKey(catelog);
    }
    public int updateCatelogNum(Integer id,Integer number) {
        return catelogMapper.updateCatelogNum(id,number);
    }
}
