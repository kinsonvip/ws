package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.Student;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface StudentDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Student record);

    int insertSelective(Student record);

    Student selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Student record);

    int updateByPrimaryKey(Student record);

    List<HashMap> getStuList(@Param(value = "search") String search);

    void unlockStuByStuNum(@Param(value = "stuNum") String stuNum);

    void lockStuByStuNum(@Param(value = "stuNum") String stuNum);
}