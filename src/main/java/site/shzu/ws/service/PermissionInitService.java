package site.shzu.ws.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.PermissionInitDao;
import site.shzu.ws.model.PermissionInit;

import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/04/08 13:31
 * @Version: 1.0
 */
@Service
public class PermissionInitService {
    @Autowired
    PermissionInitDao permissionInitDao;

    public List<PermissionInit> selectAllPermissionInit(){
        return permissionInitDao.selectAllPermissionInit();
    }
}
