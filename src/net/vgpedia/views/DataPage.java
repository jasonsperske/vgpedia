package net.vgpedia.views;

import javax.servlet.http.HttpServletRequest;

public class DataPage {
	private int page_size;
	private int page;
	
	public DataPage(int page_size, HttpServletRequest request) {
		this.page_size = page_size;

		String value = request.getParameter("page");
		if(value != null) {
			try {
				this.page = Integer.parseInt(value);
			} catch(NumberFormatException nfe) {};
		}
	}
	
	public int getPageSize() {
		return page_size;
	}

	public int getPage() {
		return page;
	}

	public boolean notLast(int index) {
		return index < page_size;
	}
	
	public boolean hasNext(int list_size) {
		return list_size > page_size;
	}

	public boolean hasPrevious() {
		return (page > 0);
	}
	
	public String getRange() {
		return "range "+(page*page_size)+", "+((page*page_size)+page_size+1);		
	}
	
	public String getRangeDesc(int count) {
		return ((page*page_size)+1)+"-"+((page*page_size)+count-1);
	}

	public String getPreviousDesc() {
		return "&lt; Prev "+page_size;
	}
	
	public String getNextDesc() {
		return "Next "+page_size+" &gt;";
	}
}
