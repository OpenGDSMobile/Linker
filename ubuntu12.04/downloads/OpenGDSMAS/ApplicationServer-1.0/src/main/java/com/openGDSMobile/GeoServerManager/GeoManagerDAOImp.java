package com.openGDSMobile.GeoServerManager;

import java.net.MalformedURLException; 
import java.util.List;

import it.geosolutions.geoserver.rest.GeoServerRESTPublisher;
import it.geosolutions.geoserver.rest.GeoServerRESTReader; 

import org.codehaus.jackson.JsonFactory; 
import org.codehaus.jackson.annotate.JsonMethod;
import org.codehaus.jackson.annotate.JsonAutoDetect.Visibility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.springframework.stereotype.Repository;


@Repository("geodao")
public class GeoManagerDAOImp implements GeoManagerDAO {
 
	static String RESTURL = "http://113.198.80.9/geoserver";
	static String RESTUSER = "admin";
	static String RESTPW = "geoserver";
	
	GeoServerRESTPublisher publisher; 
	GeoServerRESTReader reader ;
	
	JsonFactory jsonfactory;
	ObjectMapper mapper;

	GeoManagerDAOImp() throws MalformedURLException{
		super();
		publisher = new GeoServerRESTPublisher(RESTURL, RESTUSER, RESTPW);
		reader= new GeoServerRESTReader(RESTURL, RESTUSER, RESTPW); 

		mapper = new ObjectMapper();
		mapper.setSerializationInclusion(JsonSerialize.Inclusion.NON_NULL);
		mapper.setVisibility(JsonMethod.FIELD,Visibility.ANY);
		jsonfactory = new JsonFactory();
		jsonfactory.setCodec(mapper);
	}
			
	@Override
	public boolean geoserverCreateWorkspace(String name) {
		// TODO Auto-generated method stub
		return publisher.createWorkspace(name);
	} 
	@Override
	public List<String> getGeoserverLayerNames(String workspace) {
		// TODO Auto-generated method stub
		return reader.getDatastores(workspace).getNames();
	}

}
