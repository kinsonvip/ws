package site.shzu.ws.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import site.shzu.ws.model.*;
import site.shzu.ws.service.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/04/23 17:21
 * @Version: 1.0
 */

@Controller
@EnableAutoConfiguration
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    StudentService studentService;

    @Autowired
    EmpDepSysService empDepSysService;

    @Autowired
    EmpDepService empDepService;

    @Autowired
    JobService jobService;

    @Autowired
    JobContractService jobContractService;

    @Autowired
    NewsService newsService;

    @Autowired
    NoticeService noticeService;

    @Autowired
    SysService sysService;

    @Autowired
    UserService userService;

    @Autowired
    UserRoleService userRoleService;

    @Autowired
    PermissionService permissionService;

    /**
     * 请求管理员后台首页
     * @return
     */
    @RequestMapping("/index")
    public String index(){
        return "admin/index";
    }

    /**
     * 欢迎页
     * @return
     */
    @RequestMapping("/welcome")
    public String welcome(){
        return "admin/welcome";
    }

    /**
     * 请求学生管理页面
     * @return
     */
    @RequestMapping("/studentManage")
    public String studentManage(){
        return "admin/studentManage";
    }

    /**
     * 请求学生管理列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/stuList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap stuList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return studentService.getStuList(pageNum,pageSize,search);
    }

    /**
     * 解锁学生操作
     * @param stuNum
     * @return
     */
    @RequestMapping(value = "/unlockStu", method= RequestMethod.POST)
    @ResponseBody
    public HashMap unlockStu(String stuNum){
        HashMap resultMap = new HashMap();
        try {
            studentService.unlockStu(stuNum);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 锁定学生操作
     * @param stuNum
     * @return
     */
    @RequestMapping(value = "/lockStu", method= RequestMethod.POST)
    @ResponseBody
    public HashMap lockStu(String stuNum){
        HashMap resultMap = new HashMap();
        try {
            studentService.lockStu(stuNum);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求待审核部门管理人员列表页面
     * @return
     */
    @RequestMapping("/uncheckedDepSysManage")
    public String uncheckedDepSysManage(){
        return "admin/uncheckedDepSysManage";
    }

    /**
     * 请求待审核部门管理人员列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/uncheckedDepSysList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap uncheckedDepSysList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return empDepSysService.getUncheckedEmpDepSysList(pageNum,pageSize,search);
    }

    /**
     * 通过用人部门人员审核
     * @param accountNum
     * @return
     */
    @RequestMapping(value = "/passEmpDepSys", method= RequestMethod.POST)
    @ResponseBody
    public HashMap passEmpDepSys(String accountNum){
        HashMap resultMap = new HashMap();
        try {
            empDepSysService.passEmpDepSys(accountNum);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 不通过用人部门人员审核
     * @param accountNum
     * @return
     */
    @RequestMapping(value = "/noPassEmpDepSys", method= RequestMethod.POST)
    @ResponseBody
    public HashMap noPassEmpDepSys(String accountNum){
        HashMap resultMap = new HashMap();
        try {
            empDepSysService.noPassEmpDepSys(accountNum);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求部门管理人员管理页面
     * @return
     */
    @RequestMapping("/departmentSysManage")
    public String departmentSysManage(){
        return "admin/departmentSysManage";
    }

    /**
     * 请求部门管理人员列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/depSysList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap depSysList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return empDepSysService.getEmpDepSysList(pageNum,pageSize,search);
    }

    /**
     * 解锁用人部门人员操作
     * @param accountNum
     * @return
     */
    @RequestMapping(value = "/unlockDepSys", method= RequestMethod.POST)
    @ResponseBody
    public HashMap unlockDepSys(String accountNum){
        HashMap resultMap = new HashMap();
        try {
            empDepSysService.unlockDepSys(accountNum);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 锁定用人部门人员操作
     * @param accountNum
     * @return
     */
    @RequestMapping(value = "/lockDepSys", method= RequestMethod.POST)
    @ResponseBody
    public HashMap lockDepSys(String accountNum){
        HashMap resultMap = new HashMap();
        try {
            empDepSysService.lockDepSys(accountNum);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求部门管理页面
     * @return
     */
    @RequestMapping("/departmentManage")
    public String departmentManage(){
        return "admin/departmentManage";
    }

    /**
     * 请求部门列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/departmentList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap departmentList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return empDepService.getDepartmentList(pageNum,pageSize,search);
    }

    /**
     * 修改用人部门信息
     * @param
     * @return
     */
    @RequestMapping(value = "/editDepartment", method= RequestMethod.POST)
    @ResponseBody
    public HashMap editDepartment(EmpDep empDep){
        HashMap resultMap = new HashMap();
        try {
            empDepService.updateDepSys(empDep);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 删除用人部门信息
     * @param
     * @return
     */
    @RequestMapping(value = "/delDepartment", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delDepartment(Integer id){
        HashMap resultMap = new HashMap();
        try {
            empDepService.delDepSysById(id);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 修改用人部门信息
     * @param
     * @return
     */
    @RequestMapping(value = "/addDepartment", method= RequestMethod.POST)
    @ResponseBody
    public HashMap addDepartment(EmpDep empDep){
        HashMap resultMap = new HashMap();
        try {
            empDepService.addDepSys(empDep);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求待审核岗位管理页面
     * @return
     */
    @RequestMapping("/uncheckedJob")
    public String uncheckedJob(){
        return "admin/uncheckedJob";
    }

    /**
     * 请求未审核的岗位列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/uncheckedJobList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap uncheckedJobList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return jobService.getUncheckedJobList(pageNum,pageSize,search);
    }

    /**
     * 通过用人部门创立的岗位审核
     * @param jobId
     * @return
     */
    @RequestMapping(value = "/passJob", method= RequestMethod.POST)
    @ResponseBody
    public HashMap passJob(Integer jobId){
        HashMap resultMap = new HashMap();
        try {
            jobService.passJob(jobId);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 不通过用人部门创立的岗位审核
     * @param jobId
     * @return
     */
    @RequestMapping(value = "/noPassJob", method= RequestMethod.POST)
    @ResponseBody
    public HashMap noPassJob(Integer jobId){
        HashMap resultMap = new HashMap();
        try {
            jobService.noPassJob(jobId);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 批量通过用人部门创立的岗位审核
     * @param jobIdArr
     * @return
     */
    @RequestMapping(value = "/passSomeJob", method= RequestMethod.POST)
    @ResponseBody
    public HashMap passSomeJob(Integer[] jobIdArr){
        HashMap resultMap = new HashMap();
        try {
            jobService.passSomeJob(jobIdArr);
            resultMap.put("status", "success");
        }catch (Exception e){
            System.out.println(e.getMessage());
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 批量拒绝用人部门创立的岗位审核
     * @param jobIdArr
     * @return
     */
    @RequestMapping(value = "/noPassSomeJob", method= RequestMethod.POST)
    @ResponseBody
    public HashMap noPassSomeJob(Integer[] jobIdArr){
        HashMap resultMap = new HashMap();
        try {
            jobService.noPassSomeJob(jobIdArr);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求通过审核的岗位管理页面
     * @return
     */
    @RequestMapping("/checkedJob")
    public String checkedJob(){
        return "admin/checkedJob";
    }

    /**
     * 请求审核通过的岗位列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/checkedJobList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap checkedJobList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return jobService.getCheckedJobList(pageNum,pageSize,search);
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
     * 请求待审核的学生申请岗位合同页面
     * @return
     */
    @RequestMapping("/uncheckedContract")
    public String uncheckedContract(){
        return "admin/uncheckedContract";
    }

    /**
     * 请求待审核的学生申请岗位合同列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/uncheckedContractList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap uncheckedContractList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return jobContractService.getUncheckedContractList(pageNum,pageSize,search);
    }

    /**
     * 通过用该合同审核
     * @param jobContractId
     * @return
     */
    @RequestMapping(value = "/passContract", method= RequestMethod.POST)
    @ResponseBody
    public HashMap passContract(Integer jobContractId){
        HashMap resultMap = new HashMap();
        try {
            jobContractService.passContract(jobContractId);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 不通过用该合同审核
     * @param jobContract
     * @return
     */
    @RequestMapping(value = "/noPassContract", method= RequestMethod.POST)
    @ResponseBody
    public HashMap noPassContract(JobContract jobContract){
        HashMap resultMap = new HashMap();
        try {
            jobContractService.noPassContract(jobContract);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求待已通过审核的学生申请岗位合同页面
     * @return
     */
    @RequestMapping("/checkedContract")
    public String checkedContract(){
        return "admin/checkedContract";
    }

    /**
     * 请求待审核的学生申请岗位合同列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/checkedContractList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap checkedContractList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return jobContractService.getCheckedContractList(pageNum,pageSize,search);
    }

    /**
     * 删除合同
     * @param jobContractId
     * @return
     */
    @RequestMapping(value = "/delContract", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delContract(Integer jobContractId){
        HashMap resultMap = new HashMap();
        try {
            jobContractService.delContract(jobContractId);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求新闻管理页面
     * @return
     */
    @RequestMapping("/newsManage")
    public String newsManage(){
        return "admin/newsManage";
    }

    /**
     * 请求新闻列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/newsList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap newsList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return newsService.getNewsList(pageNum,pageSize,search);
    }

    /**
     * 删除新闻
     * @param newsId
     * @return
     */
    @RequestMapping(value = "/delNews", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delNews(Integer newsId){
        HashMap resultMap = new HashMap();
        try {
            newsService.delNewsById(newsId);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 批量删除新闻
     * @param newsIdArr
     * @return
     */
    @RequestMapping(value = "/delSomeNews", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delSomeNews(Integer[] newsIdArr){
        HashMap resultMap = new HashMap();
        try {
            newsService.delSomeNews(newsIdArr);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 添加新闻
     * @param news
     * @return
     */
    @RequestMapping(value = "/addNews", method= RequestMethod.POST)
    @ResponseBody
    public HashMap addNews(News news){
        HashMap resultMap = new HashMap();
        try {
            newsService.addNews(news);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求公告管理页面
     * @return
     */
    @RequestMapping("/noticeManage")
    public String noticeManage(){
        return "admin/noticeManage";
    }

    /**
     * 请求公告列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/noticeList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap noticeList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return noticeService.getNoticeList(pageNum,pageSize,search);
    }

    /**
     * 删除公告
     * @param noticeId
     * @return
     */
    @RequestMapping(value = "/delNotice", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delNotice(Integer noticeId){
        HashMap resultMap = new HashMap();
        try {
            noticeService.delNoticeById(noticeId);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 批量删除公告
     * @param noticeIdArr
     * @return
     */
    @RequestMapping(value = "/delSomeNotice", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delSomeNotice(Integer[] noticeIdArr){
        HashMap resultMap = new HashMap();
        try {
            noticeService.delSomeNotice(noticeIdArr);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 添加公告
     * @param notice
     * @return
     */
    @RequestMapping(value = "/addNotice", method= RequestMethod.POST)
    @ResponseBody
    public HashMap addNotice(Notice notice){
        HashMap resultMap = new HashMap();
        try {
            noticeService.addNotice(notice);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求已评价合同管理页面
     * @return
     */
    @RequestMapping("/allEvaluatedContract")
    public String allEvaluatedContract(){
        return "admin/allEvaluatedContract";
    }

    /**
     * 请求待评价合同列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/allEvaluatedContractList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap evaluatedContractList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return jobContractService.getAllEvaluatedContractList(pageNum,pageSize,search);
    }

    /**
     * 请求管理员个人信息页面
     * @return
     */
    @RequestMapping("/personalInfo")
    public ModelAndView personalInfo(){
        HashMap  adminInfo= sysService.getAdminInfo();
        ModelAndView modelAndView = new ModelAndView("admin/personalInfo");
        modelAndView.addObject("adminInfo",adminInfo);
        return modelAndView;
    }

    /**
     * 修改个人信息
     * @param
     * @return
     */
    @RequestMapping(value = "/updateAdmin", method= RequestMethod.POST)
    @ResponseBody
    public HashMap updateStudent(Sys sys, String nickName){
        HashMap resultMap = new HashMap();
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        String accountNum  = user.getAccountNum();
        try {
            if(nickName!=null){
                userService.updateNickNameByAccountNum(user.getAccountNum(),nickName);
            }
            sys.setAccountNum(user.getAccountNum());
            sysService.updateByAccountNum(sys);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
        }
        return resultMap;
    }

    /**
     * 请求修改密码页面
     * @return
     */
    @RequestMapping("/updatePass")
    public String updatePass(){
        return "admin/updatePass";
    }

    /**
     * 修改密码
     * @param
     * @return
     */
    @RequestMapping(value = "/updatePassword", method= RequestMethod.POST)
    @ResponseBody
    public HashMap updatePassword(String oldPassword, String newPassword){
        HashMap resultMap = new HashMap();
        User user = (User)SecurityUtils.getSubject().getPrincipal();
        String oldMd5Pswd = new Md5Hash(oldPassword, user.getAccountNum(), 2).toString();
        user.setPassword(oldMd5Pswd);
        try {
            List<User> userList = userService.selectByUser(user);
            if(userList.size()==0){
                resultMap.put("status", "fail");
                resultMap.put("msg","原密码输入错误！！");
            }else {
                String newMd5Pswd = new Md5Hash(newPassword, user.getAccountNum(), 2).toString();
                user.setPassword(newMd5Pswd);
                userService.updatePassword(user);
                SecurityUtils.getSubject().logout();
                resultMap.put("status", "success");
            }
        }catch (Exception e){
            resultMap.put("status", "fail");
            resultMap.put("msg","操作失败！！");
        }
        return resultMap;
    }

    /**
     * 请求管理员管理页面
     * @return
     */
    @RequestMapping("/adminManage")
    public String adminManage(){
        return "admin/adminManage";
    }

    /**
     * 请求管理员列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/adminList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap adminList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return sysService.getAdminList(pageNum,pageSize,search);
    }

    /**
     * 添加管理员
     * @param
     * @return
     */
    @RequestMapping(value = "/addAdmin", method= RequestMethod.POST)
    @ResponseBody
    @Transactional
    public HashMap addAdmin(String account, Sys sys,User user){
        HashMap resultMap = new HashMap();
        user.setAccountNum(account);
        try {
            int num = userService.checkIsExistAccountNum(user);
            if(num!=0){
                resultMap.put("status", "fail");
                resultMap.put("msg","该账号已经存在，请重新输入");
            }else {
                String md5Pswd = new Md5Hash(user.getPassword(), account, 2).toString();
                user.setPassword(md5Pswd);
                user.setNickName(account);
                user.setCreateTime(new Date());
                user.setStatus("1");
                userService.addUser(user);
                userRoleService.addAdmin(user);
                sys.setAccountNum(account);
                sysService.add(sys);
                resultMap.put("status", "success");
            }
        }catch (Exception e){
            resultMap.put("status", "fail");
            resultMap.put("msg","操作失败！！");
        }
        return resultMap;
    }

    /**
     * 删除管理员
     * @param
     * @return
     */
    @RequestMapping(value = "/delAdmin", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delAdmin(User user){
        HashMap resultMap = new HashMap();
        try {
            userService.delUser(user);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
            resultMap.put("msg","操作失败！！");
        }
        return resultMap;
    }

    /**
     * 请求权限管理页面
     * @return
     */
    @RequestMapping("/permission")
    public String permission(){
        return "admin/permission";
    }

    /**
     * 请求权限列表数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/permissionList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap permissionList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return permissionService.getPermissionList(pageNum,pageSize,search);
    }

    /**
     * 添加权限
     * @param
     * @return
     */
    @RequestMapping(value = "/addPermission", method= RequestMethod.POST)
    @ResponseBody
    @Transactional
    public HashMap addPermission(Permission permission){
        HashMap resultMap = new HashMap();
        try {
            permissionService.addPermission(permission);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
            resultMap.put("msg","操作失败！！");
        }
        return resultMap;
    }

    /**
     * 删除权限
     * @param
     * @return
     */
    @RequestMapping(value = "/delPermission", method= RequestMethod.POST)
    @ResponseBody
    public HashMap delPermission(Integer id){
        HashMap resultMap = new HashMap();
        try {
            permissionService.delPermissionById(id);
            resultMap.put("status", "success");
        }catch (Exception e){
            resultMap.put("status", "fail");
            resultMap.put("msg","操作失败！！");
        }
        return resultMap;
    }
}
