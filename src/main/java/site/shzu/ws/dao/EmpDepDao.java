package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import site.shzu.ws.model.EmpDep;

@Mapper
public interface EmpDepDao {
    int deleteByPrimaryKey(Integer id);

    int insert(EmpDep record);

    int insertSelective(EmpDep record);

    EmpDep selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(EmpDep record);

    int updateByPrimaryKey(EmpDep record);
}