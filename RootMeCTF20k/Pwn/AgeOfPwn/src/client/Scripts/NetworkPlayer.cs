using Godot;

public partial class NetworkPlayer : Player
{
    /* This is called when the server signals that this player bought a unit */
    public void OnUnitBought(int spawnPoint, UnitType unitType)
    {
        BuyUnit(unitType);
    }

    protected override void OnMoneyChanged(int value) { }
}
