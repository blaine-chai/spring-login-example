package com.blainechai.repository;

import com.blainechai.domain.UserBookmark;
import com.blainechai.domain.UserHistory;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 20..
 */
public interface UserBookmarkRepository extends JpaRepository<UserBookmark, Long> {

    List<UserBookmark> findByUserAccount_UserId(String userId);

    List<UserBookmark> findByUserAccount_UserIdAndWord(String userId, String word);

    List<UserBookmark> findById(Long id);

    @Transactional
    long deleteById(Long id);

    @Transactional
    long deleteByWord(String word);

    @Transactional
    long deleteByUserAccount_UserIdAndWord(String userId, String word);

    @Transactional
    long deleteByUserAccount_UserId(String userId);
}
