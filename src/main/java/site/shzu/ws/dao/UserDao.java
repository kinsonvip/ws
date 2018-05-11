package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.User;

import java.util.List;

@Mapper
public interface UserDao {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    List<User> selectByUser (User user);

    int checkIsExistUser(@Param(value = "userName") String userName,@Param(value = "role") String role);

    void updateNickNameByAccountNum(@Param(value = "accountNum") String accountNum,@Param(value = "nickName") String nickName);

    void updatePassword(User user);
}