package site.shzu.ws.dao;

import org.apache.ibatis.annotations.Mapper;
import site.shzu.ws.model.Academy;

@Mapper
public interface AcademyDao {
    int deleteByPrimaryKey(Integer acaId);

    int insert(Academy record);

    int insertSelective(Academy record);

    Academy selectByPrimaryKey(Integer acaId);

    int updateByPrimaryKeySelective(Academy record);

    int updateByPrimaryKey(Academy record);
}