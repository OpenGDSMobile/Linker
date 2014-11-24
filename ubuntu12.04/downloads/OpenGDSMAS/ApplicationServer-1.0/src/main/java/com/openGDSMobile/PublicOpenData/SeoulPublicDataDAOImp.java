package com.openGDSMobile.PublicOpenData;
 
import java.net.URL;

import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonParser;
import org.codehaus.jackson.annotate.JsonMethod;
import org.codehaus.jackson.annotate.JsonAutoDetect.Visibility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.jdom2.Document;
import org.springframework.stereotype.Repository; 


@Repository("seoulPublicDAO") 
public class SeoulPublicDataDAOImp implements PublicDataDAO {

	JsonFactory jsonfactory;
	ObjectMapper mapper;
	 
	SeoulPublicDataDAOImp(){
		mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonSerialize.Inclusion.NON_NULL);
		mapper.setVisibility(JsonMethod.FIELD,Visibility.ANY);
		jsonfactory = new JsonFactory();
		jsonfactory.setCodec(mapper);
	}
	
	@Override
	public JsonParser getJSONPublicData(String path) {
		try {
			URL url = new URL(path);
			return jsonfactory.createJsonParser(url);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} 
	}

	@Override
	public Document getXMLPublicData(String path) {
		// TODO Auto-generated method stub
		return null;
	}

}
