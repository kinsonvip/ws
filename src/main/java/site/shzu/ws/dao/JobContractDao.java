package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.JobContract;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface JobContractDao {
    int deleteByPrimaryKey(Integer id);

    int insert(JobContract record);

    int insertSelective(JobContract record);

    JobContract selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(JobContract record);

    int updateByPrimaryKey(JobContract record);

    List<HashMap> getUncheckedContractList(@Param(value = "search") String search);

    List<HashMap> getCheckedContractList(@Param(value = "search") String search);

    void noPassContract(@Param(value = "jobContractId") Integer jobContractId);
}