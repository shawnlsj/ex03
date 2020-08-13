package org.zerock.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

@Service
public class  BoardServiceImpl implements BoardService {
	private static final Logger log = Logger.getLogger(BoardServiceImpl.class);
	
	private BoardMapper mapper;
	
	BoardServiceImpl(BoardMapper mapper){
		this.mapper = mapper;
	}
	
	@Override
	public void register(BoardVO board) {
		log.info("register......" + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get....." + bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify......"+board);
		return mapper.update(board) >= 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove...." + bno);
		return mapper.delete(bno) >= 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getListWithPaging......"+cri);
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
}
