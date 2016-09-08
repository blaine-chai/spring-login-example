package com.blainechai.repository;

import com.blainechai.domain.AdminAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface AdminAccountRepository extends JpaRepository<AdminAccount, Long> {
    List<AdminAccount> findByUserId(String userId);

    @Transactional
    long deleteByUserId(String userId);
}
