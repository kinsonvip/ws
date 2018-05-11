package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.StudentDao;
import site.shzu.ws.model.Student;
import site.shzu.ws.model.User;
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
        List<HashMap> stuList = studentDao.getStuList(search);

        PageInfo page = new PageInfo(stuList);
        Pager pager = PagerUtil.getPager(page);

        if(stuList==null||stuList.size()==0){
            map.put("result","fail");
            map.put("data",stuList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",stuList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public HashMap getStudentInfo(){
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        return studentDao.getStudentInfo(user.getAccountNum());
    }

    public void updateStudentByStuNum(Student student){
        studentDao.updateStudentByStuNum(student);
    }

    public void unlockStu(String stuNum){
        studentDao.unlockStuByStuNum(stuNum);
    }

    public void lockStu(String stuNum){
        studentDao.lockStuByStuNum(stuNum);
    }
}
