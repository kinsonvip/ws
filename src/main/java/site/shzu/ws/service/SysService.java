package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.SysDao;
import site.shzu.ws.model.Sys;
import site.shzu.ws.model.User;
import site.shzu.ws.util.Pager;
import site.shzu.ws.util.PagerUtil;

import java.util.HashMap;
import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/05/13 11:35
 * @Version: 1.0
 */
@Service
public class SysService {
    @Autowired
    SysDao sysDao;

    public HashMap getAdminInfo(){
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        return sysDao.getAdminInfo(user.getAccountNum());
    }

    public void updateByAccountNum(Sys sys){
        sysDao.updateByAccountNum(sys);
    }

    public HashMap getAdminList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> adminList = sysDao.getAdminList(search);

        PageInfo page = new PageInfo(adminList);
        Pager pager = PagerUtil.getPager(page);

        if(adminList==null||adminList.size()==0){
            map.put("result","fail");
            map.put("data",adminList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",adminList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public void add(Sys sys){
        sysDao.insertSelective(sys);
    }
}
