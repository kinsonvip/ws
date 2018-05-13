package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.Sys;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface SysDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Sys record);

    int insertSelective(Sys record);

    Sys selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Sys record);

    int updateByPrimaryKey(Sys record);

    HashMap getAdminInfo(@Param(value = "accountNum") String accountNum);

    int updateByAccountNum(Sys sys);

    List<HashMap> getAdminList(@Param(value = "search") String search);
}