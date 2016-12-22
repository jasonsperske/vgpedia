package net.vgpedia.views.nintendo.nes;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import net.vgpedia.models.nintendo.nes.NESGame;
import net.vgpedia.models.nintendo.nes.NESGameImage;

public class NESGameImagesFactory {
	@SuppressWarnings("unchecked")
	public static List<NESGameImage> fetch(NESGame game, PersistenceManager pm) {
		Query query = pm.newQuery("select from " + NESGameImage.class.getName() + " where game==gameParam order by title");
		query.declareParameters("String gameParam");
		return (List<NESGameImage>)query.execute(game.getGUID());
	}
}
