package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import site.shzu.ws.model.EmpDepSys;

@Mapper
public interface EmpDepSysDao {
    int deleteByPrimaryKey(Integer id);

    int insert(EmpDepSys record);

    int insertSelective(EmpDepSys record);

    EmpDepSys selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(EmpDepSys record);

    int updateByPrimaryKey(EmpDepSys record);
}