package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import site.shzu.ws.model.Sys;

@Mapper
public interface SysDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Sys record);

    int insertSelective(Sys record);

    Sys selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Sys record);

    int updateByPrimaryKey(Sys record);
}