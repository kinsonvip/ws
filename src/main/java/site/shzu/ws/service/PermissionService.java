package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.PermissionDao;
import site.shzu.ws.model.Permission;
import site.shzu.ws.util.Pager;
import site.shzu.ws.util.PagerUtil;

import java.util.HashMap;
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

    public void addPermission(Permission permission){
        permissionDao.insertSelective(permission);
    }

    public void delPermissionById(Integer id){
        permissionDao.deleteByPrimaryKey(id);
    }

    public HashMap getPermissionList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> permissionList = permissionDao.getPermissionList(search);

        PageInfo page = new PageInfo(permissionList);
        Pager pager = PagerUtil.getPager(page);

        if(permissionList==null||permissionList.size()==0){
            map.put("result","fail");
            map.put("data",permissionList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",permissionList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }
}
