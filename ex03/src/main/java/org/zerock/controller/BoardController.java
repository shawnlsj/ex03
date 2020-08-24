package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger log = Logger.getLogger(BoardController.class);
	
	private BoardService service;
	
	BoardController(BoardService service){
		this.service=service;
	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list :" + cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("==================");
		log.info("register: " + board);
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		log.info("==================");
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno")Long bno, @ModelAttribute("cri")Criteria cri, Model model) {
		log.info("/get or /modify");
		model.addAttribute("board",service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, Criteria cri) {
		log.info("modify :" + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr, Criteria cri) {
		log.info("remove..." + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
		}
		rttr.addFlashAttribute("result","success");
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@GetMapping(value= "/getAttachList",
				produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList: " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
				
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files.....");
		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file = 
						Paths.get("C:\\upload\\"
									+attach.getUploadPath()+"\\"
									+attach.getUuid()+"_"
									+attach.getFileName());
				
				Files.deleteIfExists(file);
				
				//마임타입을 확인했는데 image로 시작한다면
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = 
							Paths.get("C:\\upload\\"
										+attach.getUploadPath()+"\\s_"
										+attach.getUuid()+"_"
										+attach.getFileName());
					Files.delete(thumbNail);
				}
				
			} catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}
}
