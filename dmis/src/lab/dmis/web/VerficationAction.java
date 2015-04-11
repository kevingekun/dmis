package lab.dmis.web;

import java.io.ByteArrayInputStream;

import lab.common.util.CodeImage;
import lab.common.web.BaseAction;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@SuppressWarnings("serial")
@Component
@Scope("prototype")
public class VerficationAction extends BaseAction {

	private ByteArrayInputStream inputStream;
	
	public String getVerification(){
		CodeImage rdnu = CodeImage.Instance();
		this.setInputStream(rdnu.getImage());
		putObjToSession("VCID", rdnu.getString());
		return SUCCESS;
	}

	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}
	
	
}
