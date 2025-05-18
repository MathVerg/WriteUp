using Godot;
using System.Collections.Generic;

/* Units use the Factory Pattern */
public enum UnitType : ushort
{
    NoUnit = 0,
    Skull = 1,
    Cat = 2,
    Dog = 3,
}

/// <summary>
/// Unity Factory, which already instantiates the scenes
/// </summary>
public class UnitFactory
{
    private static UnitFactory _instance;
    private static bool _hasInstance = false;

    // All scenes
    private Dictionary<UnitType, PackedScene> _scenes = new Dictionary<UnitType, PackedScene>();

    public static UnitFactory GetInstance()
    {
        if (!_hasInstance)
        {
            _instance = new UnitFactory();
            _instance._scenes.Add(UnitType.Skull, (PackedScene)GD.Load("res://Units/Skull.tscn"));
            _instance._scenes.Add(UnitType.Cat, (PackedScene)GD.Load("res://Units/Cat.tscn"));
            _instance._scenes.Add(UnitType.Dog, (PackedScene)GD.Load("res://Units/Dog.tscn"));
            _hasInstance = true;
        }
        return _instance;
    }

    public Unit GetUnit(UnitType type, bool isLeft)
    {
        PackedScene unitScene;
        if (!_scenes.TryGetValue(type, out unitScene))
        {
            GD.PushError($"Unknown unit: {type}");
            return null;
        }
        var unit = (Unit)unitScene.Instantiate();
        GD.Print($"Factory produced {type}: {unit.GetInstanceId()}!");
        unit.SetLeft(isLeft);
        return unit;
    }
}

public partial class Unit : CharacterBody2D
{
    public bool CanMove { get; set; }
    private Color _blue = new Color("14213D");
    private Color _red = new Color("7C3626");

    [Export]
    private Node2D _sprite;

    [Export]
    private int _attackStrength;
    [Export]
    private int _bounty;
    [Export]
    public int Health { get; private set; }
    [Export]
    private UnitType _unitType;

    public static int GetUnitPrice(UnitType type)
    {
        switch (type)
        {
            case UnitType.Skull:
                return 1500;
            case UnitType.Cat:
                return 10000;
            case UnitType.Dog:
                return 50000;
            default:
                GD.PushError($"Unknown unit: {type}");
                return int.MaxValue;
        }
    }

    // Returns true if dead
    public bool TakeDamage(int damage)
    {
        Health -= damage;
        return Health < 0;
    }

    public void SetHealth(int health)
    {
        if (Health != health)
        {
            Health = health;
            GD.PushWarning("Health of unit mismatched!");
        }
    }

    internal void SetLeft(bool isLeft)
    {
        if (!isLeft)
        {
            _sprite.ApplyScale(new Vector2(-1, 1));
        }
    }
    public int GetAttackStrength() { return _attackStrength; }
    public int GetBounty() { return _bounty; }
    public UnitType GetUnitType() { return _unitType; }
}
