package com.openGDSMobile.PublicOpenData;
 
import org.codehaus.jackson.JsonParser; 
import org.jdom2.Document;

public interface PublicDataDAO {
	
	JsonParser getJSONPublicData(String path);
	Document getXMLPublicData(String path);

}
