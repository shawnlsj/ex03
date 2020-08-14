package org.zerock.service;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class SampleTxServiceTests {

	private static final Logger log = Logger.getLogger(SampleTxServiceTests.class);
	
	private SampleTxService service;

	@Autowired
	public void setService(SampleTxService service) {
		this.service = service;
	}
	
	@Test
	public void testLong() {
		
		String str = "test content test content test content test content test content test content"
				+ "test content test content test content test content test content test content";
		log.info("bytes :"+ str.getBytes().length);
		
		service.addData(str);
		
	}
	
	
	
}
