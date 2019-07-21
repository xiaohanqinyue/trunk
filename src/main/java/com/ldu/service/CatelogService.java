package com.ldu.service;

import com.ldu.pojo.Catelog;
import com.ldu.pojo.Goods;


import java.util.List;

/**
 * Created by David on 2018/11/9.
 */
public interface CatelogService {
    public void addCatelog(Catelog catelog);
    public List<Catelog> getAllCatelog();
    public int getAllCatelogs();
    public int getCount(Catelog catelog);
    public void deleteCatelog(Integer id);
    public List<Catelog> getPageCatelog(int pageNum, int pageSize);
    Catelog selectByPrimaryKey(Integer id);
    public Catelog selectByname(String name);
    int updateByPrimaryKey(Catelog record);
    int updateCatelogNum(Integer id,Integer number);
}
