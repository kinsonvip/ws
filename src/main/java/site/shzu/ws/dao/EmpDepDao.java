package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.EmpDep;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface EmpDepDao {
    int deleteByPrimaryKey(Integer id);

    int insert(EmpDep record);

    int insertSelective(EmpDep record);

    EmpDep selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(EmpDep record);

    int updateByPrimaryKey(EmpDep record);

    List<HashMap> getDepartmentList(@Param(value = "search") String search);

    List getDepList();

    Integer getEmpDepIdByDepName(@Param(value = "depName") String depName);
}