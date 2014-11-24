package com.openGDSMobile.PublicOpenData;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set; 

import org.jdom2.Document;
import org.jdom2.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service; 


@Service("Portal")
public class PublicDataPortalServiceImp implements PublicDataService {

	@Autowired
	@Qualifier("PortalDAO")
	PublicDataDAO publicDataobj;
	 
	//Environment
		String url="";
		String[] keyData = {"provider","serviceName","areaType","keyValue","envType"};
		String[] keyValue;
	
	@Override
	public Object requestPublicData(Map<String, Object> data) {

		Set<String> keys = data.keySet();
		keyValue=new String[]{"","","","",""};
		Iterator<String> it = keys.iterator();
		while(it.hasNext()){ 
			String tmp = it.next();
			for(int i=0; i<keyValue.length; i++){ 
				if(keyData[i].equals(tmp)){
					keyValue[i] = String.valueOf(data.get(tmp));
				}
			} 
		} 
		if(keyValue[0].equals("airkorea")){
			url = "http://openapi.airkorea.or.kr/openapi/services/rest/"+ 
					keyValue[1]+"/getCtprvnRltmMesureDnsty?sidoName="+keyValue[2]+"&numOfRows=100&ServiceKey="+keyValue[3];
		}
		System.out.println(url); 
		Document doc = publicDataobj.getXMLPublicData(url);
		Element root = doc.getRootElement(); 
		String test = "{\"row\":[";
		if(keyValue[0].equals("airkorea")){
			List<Element> bodyNodes = root.getChildren("body");
			for(Element bodyNode : bodyNodes){
				List<Element> itemsNodes = bodyNode.getChildren("items");
				for(Element itemNode : itemsNodes){
					List<Element> itemValues = itemNode.getChildren("item");
					for(Element itemValue : itemValues){
						List<Element> nodes = itemValue.getChildren();
						for(Element node : nodes){
							if(node.getName().equals("stationName")){
								test +="{\"stationName\":\""+node.getValue()+"\",";
							}
							if(node.getName().equals(keyValue[4])){
								test +="\""+keyValue[4]+"\":\""+node.getValue().trim()+"\"},";
								
							}
						}
					}
				}
			}
			test = test.substring(0,test.length()-1);
			test +="]}";
			
		}
		System.out.println(test);
		return test;
	}

}
