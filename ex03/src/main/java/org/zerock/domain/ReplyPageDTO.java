package org.zerock.domain;

import java.util.List;

public class ReplyPageDTO {

	private int replyCnt;
	private List<ReplyVO> list;
	
	public ReplyPageDTO(int replyCnt, List<ReplyVO> list) {
		super();
		this.replyCnt = replyCnt;
		this.list = list;
	}

	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	public List<ReplyVO> getList() {
		return list;
	}

	public void setList(List<ReplyVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "ReplyPageDTO [replyCnt=" + replyCnt + ", list=" + list + "]";
	}

	
	
}
