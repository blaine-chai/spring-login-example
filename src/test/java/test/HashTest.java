package test;

//import com.blainechai.repository.UserTableOptionRepository;
import com.blainechai.domain.CommonGroupName;
import com.blainechai.domain.UserAccount;
import com.blainechai.domain.UserGroup;
import com.blainechai.model.UserAccountApi;
import com.blainechai.util.EncryptUtil;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by blainechai on 2016. 9. 7..
 */
public class HashTest {
//    @Autowired
//    UserTableOptionRepository userTableOptionRepository;

    @Test
    public void test1() {
        EncryptUtil.getSHA256("sm");
    }

//    @Test
//    public void getNames(){
//        System.out.println(userTableOptionRepository.findAll());
//    }

    @Test
    public void test2(){
        System.out.println(getClass().getClassLoader().getResource("/logback.xml"));

    }
}
