package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.NoticeDao;
import site.shzu.ws.model.Notice;
import site.shzu.ws.model.User;
import site.shzu.ws.util.Pager;
import site.shzu.ws.util.PagerUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/05/06 15:28
 * @Version: 1.0
 */
@Service
public class NoticeService {
    @Autowired
    NoticeDao noticeDao;

    public HashMap getNoticeList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> noticeList = noticeDao.getNoticeList(search);

        PageInfo page = new PageInfo(noticeList);
        Pager pager = PagerUtil.getPager(page);

        if(noticeList==null||noticeList.size()==0){
            map.put("result","fail");
            map.put("data",noticeList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",noticeList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public void delNoticeById(Integer noticeId){
        noticeDao.deleteByPrimaryKey(noticeId);
    }

    public void delSomeNotice(Integer[] noticeIdArr){
        noticeDao.delSomeNotice(noticeIdArr);
    }

    public void addNotice(Notice notice){
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        notice.setPublisher(user.getAccountNum());
        notice.setPublishTime(new Date());
        noticeDao.insert(notice);
    }
}
