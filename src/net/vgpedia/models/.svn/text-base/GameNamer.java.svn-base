package net.vgpedia.models;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class GameNamer {
	public static String encode(String name) {
		String encoded_name = null;
		try {
			encoded_name = URLEncoder.encode(name, "UTF-8");
			encoded_name = encoded_name.replace('+', '_');
			encoded_name = encoded_name.replaceAll("_-_", "-");
			encoded_name = encoded_name.replaceAll("%27", "");
			encoded_name = encoded_name.replaceAll("%2C", "");
			encoded_name = encoded_name.replaceAll("%26", "and");
			encoded_name = encoded_name.replaceAll("%21", "!");
			encoded_name = encoded_name.replaceAll("%22", "");
			encoded_name = encoded_name.replaceAll("%23", "");
		} catch (UnsupportedEncodingException e) {
			encoded_name = null;
		}
		
		return encoded_name;
	}
}
