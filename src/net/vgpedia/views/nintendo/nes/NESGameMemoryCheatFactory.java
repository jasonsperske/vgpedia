package net.vgpedia.views.nintendo.nes;

import java.util.Iterator;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.models.nintendo.nes.NESGameMemoryCheat;
import net.vgpedia.models.nintendo.nes.NESGameMemoryCheatTypes;

public class NESGameMemoryCheatFactory {
	@SuppressWarnings("unchecked")
	public static NESGameMemoryCheat fetch(NESGame game, String code, NESGameMemoryCheatTypes codetype, PersistenceManager pm) {
		NESGameMemoryCheat cheat = null;
		Query query = pm.newQuery("select from " + NESGameMemoryCheat.class.getName() + " where game==gameParam && code==codeParam && codetype==typeParam");
		query.declareParameters("String gameParam, String codeParam, NESGameMemoryCheatTypes typeParam");
		List<NESGameMemoryCheat> cheats = (List<NESGameMemoryCheat>) query.execute(game.getGUID(), code, codetype);
		Iterator<NESGameMemoryCheat> i = cheats.iterator();
		if(i.hasNext()) {
			cheat = i.next();
		}
		return cheat;
	}
}