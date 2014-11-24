package com.openGDSMobile.GeoServerManager;
 
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class GeoManagerServiceImp implements GeoManagerService {

	@Autowired
	@Qualifier("geodao")
	GeoManagerDAO geo_manager;
	
	@Override
	public boolean createWorkspace(String name) {
		return geo_manager.geoserverCreateWorkspace(name);
	} 
	@Override
	public List<String> getLayerNames(String workspace) {
		return geo_manager.getGeoserverLayerNames(workspace);
	} 
}
