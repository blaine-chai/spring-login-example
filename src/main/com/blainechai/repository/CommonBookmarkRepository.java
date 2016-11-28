package com.blainechai.repository;

import com.blainechai.domain.CommonBookmark;
import com.blainechai.domain.UserBookmark;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 20..
 */
public interface CommonBookmarkRepository extends JpaRepository<CommonBookmark, Long> {

    List<CommonBookmark> findByUserAccount_UserId(String userId);

    List<CommonBookmark> findByUserAccount_UserIdAndAdminBookmark_Word(String userId, String word);

    @Transactional
    long deleteById(Long id);

    @Transactional
    long deleteByAdminBookmark_Word(String word);

    @Transactional
    long deleteByUserAccount_UserIdAndAdminBookmark_Word(String userId, String word);

    @Transactional
    long deleteByUserAccount_UserId(String userId);

    @Transactional
    long deleteByAdminBookmark_AdminAccount_UserId(String userId);
//    @Transactional
//    long deleteByUserId(String userId);
}
