package com.openGDSMobile.Controllers;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.openGDSMobile.GeoServerManager.GeoManagerService;

@Controller
public class GeoServerController { 
	@Autowired
	GeoManagerService geomanager; 
	
	@RequestMapping(value="/createWorkspace.do")
	public @ResponseBody Map<String, Object> workspaceCreate(@RequestBody String JSONData){ 
		Map<String, Object> message = new HashMap<String, Object>();
		try { 
			message.put("result", "OK");
			message.put("message", null); 
			return message;			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			message.put("result", "ERROR");
			message.put("message", e.getMessage());
			message.put("data", null);
			return message;
		} 
	}  
	
	@RequestMapping(value="/getLayerNames.do")
	public @ResponseBody Map<String, Object> getLayerNames(@RequestBody String data){ 
		Map<String, Object> message = new HashMap<String, Object>(); 
		try { 
			message.put("result", "OK");
			message.put("message", null); 
			message.put("data", geomanager.getLayerNames("opengds")); 
			return message;			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			message.put("result", "ERROR");
			message.put("message", e.getMessage());
			message.put("data", null);
			return message;
		}  
	}
	
	
	
}
