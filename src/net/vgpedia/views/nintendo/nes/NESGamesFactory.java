package net.vgpedia.views.nintendo.nes;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.views.DataPage;

public class NESGamesFactory {
	@SuppressWarnings("unchecked")
	public static List<NESGame> fetch(DataPage page, String group, PersistenceManager pm) {
		Query query = pm.newQuery("select from " + NESGame.class.getName() + " where group==groupNameParam order by title asc "+page.getRange());
		query.declareParameters("String groupNameParam");
		return (List<NESGame>)query.execute(group);
	}
	
	@SuppressWarnings("unchecked")
	public static List<NESGame> fetchByPhoneCode(String code, PersistenceManager pm) {
		Query query = pm.newQuery("select from " + NESGame.class.getName() + " where phone_code==codeParam order by title asc ");
		query.declareParameters("String codeParam");
		return (List<NESGame>)query.execute(code);
	}
}