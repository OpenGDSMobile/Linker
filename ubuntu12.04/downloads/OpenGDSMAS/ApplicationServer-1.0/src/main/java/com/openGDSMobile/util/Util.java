package com.openGDSMobile.util;

import java.io.IOException;
import java.util.HashMap;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

public class Util {
	
	public static HashMap<String, Object> convertJsonToObject(String json) 
			throws JsonParseException, JsonMappingException, IOException{
		ObjectMapper objectMapper = new ObjectMapper();
		TypeReference<HashMap <String, Object>> typeReference = 
				new TypeReference<HashMap<String, Object>>(){};
		HashMap<String, Object> object = objectMapper.readValue(json, typeReference);
		return object;
	} 
}
