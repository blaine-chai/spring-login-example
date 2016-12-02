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
//        BookInfo bookInfo = new BookInfo("id",)
        List<UserGroup> userGroups= new ArrayList<UserGroup>();
        userGroups.add(new UserGroup(new CommonGroupName("a"), null));
        userGroups.add(new UserGroup(new CommonGroupName("b"), null));
        userGroups.add(new UserGroup(new CommonGroupName("c"), null));
        userGroups.add(new UserGroup(new CommonGroupName("d"), null));
        userGroups.add(new UserGroup(new CommonGroupName("e"), null));

    }
}
