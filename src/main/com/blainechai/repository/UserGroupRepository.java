package com.blainechai.repository;

import com.blainechai.domain.UserAccount;
import com.blainechai.domain.UserGroup;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 11. 23..
 */
public interface UserGroupRepository extends JpaRepository<UserGroup, Long> {

    List<UserGroup> findByGroupName_GroupName(String groupName);

    List<UserGroup> findByUserAccount_UserIdAndGroupName_GroupName(String userId, String groupName);

    List<UserGroup> findByUserAccount_UserId(String userId);

    @Transactional
    Long deleteByGroupName_GroupName(String groupName);

    @Transactional
    Long deleteByUserAccount_UserId(String userId);

    @Transactional
    Long deleteByUserAccount_UserIdAndGroupName_GroupName(String userId, String groupName);

}
