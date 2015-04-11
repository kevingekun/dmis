package lab.common.util;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class ImageCutOut {

	public static boolean imgcut(String srcImageFile, float x, float y,
			float w2, float h2) {
		boolean isSuccess = false;
		try {
			Image img;
			ImageFilter cropFilter;
			// 读取源图�?
			BufferedImage bi = ImageIO.read(new File(srcImageFile));
			int srcWidth = bi.getWidth(); // 源图宽度
			int srcHeight = bi.getHeight(); // 源图高度

			if (srcWidth >= w2 && srcHeight >= h2) {
				Image image = bi.getScaledInstance(srcWidth, srcHeight,
						Image.SCALE_DEFAULT);

				/* ****************************************
				 * 判断原图的宽高和DIV宽高的大�?根据图片外层DIV的宽度，选择的起始点则有相对变化
				 * **************************************
				 */
				int x1 = (int) (x * srcWidth);
				int y1 = (int) (y * srcWidth);
				int w = (int) (w2 * srcWidth);
				int h = (int) (h2 * srcWidth);

				// 四个参数分别为图像起点坐标和宽高
				// �? CropImageFilter(int x,int y,int width,int height)
				 cropFilter = new CropImageFilter(x1, y1, w, h);
				//cropFilter = new CropImageFilter(x, y, destWidth, destHeight);
				img = Toolkit.getDefaultToolkit().createImage(
						new FilteredImageSource(image.getSource(), cropFilter));
				BufferedImage tag = new BufferedImage(w, h,
						BufferedImage.TYPE_INT_RGB);
				Graphics g = tag.getGraphics();
				g.drawImage(img, 0, 0, null); // 绘制缩小后的�?
				g.dispose();
				// 输出为文�?
				ImageIO.write(tag, "JPEG", new File(srcImageFile));
				isSuccess = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}

	public static boolean imgCut(String srcImageFile, int x,
			int y, int width, int height){
		boolean isSuccess = false;
		BufferedImage fromimg = null;
		try {
			fromimg = ImageIO.read(new File(srcImageFile));
		} catch (IOException e) {
			e.printStackTrace();
		}
		ImageFilter cropFilter = new CropImageFilter(x, y, width, height);
		Image img = Toolkit.getDefaultToolkit().createImage(
				new FilteredImageSource(fromimg.getSource(), cropFilter));
		BufferedImage tag = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);

		Graphics g = tag.getGraphics();
		g.drawImage(img, 0, 0, null);// 绘制小图
		g.dispose();
		// 输出为文�?
		// dir = "d:\\temp\\cut_image_" + i + "_" + j + ".jpg";
		File f = new File(srcImageFile);
		try {
			ImageIO.write(tag, "JPG", f);
			isSuccess = true;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}


	/*public static void main(String[] args) {
		String path = "D:\\uploadFile\\microcitymanage\\users\\20140110\\img\\34.jpg";
		//ImageCutOut.imgcut(path, 0, 0, 450, 560);
		try {
			ImageCutOut.imgCut(path, 600, 0, 450, 560);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/
	 
}
