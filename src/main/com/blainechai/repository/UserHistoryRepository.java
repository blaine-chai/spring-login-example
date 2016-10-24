package com.blainechai.repository;

import com.blainechai.domain.UserHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 20..
 */
public interface UserHistoryRepository extends JpaRepository<UserHistory, String>{

    List<UserHistory> findByUserAccount_UserId(String userId);
}
