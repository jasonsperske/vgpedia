package net.vgpedia.views.nintendo.nes;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.models.nintendo.nes.NESGameMemoryCheat;

public class NESGameMemoryCheatsFactory {
	@SuppressWarnings("unchecked")
	public static List<NESGameMemoryCheat> fetch(NESGame game, PersistenceManager pm) {
		Query query = pm.newQuery("select from " + NESGameMemoryCheat.class.getName() + " where game==gameParam order by description");
		query.declareParameters("String gameParam");
		return (List<NESGameMemoryCheat>)query.execute(game.getGUID());
	}
}
