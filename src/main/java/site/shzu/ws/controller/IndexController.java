package site.shzu.ws.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import site.shzu.ws.model.Job;
import site.shzu.ws.model.Notice;
import site.shzu.ws.service.JobService;
import site.shzu.ws.service.NewsService;
import site.shzu.ws.service.NoticeService;
import site.shzu.ws.service.UserService;
import site.shzu.ws.vcode.Captcha;
import site.shzu.ws.vcode.GifCaptcha;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: Kinson
 * @Description: 控制类
 * @Date: Created in 2017/12/18 23:52
 * @Version: 1.0
 */

@Controller
@EnableAutoConfiguration
public class IndexController {
    @Autowired
    MessageSource messageSource;

    @Autowired
    UserService userService;

    @Autowired
    JobService jobService;

    @Autowired
    NoticeService noticeService;

    @Autowired
    NewsService newsService;

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping("/403")
    public String page403(){
        return "403";
    }

    @RequestMapping({"/index","/"})
    public ModelAndView index(){
        List<HashMap> jobList = jobService.getLast3Job();
        List<HashMap> noticeList = noticeService.getLast3Notice();
        List<HashMap> newsList = newsService.getLast3News();
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("jobList",jobList);
        modelAndView.addObject("noticeList",noticeList);
        modelAndView.addObject("newsList",newsList);
        return modelAndView;
    }

    /**
     * 请求招聘页面
     * @return
     */
    @RequestMapping("/jobList")
    public ModelAndView joblist(){
        List<HashMap> jobList = jobService.getCheckedJobListByStu(1,10,null);
        ModelAndView modelAndView = new ModelAndView("jobList");
        modelAndView.addObject("jobList",jobList);
        modelAndView.addObject("pages",new PageInfo(jobList).getPages());
        return modelAndView;
    }

    /**
     * 加载岗位列表
     * @param
     * @return
     */
    @RequestMapping(value = "/loadJobList", method= RequestMethod.POST)
    @ResponseBody
    public HashMap loadJobList(String pageSize,String pageNum){
        HashMap resultMap = new HashMap();
        try {
            List<HashMap> jobList = jobService.getCheckedJobListByStu(Integer.valueOf(pageNum),Integer.valueOf(pageSize),null);
            if(jobList!=null&&jobList.size()!=0){
                resultMap.put("status", "success");
                resultMap.put("jobList",jobList);
            }else{
                resultMap.put("status", "fail");
                resultMap.put("msg","已经到底了");
            }

        }catch (Exception e){
            resultMap.put("status", "fail");
            resultMap.put("msg","发生未知错误！");
        }
        return resultMap;
    }

    /**
     * 请求公告页面
     * @return
     */
    @RequestMapping("/noticeList")
    public ModelAndView noticelist(){
        List<HashMap> noticeList = noticeService.getNoticeListByStu(1,10,null);
        ModelAndView modelAndView = new ModelAndView("noticeList");
        modelAndView.addObject("noticeList",noticeList);
        modelAndView.addObject("pages",new PageInfo(noticeList).getPages());
        return modelAndView;
    }

    /**
     * 加载公告列表
     * @param
     * @return
     */
    @RequestMapping(value = "/loadNoticeList", method= RequestMethod.POST)
    @ResponseBody
    public HashMap loadNoticeList(String pageSize,String pageNum){
        HashMap resultMap = new HashMap();
        try {
            List<HashMap> noticeList = noticeService.getNoticeListByStu(Integer.valueOf(pageNum),Integer.valueOf(pageSize),null);
            if(noticeList!=null&&noticeList.size()!=0){
                resultMap.put("status", "success");
                resultMap.put("noticeList",noticeList);
            }else{
                resultMap.put("status", "fail");
                resultMap.put("msg","已经到底了");
            }

        }catch (Exception e){
            resultMap.put("status", "fail");
            resultMap.put("msg","发生未知错误！");
        }
        return resultMap;
    }

    /**
     * 请求公告页面
     * @return
     */
    @RequestMapping("/newsList")
    public ModelAndView newslist(){
        List<HashMap> newsList = newsService.getNewsListByStu(1,10,null);
        ModelAndView modelAndView = new ModelAndView("newsList");
        modelAndView.addObject("newsList",newsList);
        modelAndView.addObject("pages",new PageInfo(newsList).getPages());
        return modelAndView;
    }

