package com.zimax.mcrs.report.service;

import com.zimax.mcrs.report.mapper.RFIDReadRaReportMapper;
import com.zimax.mcrs.report.pojo.RFIDReadRa;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/5 15:18
 */
@Service
public class RFIDReadRaService {

	/**
	 * RFID读取率报表
	 */
	@Autowired
	private RFIDReadRaReportMapper rfidReadRaReportMapper;

	/**
	 * 添加RFID读取率报表信息
	 * @param rfidReadRa RFID读取率报表
	 */
	public void addRFIDReadRa(RFIDReadRa rfidReadRa){
		rfidReadRaReportMapper.addRFIDReadRa(rfidReadRa);
	}

}
