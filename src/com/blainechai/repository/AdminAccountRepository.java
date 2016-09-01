package com.blainechai.repository;

import com.blainechai.model.AdminAccount;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AdminAccountRepository extends JpaRepository<AdminAccount, Long> {
    List<AdminAccount> findByUsername(String username);
}
