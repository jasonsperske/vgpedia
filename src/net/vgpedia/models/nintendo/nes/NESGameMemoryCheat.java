package net.vgpedia.models.nintendo.nes;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.users.User;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class NESGameMemoryCheat {
	@PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Key key;
    
	@Persistent
    private String game;
    
	@Persistent
    private String code;
	
	@Persistent
    private String description;
	
	@Persistent
    private NESGameMemoryCheatTypes codetype;
	
	@Persistent
	private User author;
	
	public NESGameMemoryCheat(NESGame game, String code, String description, NESGameMemoryCheatTypes codetype, User author) {
		this.game = game.getGUID();
		this.code = code;
		this.description = description;
		this.codetype = codetype;
		this.author = author;
	}
	
	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public Key getKey() {
		return key;
	}

	public void setKey(Key key) {
		this.key = key;
	}

	public String getGame() {
		return game;
	}

	public void setGame(String game) {
		this.game = game;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public NESGameMemoryCheatTypes getCodetype() {
		return codetype;
	}

	public void setCodetype(NESGameMemoryCheatTypes codetype) {
		this.codetype = codetype;
	}
}