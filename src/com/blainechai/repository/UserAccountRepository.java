package com.blainechai.repository;

import com.blainechai.model.UserAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface UserAccountRepository extends JpaRepository<UserAccount, Long> {

    List<UserAccount> findByUsername(String username);

}
