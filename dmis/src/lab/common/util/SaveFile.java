package lab.common.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import java.io.OutputStreamWriter;

public class SaveFile {

	public boolean write(String fileName, String str, String ENCODE,
			boolean AppendFlag) {
		File f = new File(fileName);
		return write(f, str, ENCODE, AppendFlag);
	}

	public boolean write(File f, String str, String ENCODE, boolean AppendFlag) {
		try {
			FileOutputStream out = new FileOutputStream(f, AppendFlag);
			OutputStreamWriter wrt;
			if (null != ENCODE)
				wrt = new OutputStreamWriter(out, ENCODE);
			else
				wrt = new OutputStreamWriter(out);
			wrt.write(str, 0, str.length());
			wrt.close();
			out.close();
			out = null;
			wrt = null;
			f = null;
			return true;
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
