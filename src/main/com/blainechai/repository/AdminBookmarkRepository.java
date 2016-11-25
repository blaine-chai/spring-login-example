package com.blainechai.repository;

import com.blainechai.domain.AdminBookmark;
import com.blainechai.domain.UserBookmark;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 20..
 */
public interface AdminBookmarkRepository extends JpaRepository<AdminBookmark, Long> {

    List<AdminBookmark> findByAdminAccount_UserId(String userId);

    List<AdminBookmark> findByAdminAccount_UserIdAndWord(String userId, String word);

    List<AdminBookmark> findByWord(String word);

    @Transactional
    long deleteById(Long id);

    @Transactional
    long deleteByWord(String word);

    @Transactional
    long deleteByAdminAccount_UserIdAndWord(String adminId, String word);

    @Transactional
    long deleteByAdminAccount_UserId(String adminId);
}
