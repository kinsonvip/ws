package site.shzu.ws.controller;

import com.baidu.ueditor.ActionEnter;
import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static org.apache.shiro.web.filter.mgt.DefaultFilter.port;

/**
 * @Author: Kinson
 * @Description: 富文本编辑器的控制器
 * @Date: Created in 2018/05/05 20:20
 * @Version: 1.0
 */
@Controller
@RequestMapping("/ueditor")
public class UeditorController implements ServletContextAware {
    private String rootPath;

    @RequestMapping("/ueditorConfig")
    @ResponseBody
    public String ueditorConfig(HttpServletRequest request, HttpServletResponse response) {
        return new ActionEnter(request, rootPath, UeditorController.class.getClassLoader().getResource("config.json").getPath()).exec();

    }

    @RequestMapping(value = "/imgUpload")
    @ResponseBody
    public Map<String, Object> imgUpload(HttpServletRequest req) {
        Map<String, Object> rs = new HashMap<String, Object>();
        MultipartHttpServletRequest mReq = null;
        MultipartFile file = null;
        String fileName = "";
        // 原始文件名 UEDITOR创建页面元素时的alt和title属性
        String originalFileName = "";
        try {
            mReq = (MultipartHttpServletRequest) req;
            // 从config.json中取得上传文件的ID
            file = mReq.getFile("upfile");

            if (!file.isEmpty()) {
                // 取得文件的原始文件名称
                fileName = file.getOriginalFilename();

                String suffix = fileName.substring(fileName.lastIndexOf('.'));
                fileName = new SimpleDateFormat("yyyyMMddHHmmssSSS") .format(new Date() )+suffix;

                originalFileName = fileName;

                String ext = (FilenameUtils.getExtension(file.getOriginalFilename())).toLowerCase();
                String storePath = "";
                if ("jpg".equals(ext) || "png".equals(ext) || "jpeg".equals(ext) || "bmp".equals(ext)) {
                    storePath = "upload/image/"+new SimpleDateFormat("yyyy") .format(new Date())+"/"+new SimpleDateFormat("MM") .format(new Date() )+"/"+new SimpleDateFormat("dd") .format(new Date() ) +"/";
                } else {
                    storePath = "upload/video/"+new SimpleDateFormat("yyyy") .format(new Date())+"/"+new SimpleDateFormat("MM") .format(new Date() )+"/"+new SimpleDateFormat("dd") .format(new Date() ) +"/";
                }
                System.out.println(storePath + "----storePath");
                // 将图片和视频保存在本地服务器
                String pathRoot = req.getSession().getServletContext()
                        .getRealPath("");
                String path = pathRoot + "/" + storePath;
                System.out.println(pathRoot + "----pathRoot");
                File dest = new File(path + fileName);
                if (!dest.getParentFile().exists()) {
                    dest.getParentFile().mkdirs();
                }
                file.transferTo(dest);
                //String doMain = "http://127.0.0.1:"+port+"/";
                String doMain = req.getRequestURL().toString().replace(req.getServletPath(),"")+"/";
                String httpImgPath = doMain + storePath + fileName;

                rs.put("state", "SUCCESS");// UEDITOR的规则:不为SUCCESS则显示state的内容
                rs.put("url", httpImgPath); // 能访问到你现在图片的路径
                rs.put("title", originalFileName);
                rs.put("original", originalFileName);
            }

        } catch (Exception e) {
            e.printStackTrace();
            rs.put("state", "文件上传失败!"); // 在此处写上错误提示信息，这样当错误的时候就会显示此信息
            rs.put("url", "");
            rs.put("title", "");
            rs.put("original", "");
        }
        return rs;
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        rootPath = servletContext.getRealPath("/");
    }
}
