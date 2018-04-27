package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.JobDao;
import site.shzu.ws.util.Pager;
import site.shzu.ws.util.PagerUtil;

import java.util.HashMap;
import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/04/27 11:46
 * @Version: 1.0
 */
@Service
public class JobService {
    @Autowired
    JobDao jobDao;

    public HashMap getUncheckedJobList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> uncheckedJobList = jobDao.getUncheckedJobList(search);

        PageInfo page = new PageInfo(uncheckedJobList);
        Pager pager = PagerUtil.getPager(page);

        if(uncheckedJobList==null||uncheckedJobList.size()==0){
            map.put("result","fail");
            map.put("data",uncheckedJobList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",uncheckedJobList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public HashMap getCheckedJobList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> checkedJobList = jobDao.getCheckedJobList(search);

        PageInfo page = new PageInfo(checkedJobList);
        Pager pager = PagerUtil.getPager(page);

        if(checkedJobList==null||checkedJobList.size()==0){
            map.put("result","fail");
            map.put("data",checkedJobList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",checkedJobList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public void delJob(Integer jobId){
        jobDao.deleteByPrimaryKey(jobId);
    }

    public void passJob(Integer jobId){
        jobDao.passJob(jobId);
    }

    public void noPassJob(Integer jobId){
        jobDao.noPassJob(jobId);
    }
}
