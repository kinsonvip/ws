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

    public HashMap getStuList(int pageNum,int pageSize){
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> stulist = studentDao.getStuList();

        PageInfo page = new PageInfo(stulist);
        Pager pager = PagerUtil.getPager(page);

        HashMap<Object,Object> map = new HashMap<>();
        map.put("result","success");
        map.put("data",stulist);
        map.put("message","发生错误了！！");
        map.put("pager",pager);

        return map;
    }

}
