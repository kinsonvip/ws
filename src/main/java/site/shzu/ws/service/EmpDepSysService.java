package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.EmpDepSysDao;
import site.shzu.ws.util.Pager;
import site.shzu.ws.util.PagerUtil;

import java.util.HashMap;
import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/04/26 15:33
 * @Version: 1.0
 */
@Service
public class EmpDepSysService {
    @Autowired
    EmpDepSysDao empDepSysDao;

    public HashMap getUncheckedEmpDepSysList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> uncheckedEmpDepSysList = empDepSysDao.getUncheckedEmpDepSysList(search);

        PageInfo page = new PageInfo(uncheckedEmpDepSysList);
        Pager pager = PagerUtil.getPager(page);

        if(uncheckedEmpDepSysList==null||uncheckedEmpDepSysList.size()==0){
            map.put("result","fail");
            map.put("data",uncheckedEmpDepSysList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",uncheckedEmpDepSysList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public void passEmpDepSys(String accountNum){
        empDepSysDao.passEmpDepSys(accountNum);
    }

    public void noPassEmpDepSys(String accountNum){
        empDepSysDao.noPassEmpDepSys(accountNum);
    }

    public HashMap getEmpDepSysList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> empDepSysList = empDepSysDao.getEmpDepSysList(search);

        PageInfo page = new PageInfo(empDepSysList);
        Pager pager = PagerUtil.getPager(page);

        if(empDepSysList==null||empDepSysList.size()==0){
            map.put("result","fail");
            map.put("data",empDepSysList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",empDepSysList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public void unlockDepSys(String accountNum){
        empDepSysDao.unlockDepSysByAccountNum(accountNum);
    }

    public void lockDepSys(String accountNum){
        empDepSysDao.lockDepSysByAccountNum(accountNum);
    }
}
