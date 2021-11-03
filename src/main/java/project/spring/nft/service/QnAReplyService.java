package project.spring.nft.service;

import java.util.List;

import project.spring.nft.domain.QnAReplyVO;

public interface QnAReplyService {
	int create(QnAReplyVO vo) throws Exception;
	List<QnAReplyVO> read(int replybno);
	int update(QnAReplyVO vo);
	int delete(int replyNo, int replybno) throws Exception;
}
