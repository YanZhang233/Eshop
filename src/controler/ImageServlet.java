package controler;

import java.awt.Color;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "imageServlet", urlPatterns = "/ImageServlet")
public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ImageServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		BufferedImage bi = new BufferedImage(68, 22, BufferedImage.TYPE_INT_RGB);
		Graphics g = bi.getGraphics();
		Color c = new Color(255, 255, 255);
		g.setColor(c);
		g.fillRect(0, 0, 68, 22);
		char[] ch = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();
		Random random = new Random();
		StringBuffer sb = new StringBuffer();
		int index;
		for (int i = 0; i < 4; i++) {
			index = random.nextInt(ch.length);
			g.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
			g.drawString(ch[index] + "", i * 15 + 4, 18);
			sb.append(ch[index]);
		}
		request.getSession().setAttribute("image", sb.toString());
		ImageIO.write(bi, "JPG", response.getOutputStream());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
