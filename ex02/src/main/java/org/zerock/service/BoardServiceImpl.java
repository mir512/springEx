package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	// mapper == DAO
	// spring 4.3 이상에서 자동 처리
	// @Autowired , @Setter(onMethod_=@Autowired) 안 써도 자동주입 된다.
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {
		log.info("> register.............." + board);
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("> get.............");
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("> modify..............");
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("> remove..............");
		return mapper.delete(bno) == 1;
	}
	/*
	@Override
	public List<BoardVO> getList() {
		log.info("> getList.............");
		return mapper.getList();
	}
	*/
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("> getList with Criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("> get total count ");
		return mapper.getTotalCount(cri);
	}
}
