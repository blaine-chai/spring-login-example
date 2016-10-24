package com.blainechai.repository;

import com.blainechai.domain.BookInfo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 14..
 */
public interface BookInfoRepository extends JpaRepository<BookInfo, Long> {

    List<BookInfo> findAll();
    List<BookInfo> findByPriority(int priotiy);
}
