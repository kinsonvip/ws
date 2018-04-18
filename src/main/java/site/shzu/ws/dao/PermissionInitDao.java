package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import site.shzu.ws.model.PermissionInit;

import java.util.List;

@Mapper
public interface PermissionInitDao {
    int deleteByPrimaryKey(Integer id);

    int insert(PermissionInit record);

    int insertSelective(PermissionInit record);

    PermissionInit selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(PermissionInit record);

    int updateByPrimaryKey(PermissionInit record);

    List<PermissionInit> selectAllPermissionInit();
}