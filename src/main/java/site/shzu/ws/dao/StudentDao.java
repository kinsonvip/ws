package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import site.shzu.ws.model.Student;

@Mapper
public interface StudentDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Student record);

    int insertSelective(Student record);

    Student selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Student record);

    int updateByPrimaryKey(Student record);
}