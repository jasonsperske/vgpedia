package net.vgpedia.views.nintendo.nes;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.models.nintendo.nes.NESGameImage;

public class NESGameFactory {
	@SuppressWarnings("unchecked")
	public static List<NESGame> findByCrc(String crc, PersistenceManager pm) {
		List<NESGame> games = new ArrayList<NESGame>();

		Query rom_query = pm.newQuery("select from " + NESGameImage.class.getName() + " where crc==crcParam");
		rom_query.declareParameters("String crcParam");
		List<NESGameImage> roms = (List<NESGameImage>)rom_query.execute(crc);

		if(!roms.isEmpty()) {
			Query game_query = pm.newQuery("select from " + NESGame.class.getName() + " where guid==guidParam order by title");
			game_query.declareParameters("String guidParam");
			for(NESGameImage rom : roms) {
				games.addAll((List<NESGame>)game_query.execute(rom.getGame()));
			}
		}

		return games;
	}
	
	@SuppressWarnings("unchecked")
	public static List<NESGame> findByTitle(String title, PersistenceManager pm) {
		Query query = pm.newQuery("select from " + NESGame.class.getName() + " where title==titleParam");
		query.declareParameters("String titleParam");
		return (List<NESGame>)query.execute(title);
	}
}
