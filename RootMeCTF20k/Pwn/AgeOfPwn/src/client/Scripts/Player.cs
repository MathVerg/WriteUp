using Godot;
using System;

/** This node represents a player and emits actions.
    It can be controlled by different entities, such as a bot, the network or a GUI
*/
public abstract partial class Player : Node
{
    public const int TickMoney = 500;
    public const int FullHealth = 100;

    public int Money { get; private set; } = 10000;
    private MapController _map;
    private bool _isLeft;
    private bool _isLeftSet;
    private int _health = FullHealth;

    [Signal]
    public delegate void UnitBoughtEventHandler(int spawnPoint, Unit unit);

    [Signal]
    public delegate void MoneyChangedEventHandler(int newValue);

    [Signal]
    public delegate void HealthChangedEventHandler(int newValue);

    public void SetIsLeft(bool isLeft)
    {
        _isLeft = isLeft;
        _isLeftSet = true;
    }

    public void SetMap(MapController map)
    {
        _map = map;
    }

    /*
     * Little helper function to modify money, while checking that
     * we are rich enough
     */
    private bool Buy(int price)
    {
        if (price > Money)
        {
            GD.Print("Too expensive!");
            return false;
        }

        Money -= price;
        EmitSignal(SignalName.MoneyChanged, Money);
        return true;
    }

    public void GiveMoney(int amount)
    {
        Money += amount;
        EmitSignal(SignalName.MoneyChanged, Money);
    }

    public void SetMoney(int amount)
    {
        if (amount != Money)
        {
            Money = amount;
            EmitSignal(SignalName.MoneyChanged, Money);
            GD.PushWarning("There was a money mismatch!");
        }
    }

    public void SetHealth(int health)
    {
        if (health != _health)
        {
            _health = health;
            EmitSignal(SignalName.HealthChanged, _health);
            GD.PushWarning("There was a health mismatch!");
        }
    }

    public bool TakeDamage(int amount)
    {
        _health -= amount;
        EmitSignal(SignalName.HealthChanged, _health);
        return _health <= 0;
    }


    /* Signal handlers */
    protected abstract void OnMoneyChanged(int newValue);

    public void BuyUnit(UnitType type)
    {
        int price = Unit.GetUnitPrice(type);

        if (!_isLeftSet)
        {
            throw new FieldAccessException("Don't know whether player is on the left");
        }

        if (!_map.IsSpawnable(_isLeft, 0))
        {
            GD.Print("Field is already occupied");
            return;
        }

        if (!Buy(price))
        {
            return;
        }

        GD.Print($"Bought {type}");

        EmitSignal(SignalName.UnitBought, 0, UnitFactory.GetInstance().GetUnit(type, _isLeft));
    }
}
