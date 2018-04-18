package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import site.shzu.ws.model.Role;

@Mapper
public interface RoleDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
}