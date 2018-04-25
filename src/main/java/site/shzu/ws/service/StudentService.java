package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.StudentDao;
import site.shzu.ws.util.Pager;
import site.shzu.ws.util.PagerUtil;

import java.util.HashMap;
import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/04/23 20:10
 * @Version: 1.0
 */
@Service
public class StudentService {
    @Autowired
    StudentDao studentDao;

    public HashMap getStuList(int pageNum,int pageSize,String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> stulist = studentDao.getStuList(search);

        PageInfo page = new PageInfo(stulist);
        Pager pager = PagerUtil.getPager(page);

        if(stulist==null||stulist.size()==0){
            map.put("result","fail");
            map.put("data",stulist);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",stulist);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public void unlockStu(String stuNum){
        studentDao.unlockStuByStuNum(stuNum);
    }

    public void lockStu(String stuNum){
        studentDao.lockStuByStuNum(stuNum);
    }
}
