package net.vgpedia.models.nintendo.nes;

public enum NESGameMemoryCheatTypes {
	TIP("Tip"), GAMEGENIE("GameGenie"), PROACTIONREPLAY("ProActionReplay");

	private final String displayName;
    
	private NESGameMemoryCheatTypes(String displayName) {
        this.displayName = displayName;
    }

	public String toString() {
		return displayName;
	}
}