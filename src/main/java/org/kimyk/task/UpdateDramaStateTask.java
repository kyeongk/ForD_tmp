package org.kimyk.task;

import org.kimyk.mapper.AllDramaMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Setter;


@Component
public class UpdateDramaStateTask {
	@Setter(onMethod_= {@Autowired})
	private AllDramaMapper allMapper;
	
	@Scheduled(cron="0 0 3 * * *") //매일 새벽3시 작동
	public void modifyState() throws Exception{
		//방영예정인 드라마 중에 첫방송 날짜가 지난 드라마를 
		//방영중으로 변경
		allMapper.modifyState();
		
	}

}
