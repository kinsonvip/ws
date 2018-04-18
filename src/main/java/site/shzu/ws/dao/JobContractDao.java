package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import site.shzu.ws.model.JobContract;

@Mapper
public interface JobContractDao {
    int deleteByPrimaryKey(Integer id);

    int insert(JobContract record);

    int insertSelective(JobContract record);

    JobContract selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(JobContract record);

    int updateByPrimaryKey(JobContract record);
}