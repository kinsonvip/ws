package site.shzu.ws.controller;

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
import site.shzu.ws.service.UserService;
import site.shzu.ws.vcode.Captcha;
import site.shzu.ws.vcode.GifCaptcha;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
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

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping("/403")
    public String page403(){
        return "403";
    }

    @RequestMapping("/grid")
    public String grid(){
        return "grid";
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
