package com.blainechai.repository;

import com.blainechai.domain.UserAccount;
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

public interface UserAccountRepository extends JpaRepository<UserAccount, Long> {

    List<UserAccount> findByUsername(String username);

    List<UserAccount> findByUserId(String userId);

//    List<UserAccount> findByHash(String hash);

    List<UserAccount> findByType(String userType);

    List<UserAccount> findByUserIdAndType(String userId, String userType);

    List<UserAccount> findByUserIdContainingAndType(String userId, String userType);

    List<UserAccount> findByUsernameAndType(String username, String userType);

    List<UserAccount> findByUsernameContainingAndType(String username, String userType);

    @Transactional
    long deleteByUserId(String userId);
}
