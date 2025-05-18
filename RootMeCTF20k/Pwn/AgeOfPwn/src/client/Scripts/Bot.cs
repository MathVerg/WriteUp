using Godot;

public partial class Bot : Player
{
    private double _nextBuy;
    private double _currentDelta;
    private const double _minBuyRange = 2.5;
    private const double _maxBuyRange = 10;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        MoneyChanged += OnMoneyChanged;
        GD.Randomize();
        _nextBuy = 1;
    }

    public override void _Process(double delta)
    {
        _currentDelta += delta;
        if (_currentDelta > _nextBuy)
        {
            _currentDelta = 0;
            _nextBuy = GD.RandRange(_minBuyRange, _maxBuyRange);
            BuyUnit(UnitType.Skull);
        }
    }

    protected override void OnMoneyChanged(int newValue) { }
}
