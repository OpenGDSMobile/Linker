package com.openGDSMobile.GeoServerManager;

import java.util.List;

public interface GeoManagerDAO {

	boolean geoserverCreateWorkspace(String name); 
	List<String> getGeoserverLayerNames(String workspace);
	
}
