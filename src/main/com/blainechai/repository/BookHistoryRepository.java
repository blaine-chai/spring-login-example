//package com.blainechai.repository;
//
//
//import com.blainechai.domain.BookHistory;
//import org.springframework.data.jpa.repository.JpaRepository;
//
//import java.util.List;
//
//public interface BookHistoryRepository extends JpaRepository<BookHistory, Long> {
//
//    List<BookHistory> findByUserAccount_UserId(String userId);
//    List<BookHistory> findByUserAccount_UserIdAndBookId(String userId, String bookId);
//}
