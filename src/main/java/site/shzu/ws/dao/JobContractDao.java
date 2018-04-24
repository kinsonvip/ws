package site.shzu.ws.dao;

import site.shzu.ws.model.JobContract;

public interface JobContractDao {
    int deleteByPrimaryKey(Integer id);

    int insert(JobContract record);

    int insertSelective(JobContract record);

    JobContract selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(JobContract record);

    int updateByPrimaryKey(JobContract record);
}