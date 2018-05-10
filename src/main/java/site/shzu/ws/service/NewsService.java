package site.shzu.ws.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.shzu.ws.dao.NewsDao;
import site.shzu.ws.model.News;
import site.shzu.ws.model.User;
import site.shzu.ws.util.Pager;
import site.shzu.ws.util.PagerUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @Author: Kinson
 * @Description:
 * @Date: Created in 2018/05/05 0:46
 * @Version: 1.0
 */
@Service
public class NewsService {
    @Autowired
    NewsDao newsDao;

    public List<HashMap> getLast3News(){
        return newsDao.getLast3News();
    }

    public List<HashMap> getNewsListByStu(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> newsListByStu =  newsDao.getNewsListByStu(search);
        return newsListByStu;
    }

    public List<HashMap> getNewsInfoById(Integer id){
        return newsDao.getNewsById(id);
    }

    public HashMap getNewsList(int pageNum, int pageSize, String search){
        HashMap<Object,Object> map = new HashMap<>();
        PageHelper.startPage(pageNum, pageSize);
        List<HashMap> newsList = newsDao.getNewsList(search);

        PageInfo page = new PageInfo(newsList);
        Pager pager = PagerUtil.getPager(page);

        if(newsList==null||newsList.size()==0){
            map.put("result","fail");
            map.put("data",newsList);
            map.put("message","没有查到相应数据，请重试！！");
            map.put("pager",pager);
            return map;
        }

        map.put("result","success");
        map.put("data",newsList);
        map.put("message","正常！");
        map.put("pager",pager);

        return map;
    }

    public void delNewsById(Integer newsId){
        newsDao.deleteByPrimaryKey(newsId);
    }

    public void delSomeNews(Integer[] newsIdArr){
        newsDao.delSomeNews(newsIdArr);
    }

    public void addNews(News news){
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        news.setPublisher(user.getAccountNum());
        news.setPublishTime(new Date());
        newsDao.insertSelective(news);
    }
}
