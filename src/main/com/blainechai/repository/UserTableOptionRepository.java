package com.blainechai.repository;

import com.blainechai.domain.UserTableOption;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * private String userId;
 * private String username;
 * private String hash;
 * private String phone;
 * private Date createDate;
 */

public interface UserTableOptionRepository extends JpaRepository<UserTableOption, Long> {

    List<UserTableOption> findByUserAccount_UserId(String userId);

    @Transactional
    long deleteByUserAccount_UserId(String userId);
}
