package test;

//import com.blainechai.repository.UserTableOptionRepository;
import com.blainechai.domain.BookInfo;
import com.blainechai.util.EncryptUtil;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

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
    }
}
