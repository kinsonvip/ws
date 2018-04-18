package site.shzu.ws.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.RolePermissionDao;
import site.shzu.ws.model.User;

import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/04/08 13:48
 * @Version: 1.0
 */
@Service
public class RolePermissionService {
    @Autowired
    RolePermissionDao rolePermissionDao;

    public List<String> selectPermissionByUserId(User user){
        return rolePermissionDao.selectPermissionByUserId(user);
    }
}
