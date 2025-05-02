package com.web.spring.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.board.VO.Board;
import com.web.spring.board.VO.BoardSch;
import com.web.spring.board.VO.ContentVO;

@Controller
public class Erp01_BoardController {

	@Autowired(required=false)
	private Erp02_BoardService service;
	
	
	// http://localhost:2222/boardList
		@RequestMapping("/boardList")
		public String boardList(@ModelAttribute("sch") 
										BoardSch sch, Model d) {
			d.addAttribute("boardList", service.getBoardList(sch));
			return "WEB-INF\\erp\\board\\BoardList.jsp";
		}
		// WEB-INF\\erp\\board\\Listjsp.jsp
		//board\Listjsp.jsp
		// WEB-INF\erp\board\BoardList.jsp
		// WEB-INF\\erp\\board\\BoardList2.jsp
	// http://localhost:1111/boardReply
		

	// http://localhost:1111/boardInsert
	@RequestMapping("boardInsert")
	public String boardInsert(Board ins, Model d) {
		if(ins.getSubject()!=null ) {
			d.addAttribute("msg", service.insertBoard(ins));
		}
		return "WEB-INF\\erp\\board\\boardInsert2.jsp";
	}
	// dao ==> service ==> controller  view 처리 (상세 처리)
	// http://localhost:1111/boardDetail?no=4
	@GetMapping("boardDetail")
	public String boardDetail(@RequestParam("no") int no, Model d) {
		d.addAttribute("board", service.getBoardDetail(no));
		return "WEB-INF\\erp\\board\\boardDetail2.jsp";
	}
	// http://localhost:1111/boardUpdate
	@RequestMapping("boardUpdate")
	public String boardUpdate(Board upt, Model d) {
		
		d.addAttribute("msg", service.updateBoard(upt));
		// 수정이후에 데이터를 상세회면에서 데이터를 확인해야되기 때문에 필요..
		//d.addAttribute("board", service.getBoard(upt.getNo()));
		return "WEB-INF\\erp\\board\\boardDetail2.jsp";
	}	
	// http://localhost:1111/boardDelete?no=7
	@RequestMapping("boardDelete")
	public String boardDelete(@RequestParam("no") int no, Model d) {
		d.addAttribute("msg", service.deleteBoard(no));
		return "WEB-INF\\erp\\board\\boardDetail2.jsp";
	}		
	
	// boardReply
	@PostMapping("boardReply")
	public String reForm(@ModelAttribute("re") Board re) {
		// ${re.refno} ${re.subject} ${re.content}
		re.setRefno(re.getNo()); 
		re.setSubject("RE:"+re.getSubject());
		re.setContent("\n\n\n\n\n=== 이전글 ==\n"+re.getContent());
		
		
		return "WEB-INF\\erp\\board\\boardInsert2.jsp";
	}
	// http://localhost:1111/insContent
	@RequestMapping("insContent")
	public ResponseEntity<?> insContent(ContentVO ins){	
		
		return ResponseEntity.ok(service.insContent(ins));
	}
	// http://localhost:1111/uptContent
	@RequestMapping("uptContent")
	public ResponseEntity<?> uptContent(ContentVO upt){	
		return ResponseEntity.ok(service.uptContent(upt));
	}
	// http://localhost:1111/delContent 
	@DeleteMapping("delContent")
	public ResponseEntity<?> delContertAjax(@RequestParam("rno") int rno, Model d) {
	 	
		return ResponseEntity.ok(service.deleteContent(rno));
	}

	
}
