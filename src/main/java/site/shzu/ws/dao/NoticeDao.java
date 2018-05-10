package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.Notice;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface NoticeDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Notice record);

    int insertSelective(Notice record);

    Notice selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Notice record);

    int updateByPrimaryKeyWithBLOBs(Notice record);

    int updateByPrimaryKey(Notice record);

    List<HashMap> getNoticeList(@Param(value = "search") String search);

    List<HashMap> getLast3Notice();

    List<HashMap> getNoticeListByStu(@Param(value = "search") String search);

    List<HashMap> getNoticeById(@Param(value = "id") Integer id);

    void delSomeNotice(@Param(value = "noticeIdArr") Integer[] noticeIdArr);
}