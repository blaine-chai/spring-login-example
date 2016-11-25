package com.blainechai.repository;

import com.blainechai.domain.Session;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 9. 7..
 */
public interface SessionRepository extends JpaRepository<Session, Long> {
    List<Session> findByJSessionId(String jSessionId);

    List<Session> findByJSessionIdAndType(String jSessionId, String type);

    List<Session> findByUserId(String userId);

    @Transactional
    long deleteByJSessionId(String jSessionId);

    @Transactional
    long deleteByUserId(String userId);
}