    /**
     * 加载公告列表
     * @param
     * @return
     */
    @RequestMapping(value = "/loadNewsList", method= RequestMethod.POST)
    @ResponseBody
    public HashMap loadNewsList(String pageSize,String pageNum){
        HashMap resultMap = new HashMap();
        try {
            List<HashMap> newsList = newsService.getNewsListByStu(Integer.valueOf(pageNum),Integer.valueOf(pageSize),null);
            if(newsList!=null&&newsList.size()!=0){
                resultMap.put("status", "success");
                resultMap.put("newsList",newsList);
            }else{
                resultMap.put("status", "fail");
                resultMap.put("msg","已经到底了");
            }

        }catch (Exception e){
            resultMap.put("status", "fail");
            resultMap.put("msg","发生未知错误！");
        }
        return resultMap;
    }

    /**
     * 请求岗位详情页面
     * @return
     */
    @RequestMapping("/jobDetail")
    public ModelAndView jobDetail(Integer id){
        List<HashMap> job = jobService.getJobInfoById(id);
        ModelAndView modelAndView = new ModelAndView("jobDetail");
        modelAndView.addObject("job",job);
        return modelAndView;
    }

    /**
     * 请求公告详情页面
     * @return
     */
    @RequestMapping("/noticeDetail")
    public ModelAndView noticeDetail(Integer id){
        List<HashMap> notice = noticeService.getNoticeInfoById(id);
        ModelAndView modelAndView = new ModelAndView("noticeDetail");
        modelAndView.addObject("notice",notice);
        return modelAndView;
    }

    /**
     * 请求新闻详情页面
     * @return
     */
    @RequestMapping("/newsDetail")
    public ModelAndView newsDetail(Integer id){
        List<HashMap> news = newsService.getNewsInfoById(id);
        ModelAndView modelAndView = new ModelAndView("newsDetail");
        modelAndView.addObject("news",news);
        return modelAndView;
    }

    /**
     * 登录请求
     * @param userName
     * @param passWord
     * @return
     */
    @RequestMapping(value="/doLogin",method=RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> doLogin(String role,String userName, String passWord,String vcode,Boolean rememberMe,Model model) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        if(vcode==null||vcode==""){
            resultMap.put("status", 500);
            resultMap.put("message", "验证码不能为空！");
            return resultMap;
        }

        Session session = SecurityUtils.getSubject().getSession();
        //转化成小写字母
        vcode = vcode.toLowerCase();
        String v = (String) session.getAttribute("_code");
        if(!vcode.equals(v)){
            resultMap.put("status", 500);
            resultMap.put("message", "验证码错误！");
            return resultMap;
        }

        //判断是否存在对应的用户
        if("student".equals(role)){
            if(userService.checkIsExistUser(userName,role)==0){
                resultMap.put("status", 500);
                resultMap.put("message", "不存在该学生用户，请重试！");
                return resultMap;
            }
        }
        if("empDepSys".equals(role)){
            if(userService.checkIsExistUser(userName,role)==0){
                resultMap.put("status", 500);
                resultMap.put("message", "不存在该用人部门人员，请重试！");
                return resultMap;
            }
        }
        if("sys".equals(role)){
            if(userService.checkIsExistUser(userName,role)==0){
                resultMap.put("status", 500);
                resultMap.put("message", "不存在该系统管理员，请重试！");
                return resultMap;
            }
        }

        try {
            UsernamePasswordToken token = new UsernamePasswordToken(userName, passWord, rememberMe);
            SecurityUtils.getSubject().login(token);
            resultMap.put("status", 200);
            resultMap.put("message", "登录成功");
        } catch (Exception e) {
            resultMap.put("status", 500);
            resultMap.put("message", e.getMessage());
        }
        return resultMap;
    }

    //被踢出后跳转的页面
    @RequestMapping(value="kickout")
    public String kickout() {
        return "kickout";
    }

    /**
     * 获取验证码（Gif版本）
     */
    @RequestMapping(value="getGifCode",method=RequestMethod.GET)
    public void getGifCode(HttpServletResponse response, HttpServletRequest request){
        try {
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setContentType("image/gif");
            /**
             * gif格式动画验证码
             * 宽，高，位数。
             */
            Captcha captcha = new GifCaptcha(146,33,4);
            //输出
            captcha.out(response.getOutputStream());
            HttpSession session = request.getSession(true);
            //存入Session
            session.setAttribute("_code",captcha.text().toLowerCase());
        } catch (Exception e) {
            System.err.println("获取验证码异常："+e.getMessage());
        }
    }
}
