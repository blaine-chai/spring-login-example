package com.blainechai.repository;

import com.blainechai.domain.CommonGroupName;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 11. 23..
 */
public interface CommonGroupNameRepository extends JpaRepository<CommonGroupName, String> {

    List<CommonGroupName> findByGroupName(String groupName);

    @Transactional
    String deleteByGroupName(String groupName);
}
