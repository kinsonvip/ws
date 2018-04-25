package site.shzu.ws.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import site.shzu.ws.service.StudentService;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

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

    @RequestMapping("/index")
    public String index(){
        return "admin/index";
    }

    @RequestMapping("/welcome")
    public String welcome(){
        return "admin/welcome";
    }

    @RequestMapping("/studentManage")
    public String studentManage(){
        return "admin/studentManage";
    }

    @RequestMapping(value = "/stuList", method= RequestMethod.GET)
    @ResponseBody
    public HashMap stuList(HttpServletRequest request){
        int pageNum = Integer.valueOf(request.getParameter("page"));
        int pageSize = Integer.valueOf(request.getParameter("recPerPage"));
        String search = request.getParameter("search");
        return studentService.getStuList(pageNum,pageSize,search);
    }

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

}
