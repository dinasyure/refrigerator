package model;

public class ReplyVO extends BBSVO{
	private int reply_num;
	private int bbs_id;
	private String rdate;
	private String reply_content;
	private String reply_writer;
	
	public int getReply_num() {
		return reply_num;
	}
	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}
	public int getBbs_id() {
		return bbs_id;
	}
	public void setBbs_id(int bbs_id) {
		this.bbs_id = bbs_id;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getReply_writer() {
		return reply_writer;
	}
	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [reply_num=" + reply_num + ", bbs_id=" + bbs_id + ", rdate=" + rdate + ", reply_content="
				+ reply_content + ", reply_writer=" + reply_writer + ", getUid()=" + getUid() + "]";
	}	

}
