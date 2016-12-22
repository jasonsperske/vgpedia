package net.vgpedia.views;

import javax.jdo.PersistenceManager;
import java.util.List;
import net.vgpedia.models.NewsItem;

public class NewsFactory {
	@SuppressWarnings("unchecked")
	public static List<NewsItem> fetchRecent(PersistenceManager pm) {
		String query = "select from " + NewsItem.class.getName() + " order by postedAt desc range 0,5";
		return (List<NewsItem>)pm.newQuery(query).execute();
	}
}