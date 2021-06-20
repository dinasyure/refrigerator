package model;

public class BBSVO extends UserVO{
	private int bbs_num;
	private String title;
	private String bbs_type;
	private String content;
	private String writer;
	private String wdate;
	
	public int getBbs_num() {
		return bbs_num;
	}
	public void setBbs_num(int bbs_num) {
		this.bbs_num = bbs_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBbs_type() {
		return bbs_type;
	}
	public void setBbs_type(String bbs_type) {
		this.bbs_type = bbs_type;
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
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	
	@Override
	public String toString() {
		return "BBSVO [bbs_num=" + bbs_num + ", title=" + title + ", bbs_type=" + bbs_type + ", content=" + content
				+ ", writer=" + writer + ", wdate=" + wdate + ", getUid()=" + getUid() + "]";
	}	

}
