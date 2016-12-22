package net.vgpedia.models;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.Text;

import java.text.DateFormat;
import java.util.Date;
import javax.jdo.annotations.*;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class NewsItem {
    @PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Key key;

	@Persistent
    private String title;

    @Persistent
    private Text body;

    @Persistent
    private Date postedAt;

	public NewsItem(String title, Text body, Date postedAt) {
		this.title = title;
		this.body = body;
		this.postedAt = postedAt;
	}

	public Key getKey() {
		return key;
	}

    public void setKey(Key key) {
		this.key = key;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Text getBody() {
		return body;
	}

	public void setBody(Text body) {
		this.body = body;
	}

	public String getFormattedPostedAt(DateFormat formatter) {
		return formatter.format(postedAt);
	}
	
	public Date getPostedAt() {
		return postedAt;
	}

	public void setPostedAt(Date postedAt) {
		this.postedAt = postedAt;
	}
}