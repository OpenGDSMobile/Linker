package com.openGDSMobile.Controllers;
 

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
 
import com.openGDSMobile.PublicOpenData.PublicDataService;
import com.openGDSMobile.util.Util;
 

@Controller
public class PublicOpenDataController { 

	@Autowired
	@Qualifier("Seoul")
	PublicDataService pds;
	
	@Autowired
	@Qualifier("Portal")
	PublicDataService pdp; 
	
	@RequestMapping(headers="Content-Type=application/json", 
			value="/EnvironmentSeoulData.do",method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> seoulPublic(@RequestBody String JSONData){ 
		Map<String, Object> message = new HashMap<String, Object>();
		
		try {
			Map<String,Object> data = Util.convertJsonToObject(JSONData); 
			message.put("result", "OK");
			message.put("message", null); 
			message.put("data", pds.requestPublicData(data));
			return message;			
		} catch (Exception e) {
			// TODO Auto-generated catch block 
			message.put("result", "ERROR");
			message.put("message", e.getMessage());
			message.put("data", null);
			return message;
		} 
	} 
	
	@RequestMapping(headers="Content-Type=application/json", 
			value="/EnvironmentPublicData.do",method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> PublicDataPortal(@RequestBody String JSONData){ 
		Map<String, Object> message = new HashMap<String, Object>();
		
		try {
			Map<String,Object> data = Util.convertJsonToObject(JSONData); 
			message.put("result", "OK");
			message.put("message", null); 
			message.put("data", pdp.requestPublicData(data));
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
