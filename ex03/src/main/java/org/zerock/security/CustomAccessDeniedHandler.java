package org.zerock.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.apache.log4j.Logger;
import org.springframework.security.web.access.AccessDeniedHandler;

public class CustomAccessDeniedHandler implements AccessDeniedHandler {
	
	private static final Logger log = Logger.getLogger(CustomAccessDeniedHandler.class);
	
	@Override
	public void handle(HttpServletRequest request,
						HttpServletResponse response,
						AccessDeniedException accessException)
						throws IOException, ServletException{
		
		log.error("Access Denied Handler");
		log.error("Redirect....");
		
		response.sendRedirect("/ex03/accessError");
		
		
	}


}
