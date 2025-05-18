using Godot;

public partial class PlayerControl : Player
{
    [Export]
    private Label _moneyLabel;

    public override void _Ready()
    {
        MoneyChanged += OnMoneyChanged;
    }

    protected override void OnMoneyChanged(int newValue)
    {
        _moneyLabel.Text = Helpers.IntToMoney(newValue);
    }

    private void OnBuySkullUnitPressed()
    {
        BuyUnit(UnitType.Skull);
    }

    private void OnBuyCatUnitPressed()
    {
        BuyUnit(UnitType.Cat);
    }

    private void OnBuyDogUnitPressed()
    {
        BuyUnit(UnitType.Dog);
    }
}
