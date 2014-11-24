package com.openGDSMobile.GeoServerManager;

import java.util.List;
 

public interface GeoManagerService {
	
	boolean createWorkspace(String name);  
	List<String> getLayerNames(String workspace);
}
