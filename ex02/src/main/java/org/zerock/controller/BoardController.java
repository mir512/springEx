package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	// 생성자를 만들면 자동으로 주입됨. 생성자를 만들지 않으면 @Setter(onMethod_= @Autowired) 로 자동주입
	private BoardService service;
	/*
	// p 212
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list", service.getList());
	}
	*/
	// p 300 pageNum과 amount 처리하기 위해 수정
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("> list: " + cri);
		model.addAttribute("list", service.getList(cri));
		//model.addAttribute("pageMaker", new PageDTO(cri, 123));
		
		int total = service.getTotal(cri);
		log.info("> total: " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	// p 239
	@GetMapping("/register")
	public void register() {
		
	}
	
	// p 216 
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("> register: " + board);
		service.register(board);
		// 한번만 확인할 수 있음. flash attribute. url 재요청하면 전달되지 않음.
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	// p 218
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("> get or modify");
		model.addAttribute("board", service.get(bno));
	}
	
	// p 219
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("> modify: " + board);
		// 수정 가능한지 if문으로 확인
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		// p 319 페이징 처리 위해 추가. 글 수정 후 원래 보던 페이지 번호 다시 뜨도록 
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/board/list";
	}
	
	// p 220
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("> remove... " + bno);
		// 삭제 가능한지 if문으로 확인 
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		// p 319 페이징 처리 위해 추가. 글 삭제 후 원래 보던 페이지 번호 다시 뜨도록
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/board/list";
	}
}
