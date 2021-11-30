package project.spring.nft.domain;

import java.util.Date;

public class PaymentVO {
	private int paymentNo;
	private String artName;
	private int artNo;
	private String memberId;
	private int artPrice;
	private Date paymentDate;
	private String merchantUid;
	private String artFileName;
	private String paymentType;
	private String artFileName;
	
	public PaymentVO() {}

	public PaymentVO(int paymentNo, String artName, int artNo, String memberId, int artPrice, Date paymentDate,
<<<<<<< HEAD
			String merchantUid, String artFileName, String paymentType) {
=======
			String merchantUid, String paymentType, String artFileName) {
>>>>>>> origin/develop-yed
		super();
		this.paymentNo = paymentNo;
		this.artName = artName;
		this.artNo = artNo;
		this.memberId = memberId;
		this.artPrice = artPrice;
		this.paymentDate = paymentDate;
		this.merchantUid = merchantUid;
		this.artFileName = artFileName;
		this.paymentType = paymentType;
		this.artFileName = artFileName;
	}

	public int getPaymentNo() {
		return paymentNo;
	}

	public void setPaymentNo(int paymentNo) {
		this.paymentNo = paymentNo;
	}

	public String getArtName() {
		return artName;
	}

	public void setArtName(String artName) {
		this.artName = artName;
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

	public int getArtPrice() {
		return artPrice;
	}

	public void setArtPrice(int artPrice) {
		this.artPrice = artPrice;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getMerchantUid() {
		return merchantUid;
	}

	public void setMerchantUid(String merchantUid) {
		this.merchantUid = merchantUid;
	}

	public String getArtFileName() {
		return artFileName;
	}

	public void setArtFileName(String artFileName) {
		this.artFileName = artFileName;
	}	
		
	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getArtFileName() {
		return artFileName;
	}

	public void setArtFileName(String artFileName) {
		this.artFileName = artFileName;
	}

	@Override
	public String toString() {
		return "PaymentVO [paymentNo=" + paymentNo + ", artName=" + artName + ", artNo=" + artNo + ", memberId="
				+ memberId + ", artPrice=" + artPrice + ", paymentDate=" + paymentDate + ", merchantUid=" + merchantUid
<<<<<<< HEAD
				+ ", artFileName=" + artFileName + ", paymentType=" + paymentType + "]";
=======
				+ ", paymentType=" + paymentType + ", artFileName=" + artFileName + "]";
>>>>>>> origin/develop-yed
	}

}
