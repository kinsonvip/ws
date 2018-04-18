package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import site.shzu.ws.model.Major;

@Mapper
public interface MajorDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Major record);

    int insertSelective(Major record);

    Major selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Major record);

    int updateByPrimaryKey(Major record);
}