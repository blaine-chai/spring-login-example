package com.blainechai.repository;

import com.blainechai.domain.CommonGroupMap;
import com.blainechai.domain.CommonGroupName;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 11. 23..
 */
public interface CommonGroupMapRepository extends JpaRepository<CommonGroupMap, String> {

    List<CommonGroupMap> findByGroupName_GroupName(String groupName);
    List<CommonGroupMap> findByGroupId(String groupId);

    @Transactional
    long deleteByGroupName_GroupName(String groupName);
}
