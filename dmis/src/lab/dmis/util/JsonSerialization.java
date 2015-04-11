package lab.dmis.util;

import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

public class JsonSerialization {

		public static JsonConfig jsonSer(String[] str){
			
			JsonConfig config = new JsonConfig();  
			config.setIgnoreDefaultExcludes(false); 
			config.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT); 
			config.setExcludes(str);
			config.registerJsonValueProcessor(java.sql.Timestamp.class, new DateJsonValueProcessor("yyyy-MM-dd  HH:mm"));  
			config.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd  HH:mm")); 
		
			return config;
		}
}
