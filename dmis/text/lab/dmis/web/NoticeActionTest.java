package lab.dmis.web;

import javax.annotation.Resource;

import lab.dmis.model.Notice;
import lab.dmis.util.JUnit4ClassRunner;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.transaction.annotation.Transactional;

@RunWith(JUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/lab/dmis/configuration/applicationContext.xml" })
@Transactional
public class NoticeActionTest {

	@Resource
	private NoticeAction noticeAction;

	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {

		Notice notice = new Notice();
		notice.setTitle("test");
		notice.setContent("test");

		noticeAction.setNotice(notice);
		noticeAction.add();
		// Assert.assertEquals(true, );
		// HttpServletRequest request = ServletActionContext.getRequest();
		// HttpSession session = request.getSession();
		// System.err.println(session.getAttribute("page"));

	}

}
