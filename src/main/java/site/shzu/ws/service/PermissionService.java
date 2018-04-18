package site.shzu.ws.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.PermissionDao;
import site.shzu.ws.model.Permission;

import java.util.List;

/**
 * @Author: Kinson
 * @Description: Permission的Service类
 * @Date: Created in 2018/04/07 20:49
 * @Version: 1.0
 */
@Service
public class PermissionService {
    @Autowired
    PermissionDao permissionDao;

    public List<Permission> selectAllPermission(){
        return permissionDao.selectAllPermission();
    }
}
