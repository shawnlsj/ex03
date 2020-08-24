package org.zerock.domain;

import java.util.Date;
import java.util.List;

public class BoardVO {

	private Long bno; //BNO	NUMBER(10,0)
	private String title; //TITLE	VARCHAR2(200 BYTE)
	private String content; //CONTENT	VARCHAR2(2000 BYTE)
	private String writer;//WRITER	VARCHAR2(50 BYTE)
	private Date regdate; //REGDATE	DATE
	private Date updateDate; //UPDATEDATE	DATE
	
	private int replyCnt;
	
	private List<BoardAttachVO> attachList;
	
	public Long getBno() {
		return bno;
	}
	public void setBno(Long bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
		

	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
	
	
	
	public List<BoardAttachVO> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<BoardAttachVO> attachList) {
		this.attachList = attachList;
	}
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + ", updateDate=" + updateDate + ", replyCnt=" + replyCnt + ", attachList=" + attachList
				+ "]";
	}
	
	
	
}
