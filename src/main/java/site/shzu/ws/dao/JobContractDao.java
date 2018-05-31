package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import site.shzu.ws.model.Job;
import site.shzu.ws.model.JobContract;
import site.shzu.ws.model.User;

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

    int getJObContractNum(JobContract jobContract);

    int getExistNum(User user);

    List<HashMap> getUncheckedContractList(@Param(value = "search") String search);

    List<HashMap> getCheckedContractList(@Param(value = "search") String search);

    List<HashMap> getUnconfirmedContractListByDep(@Param(value = "accountNum") String accountNum,@Param(value = "search") String search);

    List<HashMap> getConfirmedContractListByDep(@Param(value = "accountNum") String accountNum,@Param(value = "search") String search);

    List<HashMap> getUnevaluatedContractListByDep(@Param(value = "accountNum") String accountNum,@Param(value = "search") String search);

    List<HashMap> getEvaluatedContractListByDep(@Param(value = "accountNum") String accountNum,@Param(value = "search") String search);

    List<HashMap> getContractByAccountNum(@Param(value = "accountNum") String accountNum,@Param(value = "search") String search);

    List<HashMap> getAllEvaluatedContractList(@Param(value = "search") String search);

    void delSomeContract(@Param(value = "jobContractIdArr") Integer[] jobContractIdArr);

    Job getAcceptNum(JobContract jobContract);
}