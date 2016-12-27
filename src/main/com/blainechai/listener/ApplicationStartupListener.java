package com.blainechai.listener;

/**
 * Created by blainechai on 2016. 9. 18..
 */

import com.blainechai.constant.Constant;
import com.blainechai.domain.CommonGroupName;
import com.blainechai.repository.CommonGroupNameRepository;
import com.blainechai.repository.SessionRepository;
import com.blainechai.repository.UserTableOptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

@Component
public class ApplicationStartupListener implements ApplicationListener<ContextRefreshedEvent> {

    @Autowired
    SessionRepository sessionRepository;

    @Autowired
    UserTableOptionRepository userTableOption;

    @Autowired
    CommonGroupNameRepository groupNameRepository;

    /**
     * This method is called during Spring's startup.
     *
     * @param event Event raised when an ApplicationContext gets initialized or
     *              refreshed.
     */
    @Override
    public void onApplicationEvent(final ContextRefreshedEvent event) {

        // here your code ...
        sessionRepository.deleteAll();
        if (groupNameRepository.findByGroupName(Constant.GROUP_NAME_ALL).size() <= 0) {
            groupNameRepository.save(new CommonGroupName(Constant.GROUP_NAME_ALL, Constant.GROUP_NAME_ALL));
        }
    }

}