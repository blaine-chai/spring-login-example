package com.blainechai.repository;

import com.blainechai.domain.UserHistory;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 20..
 */
public interface UserHistoryRepository extends JpaRepository<UserHistory, Long> {

    List<UserHistory> findByUserAccount_UserId(String userId);

    List<UserHistory> findByUserAccount_UserIdAndWord(String userId, String word);

    @Transactional
    long deleteById(Long id);

    @Transactional
    long deleteByUserAccount_UserId(String userId);
}
