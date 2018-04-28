package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.JobContractDao;
import site.shzu.ws.model.JobContract;
import site.shzu.ws.model.User;
import site.shzu.ws.util.Pager;
import site.shzu.ws.util.PagerUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/04/29 0:16
 * @Version: 1.0
 */
@Service
public class JobContractService {
    @Autowired
    JobContractDao jobContractDao;

    public HashMap getUncheckedContractList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> checkedContractList = jobContractDao.getUncheckedContractList(search);

        PageInfo page = new PageInfo(checkedContractList);
        Pager pager = PagerUtil.getPager(page);

        if(checkedContractList==null||checkedContractList.size()==0){
            map.put("result","fail");
            map.put("data",checkedContractList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",checkedContractList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public HashMap getCheckedContractList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> checkedContractList = jobContractDao.getCheckedContractList(search);

        PageInfo page = new PageInfo(checkedContractList);
        Pager pager = PagerUtil.getPager(page);

        if(checkedContractList==null||checkedContractList.size()==0){
            map.put("result","fail");
            map.put("data",checkedContractList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",checkedContractList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public void passContract(Integer jobContractId){
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        JobContract jobContract = new JobContract();
        jobContract.setId(jobContractId);
        jobContract.setStatus("1");
        jobContract.setVerifyUser(user.getAccountNum());
        jobContract.setVerifyTime(new Date());
        jobContractDao.updateByPrimaryKeySelective(jobContract);
    }

    public void noPassContract(JobContract jobContract){
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        jobContract.setStatus("-1");
        jobContract.setVerifyUser(user.getAccountNum());
        jobContract.setVerifyTime(new Date());
        jobContractDao.updateByPrimaryKeySelective(jobContract);
    }

    public void delContract(Integer jobContractId){
        jobContractDao.deleteByPrimaryKey(jobContractId);
    }
}
