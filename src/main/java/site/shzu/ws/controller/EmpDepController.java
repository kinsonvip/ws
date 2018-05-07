package site.shzu.ws.controller;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import site.shzu.ws.model.Job;
import site.shzu.ws.model.User;
import site.shzu.ws.service.EmpDepSysService;
import site.shzu.ws.service.JobService;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/05/06 17:21
 * @Version: 1.0
 */
@Controller
@EnableAutoConfiguration
@RequestMapping("/depsys")
public class EmpDepController {
    @Autowired
    JobService jobService;

    @Autowired
    EmpDepSysService empDepSysService;

    /**
     * 请求管理员后台首页
     * @return
     */
    @RequestMapping("/index")
    public String index(){
        return "depsys/index";
    }

    /**
     * 欢迎页
     * @return
     */
    @RequestMapping("/welcome")
    public String welcome(){
        return "depsys/welcome";
    }

    /**
     * 请求审核中的岗位管理页面
     * @return
     */
    @RequestMapping("/uncheckedJob")
    public String uncheckedJob(){
        return "depsys/uncheckedJob";
    }

    /**
     * 请求审核中的岗位列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/uncheckedJobList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap uncheckedJobList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return jobService.getUncheckedJobListByDep(pageNum,pageSize,search);
    }

    /**
     * 删除岗位
     * @param jobId
     * @return
     */
    @RequestMapping(value = "/delJob", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delJob(Integer jobId){
        HashMap resultMap = new HashMap();
        try {
            jobService.delJob(jobId);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 批量删除岗位
     * @param jobIdArr
     * @return
     */
    @RequestMapping(value = "/delSomeJob", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delSomeJob(Integer[] jobIdArr){
        HashMap resultMap = new HashMap();
        try {
            jobService.delSomeJob(jobIdArr);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 发布岗位
     * @param job
     * @return
     */
    @RequestMapping(value = "/addJob", method= RequestMethod.POST)
    @ResponseBody
    public HashMap addJob(Job job,String time){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        HashMap resultMap = new HashMap();
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        String accountNum  = user.getAccountNum();
        try {
            Date date = sdf.parse(time);
            job.setEndTime(date);
            job.setCreateTime(new Date());
            job.setCreateUser(accountNum);
            job.setEmpDepId(empDepSysService.getDepIdByAccountNum(accountNum));
            job.setAcceptNum(0);
            job.setStatus("0");
            jobService.addJob(job);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 修改岗位
     * @param job
     * @return
     */
    @RequestMapping(value = "/updateJob", method= RequestMethod.POST)
    @ResponseBody
    public HashMap updateJob(Job job,String time){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        HashMap resultMap = new HashMap();
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        String accountNum  = user.getAccountNum();
        try {
            Date date = sdf.parse(time);
            job.setEndTime(date);
            job.setUpdateTime(new Date());
            job.setUpdateUser(accountNum);
            jobService.updateJob(job);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求已审核的岗位管理页面
     * @return
     */
    @RequestMapping("/checkedJob")
    public String checkedJob(){
        return "depsys/checkedJob";
    }

    /**
     * 请求已审核的岗位列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/checkedJobList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap checkedJobList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return jobService.getCheckedJobListByDep(pageNum,pageSize,search);
    }
}
