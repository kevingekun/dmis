package lab.dmis.service.impl;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.DownloadRecoderDao;
import lab.dmis.model.Downloadrecoder;
import lab.dmis.service.DownloadRecoderService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DownloadRecoderServiceImpl extends BaseManagerImpl<Downloadrecoder, Integer> implements
DownloadRecoderService {

	@Autowired
	private DownloadRecoderDao DRDao;
	
	public Page getPage(int pageNo,int pageSize,String userId){
		String hql = " from Downloadrecoder where userId ='" + userId +"'";
		return DRDao.getPage(hql,pageNo,pageSize);
	}

	/**
	 *删除单个下载记录 
	 * 
	 */
	@Override
	public boolean remove(int downloadrecoderId) {
		
		
		try {
			DRDao.deleteByKey(downloadrecoderId);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 *删除选中的下载记录 
	 * 
	 */
	public boolean removeChecked(String ids){
		
		String hql = "delete from Downloadrecoder downloadrecoder where downloadrecoder.id in (" + ids +")";
		try {
			if(DRDao.bulkUpdate(hql) > 0){
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			return false;
		}
	}
	public DownloadRecoderDao getDRDao() {
		return DRDao;
	}

	public void setDRDao(DownloadRecoderDao dRDao) {
		DRDao = dRDao;
	}

	
	
}
