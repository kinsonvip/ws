package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.News;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface NewsDao {
    int deleteByPrimaryKey(Integer id);

    int insert(News record);

    int insertSelective(News record);

    News selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(News record);

    int updateByPrimaryKeyWithBLOBs(News record);

    int updateByPrimaryKey(News record);

    List<HashMap> getNewsList(@Param(value = "search") String search);

    void delSomeNews(@Param(value = "newsIdArr") Integer[] newsIdArr);
}