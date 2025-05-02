package com.web.spring.board;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.spring.board.VO.Board;
import com.web.spring.board.VO.BoardFile;
import com.web.spring.board.VO.BoardSch;
import com.web.spring.board.VO.ContentVO;

@Service
public class Erp02_BoardService {
	@Autowired(required = false)
	private Erp03_BoardDao dao;



	public String insContent(ContentVO ins) {
		return dao.insContent(ins)>0?"등록성공":"등록실패";
	}
	public String uptContent(ContentVO upt) {
		return dao.uptContent(upt)>0?"수정성공":"수정실패";
	}
	public String deleteContent(int rno) {
		return dao.delContent(rno)>0?"삭제성공":"삭제실패";
	}
	
	
	public List<Board> getBoardList(BoardSch sch) {
		// 0. 검색 조건 처리..
		if (sch.getSubject() == null)
			sch.setSubject("");
		if (sch.getWriter() == null)
			sch.setWriter("");
		sch.setSubject("%" + sch.getSubject() + "%");
		sch.setWriter("%" + sch.getWriter() + "%");
		
		
		// 1. 총데이터 건수 설정.
		sch.setCount(dao.getBoardCount(sch));
		// 2. 한번에 보일 페이지의 데이터 건수
		if(sch.getPageSize()==0) {
			sch.setPageSize(5);
		}
		// 3. 총페이지 수..(총데이터건수/한번에 보일 데이터 건수)
		sch.setPageCount((int)Math.ceil(  sch.getCount()/(double)sch.getPageSize() ));
		
		if(sch.getCurPage()==0)
			sch.setCurPage(1);
		if(sch.getCurPage()>sch.getPageCount())
			sch.setCurPage(sch.getPageCount());

		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		
		/// 마지막페이지 : 현재클릭한페이지번호 * 선택한페이지의크기
		//  DB에서 자동 처리해주나, 정확한 로직 처리를 위해
		int endNo = sch.getCurPage()*sch.getPageSize();
		sch.setEnd(endNo>sch.getCount()?sch.getCount():
								sch.getCurPage()*sch.getPageSize()); 
		// 페이지 블럭 처리
		// 1. 블럭 크기 설정.
		sch.setBlockSize(5);
		// 2. 블럭 번호 = 올림(현재페이지번호/블럭의크기)
		int blockNum = (int)Math.ceil(sch.getCurPage()/(double)sch.getBlockSize());
		// 3. 시작 블럭
		sch.setStartBlock((blockNum-1)*sch.getBlockSize()+1);
		// 4. 마지막블럭(예외처리-기본적으로 블럭번호는 블럭번호*블럭의크기로 하는데 정확하게 
		//    페이지크기 보다 클수 있다.)
		int endBlock = blockNum * sch.getBlockSize();
		sch.setEndBlock(endBlock>sch.getPageCount()?sch.getPageCount():endBlock);	
		return dao.getBoardList(sch);
	}

	@Value("${user.upload}")
	private String path;

	public String insertBoard(Board ins) {
		String msg = ""; // 등록 성공 여부와 파일등록시 등록갯수, 예외발생시 해당 내용을
		// 화면단에 javascript로 출력하기 위한 내용(모델데이터로 controller단에 설정)
		msg = dao.insertBoard(ins)>0?"등록성공\\n":"등록실패\\n";
		// 파일업로드의 갯수
		int successCnt = 0;
		for(MultipartFile mf:ins.getReports()) {
			String fname = mf.getOriginalFilename();
			// null이 아니고, 공백이 아닐 때.
			if(fname!=null && !fname.equals("")) {
				
				try {
					// MultipartFile ==> File (물리파일로 변환)
					mf.transferTo(new File(path,fname));
					successCnt++;
					// (int no, String fname, String etc)
					// 게시물과 관련된 파일 정보를 등록 처리..ins.getNo()
					dao.insertBoardFile(new BoardFile(ins.getNo(),fname,ins.getSubject()+"게시판 첨부파일"));
					// 
				} catch (IllegalStateException e) {
					System.out.println("[IllegalStateException]"+e.getMessage());
					msg += "[IllegalStateException]"+e.getMessage()+"\\n";
				} catch (IOException e) {
					System.out.println("[IOException]"+e.getMessage());
					msg += "[IOException]"+e.getMessage()+"\\n";
				} catch(Exception e) {
					System.out.println("[Exception]"+e.getMessage());
					msg += "[Exception]"+e.getMessage()+"\\n";
				}
			}
		}
		if(successCnt>0) msg += successCnt+"개 파일 업로드 완료\\n";
		
		return msg;
	}
	// 수정후, 다시 로딩시..
	public 	Board getBoard(int no) {
		Board b = dao.getBoard(no); // 기본 정보..
	
		b.setFlist(dao.getBoardFile(no)); // 파일 리스트 정보 할당..
		b.setRelist(dao.getContentList(no)); // 댓글 리스트
		System.out.println(b.getRelist().size());
		// ${board.relist}
		return b;
	}
	
	
	// list에서 상세 조회시..
	public 	Board getBoardDetail(int no) {
		// 상세 조회시 조회 카운트 업..
		dao.readCntUpdate(no);
		return getBoard(no);
	}	
	// list에서 상세 조회시..

	public String updateBoard(Board upt) {
		return dao.updateBoard(upt)>0?"수정성공":"수정실패";
	}	
	public String deleteBoard(int no) {
		return dao.deleteBoard(no)>0?"삭제성공":"삭제실패";
	}   	
	
	
}
