package lab.dmis.service;

import lab.common.model.Page;
import lab.common.service.BaseManager;
import lab.dmis.model.Downloadrecoder;

public interface DownloadRecoderService extends BaseManager<Downloadrecoder, Integer>{

	public Page getPage(int pageNo, int pageContSize, String userId);
	
	public boolean remove(int id);

	public boolean removeChecked(String ids);

	
}
