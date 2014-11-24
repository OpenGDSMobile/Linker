package com.openGDSMobile.airQuality;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service; 


@Service
public class AirQualityServiceImp implements AirQualityService{
	
	@Autowired
	@Qualifier("airQualityData")
	AirQualityDataDAO airQualityDataobj; 
	
	@Override
	public void requestAirQualityMapCreate(Map<String,Object> data) {

		System.out.println("hahah");
		//airQualityDataobj.createMap();
	}
}
