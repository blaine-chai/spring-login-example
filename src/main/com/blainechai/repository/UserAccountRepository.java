package com.blainechai.repository;

import com.blainechai.domain.UserAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * private String userId;
 * private String username;
 * private String hash;
 * private String phone;
 * private Date createDate;
 * */

public interface UserAccountRepository extends JpaRepository<UserAccount, Long> {

    List<UserAccount> findByUsername(String username);

    List<UserAccount> findByUserId(String userId);

    List<UserAccount> findByhash(String hash);

    List<UserAccount> findByType(String userType);

    @Transactional
    long deleteByUserId(String userId);
}
