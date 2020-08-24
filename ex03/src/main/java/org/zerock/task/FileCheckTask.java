package org.zerock.task;

import org.apache.log4j.Logger;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class FileCheckTask {
	private static final Logger log = Logger.getLogger(FileCheckTask.class);
	
	
	@Scheduled(cron="0 * * * * *")
	public void checkFiles() throws Exception{
		
		log.warn("file Check Task run......");
		log.warn("=========================");
	}
	
}
