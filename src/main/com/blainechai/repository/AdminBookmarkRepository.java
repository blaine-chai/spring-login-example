package com.blainechai.repository;

import com.blainechai.domain.AdminBookmark;
import com.blainechai.domain.UserBookmark;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 20..
 */
public interface AdminBookmarkRepository extends JpaRepository<AdminBookmark, Long> {

    List<AdminBookmark> findByUserAccount_UserId(String userId);

    List<AdminBookmark> findByUserAccount_UserIdAndWord(String userId, String word);

    @Transactional
    long deleteById(Long id);

    @Transactional
    long deleteByAdminHistory_id(Long id);

    @Transactional
    long deleteByWord(Long word);

    @Transactional
    long deleteByUserAccount_UserIdAndWord(String userId, String word);

    @Transactional
    long deleteByAdminAccount_UserIdAndWord(String admin, String word);
}
