package site.shzu.ws.service;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.EvaluateDao;
import site.shzu.ws.dao.JobContractDao;
import site.shzu.ws.model.Evaluate;
import site.shzu.ws.model.JobContract;
import site.shzu.ws.model.User;

import java.util.Date;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/05/08 22:36
 * @Version: 1.0
 */
@Service
public class EvaluateService {
    @Autowired
    EvaluateDao evaluateDao;

    @Autowired
    JobContractDao jobContractDao;

    public void evalContract(Evaluate evaluate){
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        evaluate.setEvaluater(user.getAccountNum());
        evaluate.setEvaluateTime(new Date());
        evaluateDao.insertSelective(evaluate);
        JobContract jobContract = new JobContract();
        jobContract.setId(evaluate.getJobContractId());
        jobContract.setStatus("3");
        jobContractDao.updateByPrimaryKeySelective(jobContract);
    }
}
