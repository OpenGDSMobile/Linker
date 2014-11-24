package com.openGDSMobile.PublicOpenData;
 

import java.net.URL;

import org.codehaus.jackson.JsonParser;
import org.jdom2.Document;
import org.jdom2.input.SAXBuilder;
import org.springframework.stereotype.Repository; 


@Repository("PortalDAO") 
public class PublicDataPortalDAOImp implements PublicDataDAO {
 

	PublicDataPortalDAOImp(){ 
	}
	
	@Override
	public JsonParser getJSONPublicData(String path) {
		
		return null;
	}

	@Override
	public Document getXMLPublicData(String path) {
		try {
		/*	URL url = new URL(path);
			InputSource is = new InputSource(url.openStream());
			Document db =  dBuilder.parse(is);
			System.out.println("suc");		
			return  db;
			*/
			URL url = new URL(path);
			SAXBuilder builder = new SAXBuilder();
			Document doc = builder.build(url);
			return doc;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
	}

}
