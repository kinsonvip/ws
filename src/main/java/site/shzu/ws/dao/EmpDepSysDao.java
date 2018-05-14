package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.EmpDepSys;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface EmpDepSysDao {
    int deleteByPrimaryKey(Integer id);

    int insert(EmpDepSys record);

    int insertSelective(EmpDepSys record);

    EmpDepSys selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(EmpDepSys record);

    int updateByPrimaryKey(EmpDepSys record);

    List<HashMap> getUncheckedEmpDepSysList(@Param(value = "search") String search);

    List<HashMap> getEmpDepSysList(@Param(value = "search") String search);

    void passEmpDepSys(@Param(value = "accountNum") String accountNum);

    void addDepSys(EmpDepSys empDepSys);

    void noPassEmpDepSys(@Param(value = "accountNum") String accountNum);

    void unlockDepSysByAccountNum(@Param(value = "accountNum") String accountNum);

    void lockDepSysByAccountNum(@Param(value = "accountNum") String accountNum);

    Integer getDepIdByAccountNum(@Param(value = "accountNum") String accountNum);

    HashMap getDepsysInfo(@Param(value = "accountNum") String accountNum);

    int updateByAccountNum(EmpDepSys empDepSys);
}