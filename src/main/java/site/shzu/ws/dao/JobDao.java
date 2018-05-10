package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.Job;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface JobDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Job record);

    int insertSelective(Job record);

    Job selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Job record);

    int updateByPrimaryKeyWithBLOBs(Job record);

    int updateByPrimaryKey(Job record);

    List<HashMap> getLast3Job();

    List<HashMap> getJobInfoById(@Param(value = "id") Integer id);

    List<HashMap> getUncheckedJobList(@Param(value = "search") String search);

    List<HashMap> getUncheckedJobListByDep(@Param(value = "accountNum") String accountNum,@Param(value = "search") String search);

    List<HashMap> getCheckedJobListByDep(@Param(value = "accountNum") String accountNum,@Param(value = "search") String search);

    List<HashMap> getCheckedJobList(@Param(value = "search") String search);

    List<HashMap> getCheckedJobListByStu(@Param(value = "search") String search);

    void passJob(@Param(value = "jobId") Integer jobId);

    void noPassJob(@Param(value = "jobId") Integer jobId);

    void passSomeJob(@Param(value = "jobIdArr") Integer[] jobIdArr);

    void noPassSomeJob(@Param(value = "jobIdArr") Integer[] jobIdArr);

    void delSomeJob(@Param(value = "jobIdArr") Integer[] jobIdArr);

    int insertJob(Job record);
}