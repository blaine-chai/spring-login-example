package com.blainechai.repository;

import com.blainechai.domain.AdminHistory;
import com.blainechai.domain.UserHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 20..
 */
public interface AdminHistoryRepository extends JpaRepository<AdminHistory, Long> {

    List<AdminHistory> findByUserAccount_UserId(String userId);
    List<AdminHistory> findByUserAccount_UserIdAndWord(String userId, String word);
    @Transactional
    long deleteById(Long id);
}
