package site.shzu.ws.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.UserDao;
import site.shzu.ws.model.User;

import java.util.List;

/**
 * @Author: Kinson
 * @Description: User的Service类
 * @Date: Created in 2018/03/28 15:45
 * @Version: 1.0
 */
@Service
public class UserService {
    @Autowired
    UserDao userDao;

    public List<User> selectByUser(User user) {
        return userDao.selectByUser(user);
    }

    public void updateById(User user){
        userDao.updateByPrimaryKey(user);
    }

    public int checkIsExistUser(String userName,String role){
        return userDao.checkIsExistUser(userName,role);
    }

    public int checkIsExistAccountNum(User user){
        return userDao.checkIsExistAccountNum(user);
    }

    public void updateNickNameByAccountNum(String accountNum,String nickName){
        userDao.updateNickNameByAccountNum(accountNum,nickName);
    }

    public void updatePassword(User user){
        userDao.updatePassword(user);
    }

    public void addUser(User user){
        userDao.insertSelective(user);
    }

    public void delUser(User user){
        userDao.deleteByPrimaryKey(user.getId());
    }
}
