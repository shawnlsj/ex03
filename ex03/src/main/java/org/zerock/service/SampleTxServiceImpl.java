package org.zerock.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.mapper.Sample1Mapper;
import org.zerock.mapper.Sample2Mapper;

@Service
public class SampleTxServiceImpl implements SampleTxService {

	private static final Logger log = Logger.getLogger(SampleTxServiceImpl.class);
	
	private Sample1Mapper mapper1;
	private Sample2Mapper mapper2;
	
	@Autowired
	public void setMapper1(Sample1Mapper mapper1) {
		this.mapper1 = mapper1;
	}
	
	@Autowired
	public void setMapper2(Sample2Mapper mapper2) {
		this.mapper2 = mapper2;
	}
	
	@Transactional
	@Override
	public void addData(String value) {
		log.info("mapper1...");
		mapper1.insertCol1(value);
		
		log.info("mapper2...");
		mapper2.insertCol2(value);
		
		log.info("end....");
	}
	
}
