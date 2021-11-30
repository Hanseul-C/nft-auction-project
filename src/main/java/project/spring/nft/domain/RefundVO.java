package project.spring.nft.domain;

public class RefundVO {
	private int refundNo;
	private String memberId;
	private String refundAccount;
	private int refundMoney;
	
	public RefundVO() {}

	public RefundVO(int refundNo, String memberId, String refundAccount, int refundMoney) {
		super();
		this.refundNo = refundNo;
		this.memberId = memberId;
		this.refundAccount = refundAccount;
		this.refundMoney = refundMoney;
	}

	public int getRefundNo() {
		return refundNo;
	}

	public void setRefundNo(int refundNo) {
		this.refundNo = refundNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getRefundAccount() {
		return refundAccount;
	}

	public void setRefundAccount(String refundAccount) {
		this.refundAccount = refundAccount;
	}

	public int getRefundMoney() {
		return refundMoney;
	}

	public void setRefundMoney(int refundMoney) {
		this.refundMoney = refundMoney;
	}

	@Override
	public String toString() {
		return "RefundVO [refundNo=" + refundNo + ", memberId=" + memberId + ", refundAccount=" + refundAccount
				+ ", refundMoney=" + refundMoney + "]";
	}
}
