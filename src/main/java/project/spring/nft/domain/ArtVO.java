package project.spring.nft.domain;

import java.time.LocalDateTime;
import java.util.Date;

//작품 vo
public class ArtVO {
	private int artNo;
	private String memberId;
	private String artName;
	private int artPrice;
	private String artContent;
	private String artShowDate;
	private int artBasicFee;
	private int artReplyCount, artWishCount, artViewCount;
	private String artFileName;
	private String memberNickname;
	
	public ArtVO() {}

	public ArtVO(int artNo, String memberId, String artName, int artPrice, String artContent, String artShowDate,
			int artBasicFee, int artReplyCount, int artWishCount, int artViewCount, String artFileName,
			String memberNickname) {
		super();
		this.artNo = artNo;
		this.memberId = memberId;
		this.artName = artName;
		this.artPrice = artPrice;
		this.artContent = artContent;
		this.artShowDate = artShowDate;
		this.artBasicFee = artBasicFee;
		this.artReplyCount = artReplyCount;
		this.artWishCount = artWishCount;
		this.artViewCount = artViewCount;
		this.artFileName = artFileName;
		this.memberNickname = memberNickname;
	}

	public int getArtNo() {
		return artNo;
	}

	public void setArtNo(int artNo) {
		this.artNo = artNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getArtName() {
		return artName;
	}

	public void setArtName(String artName) {
		this.artName = artName;
	}

	public int getArtPrice() {
		return artPrice;
	}

	public void setArtPrice(int artPrice) {
		this.artPrice = artPrice;
	}

	public String getArtContent() {
		return artContent;
	}

	public void setArtContent(String artContent) {
		this.artContent = artContent;
	}

	public String getArtShowDate() {
		return artShowDate;
	}

	public void setArtShowDate(String artShowDate) {
		this.artShowDate = artShowDate;
	}

	public int getArtBasicFee() {
		return artBasicFee;
	}

	public void setArtBasicFee(int artBasicFee) {
		this.artBasicFee = artBasicFee;
	}

	public int getArtReplyCount() {
		return artReplyCount;
	}

	public void setArtReplyCount(int artReplyCount) {
		this.artReplyCount = artReplyCount;
	}

	public int getArtWishCount() {
		return artWishCount;
	}

	public void setArtWishCount(int artWishCount) {
		this.artWishCount = artWishCount;
	}

	public int getArtViewCount() {
		return artViewCount;
	}

	public void setArtViewCount(int artViewCount) {
		this.artViewCount = artViewCount;
	}

	public String getArtFileName() {
		return artFileName;
	}

	public void setArtFileName(String artFileName) {
		this.artFileName = artFileName;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	@Override
	public String toString() {
		return "ArtVO [artNo=" + artNo + ", memberId=" + memberId + ", artName=" + artName + ", artPrice=" + artPrice
				+ ", artContent=" + artContent + ", artShowDate=" + artShowDate + ", artBasicFee=" + artBasicFee
				+ ", artReplyCount=" + artReplyCount + ", artWishCount=" + artWishCount + ", artViewCount="
				+ artViewCount + ", artFileName=" + artFileName + ", memberNickname=" + memberNickname + "]";
	}
	
}
