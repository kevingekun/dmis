package lab.common.util;

import java.util.UUID;

public class Tool {

	public static String getUUIDStr(){
		String originaluuid = UUID.randomUUID().toString();
		return originaluuid.replaceAll("-", "");
	}
	
}
