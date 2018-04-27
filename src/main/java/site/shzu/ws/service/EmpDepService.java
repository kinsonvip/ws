package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.EmpDepDao;
import site.shzu.ws.model.EmpDep;
import site.shzu.ws.util.Pager;
import site.shzu.ws.util.PagerUtil;

import java.util.HashMap;
import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/04/26 20:07
 * @Version: 1.0
 */
@Service
public class EmpDepService {
    @Autowired
    EmpDepDao empDepDao;

    public HashMap getDepartmentList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> departmentList = empDepDao.getDepartmentList(search);

        PageInfo page = new PageInfo(departmentList);
        Pager pager = PagerUtil.getPager(page);

        if(departmentList==null||departmentList.size()==0){
            map.put("result","fail");
            map.put("data",departmentList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",departmentList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public void updateDepSys(EmpDep empDep){
        empDepDao.updateByPrimaryKey(empDep);
    }

    public void delDepSysById(Integer id){
        empDepDao.deleteByPrimaryKey(id);
    }

    public void addDepSys(EmpDep empDep){
        empDepDao.insertSelective(empDep);
    }
}
