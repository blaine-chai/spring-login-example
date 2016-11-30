package com.blainechai.repository;

import com.blainechai.domain.NicknameOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 30..
 */
public interface NicknameRepository extends JpaRepository<NicknameOption, Long> {
    List<NicknameOption> findByAuthor(String author);
    List<NicknameOption> findByNickname(String nickname);
    @Transactional
    long deleteByNickname(String nickname);
}
