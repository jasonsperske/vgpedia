package net.vgpedia.models.nintendo.nes;

import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class NESGame {

    @PrimaryKey
    @Persistent
    private String guid;
    
	@Persistent
	private String group;
    
	@Persistent
	private String title;

	@Persistent
	private String phone_code;
	
	public NESGame(String guid, String group, String title, String phone_code) {
		this.guid = guid;
		this.group = group;
		this.title = title;
		this.phone_code = phone_code;
	}

	public String getGUID() {
		return guid;
	}

	public void setGUID(String guid) {
		this.guid = guid;
	}
	
	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getPhoneCode() {
		return phone_code;
	}

	public void setPhoneCode(String phone_code) {
		this.phone_code = phone_code;
	}
}
