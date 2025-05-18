using Godot;
using Godot.Collections;

public partial class MapController : Node2D
{
    [Export]
    private CanvasLayer canvas;

    [Export]
    private Node2D SpawnPoint;


    private double _currentFrame = 0;
    private const double _frameRate = 1;
    private const float _spacingBetweenUnits = 40;

    [ExportGroup("Unit Properties")]
    [Export]
    private int _size = 15;
    [Export]
    private float _groundPixel;
    [Export]
    private float _leftPixel;
    [Export]
    private float _rightPixel;

    [ExportGroup("Player Properties")]
    [Export]
    private ProgressBar _leftProgressBar;
    [Export]
    private ProgressBar _rightProgressBar;

    private Dictionary<int, Unit> _leftUnits = new Dictionary<int, Unit>();
    private Dictionary<int, Unit> _rightUnits = new Dictionary<int, Unit>();
    private GameState _gameState;

    private ushort rand = 0xACE1;

    [Signal]
    public delegate void GameEndedEventHandler(bool leftLost);

    public void SetGameState(GameState gameState)
    {
        _gameState = gameState;
        rand = _gameState.Seed;
        _gameState.PlayerLeft.HealthChanged += OnLeftHealthChanged;
        _gameState.PlayerRight.HealthChanged += OnRightHealthChanged;
    }

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        _leftProgressBar.MaxValue = Player.FullHealth;
        _rightProgressBar.MaxValue = Player.FullHealth;
        _leftProgressBar.Value = Player.FullHealth;
        _rightProgressBar.Value = Player.FullHealth;
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
    {
        _currentFrame += delta;

        if (_currentFrame > _frameRate)
        {
            DoAllUpdates();
        }
    }

    public bool IsSpawnable(bool isLeft, int spawnPoint)
    {
        if (isLeft)
        {
            return !_leftUnits.ContainsKey(spawnPoint);
        }
        else
        {
            return !_rightUnits.ContainsKey(_size - spawnPoint - 1);
        }
    }

    public void SpawnUnit(bool isLeft, int spawnPoint, Unit unit)
    {
        SpawnPoint.AddChild(unit);

        if (isLeft)
        {
            unit.Position = GetPositionAtIndex(spawnPoint, true);
            _leftUnits.Add(spawnPoint, unit);
        }
        else
        {
            unit.Position = GetPositionAtIndex(_size - spawnPoint - 1, false);
            _rightUnits.Add(_size - spawnPoint - 1, unit);
        }
    }

    private void DoAllUpdates()
    {
        _currentFrame = 0;
        HandleMovements();
        HandleFights();
        if (HitBase())
        {
            return;
        }
        Restore();
        Salary();

    }

    private void HandleMovements()
    {
        // If on the last tile, we don't want to move anyway (tile nr. size does exist though!)
        int leftProgress = _size - 2;
        int rightProgress = 1;

        // We didn't go through the entire dict if thats true
        while (leftProgress > 0 || rightProgress < _size)
        {
            bool moved = false;
            if (NextMoveLeft())
            {
                // Iterate until a unit moved, or there are no units left
                while (!moved)
                {
                    // The furthest unit
                    if (_leftUnits.ContainsKey(leftProgress))
                    {
                        var unit = _leftUnits[leftProgress];
                        /*
                         * We only use it if
                         * - can move
                         * - no friendly unit on the next field
                         * - no enemy on the same field
                         */
                        if (unit.CanMove && !_leftUnits.ContainsKey(leftProgress + 1) && !_rightUnits.ContainsKey(leftProgress))
                        {
                            unit.Position = GetPositionAtIndex(leftProgress + 1, true);
                            _leftUnits.Add(leftProgress + 1, unit);
                            _leftUnits.Remove(leftProgress);
                            unit.CanMove = false;
                            moved = true;
                        }

                    }
                    // If we already checked zero in this round, there won't be
                    // any move by the left player
                    if (leftProgress <= 0)
                    {
                        moved = true;
                    }
                    leftProgress--;
                }
            }
            else
            {
                // Iterate until a unit moved, or there are none left
                while (!moved)
                {
                    // The furthest unit
                    if (_rightUnits.ContainsKey(rightProgress))
                    {
                        var unit = _rightUnits[rightProgress];
                        if (unit.CanMove && !_rightUnits.ContainsKey(rightProgress - 1) && !_leftUnits.ContainsKey(rightProgress))
                        {
                            unit.Position = GetPositionAtIndex(rightProgress - 1, false);
                            _rightUnits.Add(rightProgress - 1, unit);
                            _rightUnits.Remove(rightProgress);
                            unit.CanMove = false;
                            moved = true;
                        }
                    }
                    if (rightProgress >= _size)
                    {
                        moved = true;
                    }
                    rightProgress++;
                }
            }
        }
    }

    private void HandleFights()
    {
        // Here we want to start
        int leftProgress = _size - 1;
        int rightProgress = 0;

        while (leftProgress > 0 || rightProgress < _size)
        {
            bool fought = false;
            if (NextMoveLeft())
            {
                while (!fought)
                {
                    if (_leftUnits.ContainsKey(leftProgress))
                    {
                        var unit = _leftUnits[leftProgress];
                        /*
                         * Only fight if we can move and an enemy is on the same tile
                         */
                        if (unit.CanMove && _rightUnits.ContainsKey(leftProgress))
                        {
                            var rightUnit = _rightUnits[leftProgress];
                            bool leftDead = unit.TakeDamage(rightUnit.GetAttackStrength());
                            bool rightDead = rightUnit.TakeDamage(unit.GetAttackStrength());
                            if (leftDead)
                            {
                                _leftUnits.Remove(leftProgress);
                                _gameState.PlayerRight.GiveMoney(unit.GetBounty());
                                unit.QueueFree();
                            }
                            if (rightDead)
                            {
                                _rightUnits.Remove(leftProgress);
                                _gameState.PlayerLeft.GiveMoney(rightUnit.GetBounty());
                                rightUnit.QueueFree();
                            }
                            fought = true;
                            unit.CanMove = false;
                        }
                    }
                    if (leftProgress <= 0)
                    {
                        fought = true;
                    }
                    leftProgress--;
                }
            }
            else
            {
                while (!fought)
                {
                    if (_rightUnits.ContainsKey(rightProgress))
                    {
                        var unit = _rightUnits[rightProgress];
                        if (unit.CanMove && _leftUnits.ContainsKey(rightProgress))
                        {
                            var leftUnit = _leftUnits[rightProgress];
                            bool leftDead = leftUnit.TakeDamage(unit.GetAttackStrength());
                            bool rightDead = unit.TakeDamage(leftUnit.GetAttackStrength());
                            if (leftDead)
                            {
                                _leftUnits.Remove(rightProgress);
                                _gameState.PlayerRight.GiveMoney(leftUnit.GetBounty());
                                leftUnit.QueueFree();
                            }
                            if (rightDead)
                            {
                                _rightUnits.Remove(rightProgress);
                                _gameState.PlayerLeft.GiveMoney(unit.GetBounty());
                                unit.QueueFree();
                            }
                            fought = true;
                            unit.CanMove = false;
                        }
                    }
                    if (rightProgress >= _size)
                    {
                        fought = true;
                    }
                    rightProgress++;
                }
            }
        }
    }

    private bool HitBase()
    {
        if (_rightUnits.ContainsKey(0))
        {
            var unit = _rightUnits[0];
            if (unit.CanMove)
            {
                if (_gameState.PlayerLeft.TakeDamage(unit.GetAttackStrength()))
                {
                    EmitSignal(SignalName.GameEnded, true);
                    return true;
                }
            }
            unit.CanMove = false;
        }
        if (_leftUnits.ContainsKey(_size - 1))
        {
            var unit = _leftUnits[_size - 1];
            if (unit.CanMove)
            {
                if (_gameState.PlayerRight.TakeDamage(unit.GetAttackStrength()))
                {
                    EmitSignal(SignalName.GameEnded, false);
                    return true;
                }
            }
            unit.CanMove = false;
        }
        return false;
    }

    private void Restore()
    {
        foreach (var unit in _leftUnits.Values)
        {
            unit.CanMove = true;
        }
        foreach (var unit in _rightUnits.Values)
        {
            unit.CanMove = true;
        }
    }

    private void Salary()
    {
        _gameState.PlayerLeft.GiveMoney(Player.TickMoney);
        _gameState.PlayerRight.GiveMoney(Player.TickMoney);
    }

    private bool NextMoveLeft()
    {
        ushort bit;
        bit = (ushort)(((rand >> 0) ^ (rand >> 2) ^ (rand >> 3) ^ (rand >> 5)) & 1);
        rand = (ushort)((rand >> 1) | (bit << 15));
        return rand % 2 == 0;
    }

    private Vector2 GetPositionAtIndex(int i, bool isLeftUnit)
    {
        if (i < 0 || i >= _size)
        {
            throw new System.ArgumentOutOfRangeException();
        }

        float totalLength = _rightPixel - _leftPixel;
        float step = totalLength / (_size - 1);

        float offset = isLeftUnit ? -1 * _spacingBetweenUnits : _spacingBetweenUnits;


        return new Vector2(_leftPixel + i * step + offset, _groundPixel);
    }


    public void AddPlayer(Player player)
    {
        if (player is PlayerControl || player is NetworkPlayerControl)
        {
            if (canvas.GetChildCount() != 1)
            {
                GD.PushWarning("Trying to set the controller to a canvas with children.");
                return;
            }
            canvas.AddChild(player);
        }
        else
        {
            AddChild(player);
        }
    }

    /* Signal handlers */
    private void OnLeftHealthChanged(int newValue)
    {
        _leftProgressBar.Value = newValue;
    }

    private void OnRightHealthChanged(int newValue)
    {
        _rightProgressBar.Value = newValue;
    }

    public void OnTickUpdate(int leftMoney, int leftHealth, int rightMoney, int rightHealth,
    Dictionary<int, Dictionary<UnitType, int>> leftUnits, Dictionary<int, Dictionary<UnitType, int>> rightUnits)
    {
        // If we made an update long ago, make one now:
        if (_currentFrame > 0.8 * _frameRate) { DoAllUpdates(); }
        // else, we are probably on the same frame as the server
        else { _currentFrame = 0; }

        _gameState.PlayerLeft.SetMoney(leftMoney);
        _gameState.PlayerRight.SetMoney(rightMoney);

        _gameState.PlayerLeft.SetHealth(leftHealth);
        _gameState.PlayerRight.SetHealth(rightHealth);

        // Check if there exist units, which shouldn't
        foreach (var pos in _leftUnits.Keys)
        {
            if (!leftUnits.ContainsKey(pos))
            {
                GD.PushWarning("A unit on the left still exists, even though it shouldn't! Removing it...");
                _leftUnits[pos].QueueFree();
                _leftUnits.Remove(pos);
            }
        }

        // Check for wrong data or units that don't exist
        foreach (var pos in leftUnits.Keys)
        {
            (UnitType unitType, int health) unitInfo = GetTuple(leftUnits[pos]);

            if (!_leftUnits.ContainsKey(pos) || _leftUnits[pos].GetUnitType() != unitInfo.unitType)
            {
                // If there was a wrong unit, kill it
                if (_leftUnits.ContainsKey(pos))
                {
                    _leftUnits[pos].QueueFree();
                    _leftUnits.Remove(pos);
                }
                GD.PushWarning("Wrong unit or no unit on the left side!");
                // Either there is no unit, but should be, or there is the wrong one
                var newUnit = UnitFactory.GetInstance().GetUnit(unitInfo.unitType, true);
                SpawnUnit(true, pos, newUnit);

            }
            // No matter what, we set the health
            _leftUnits[pos].SetHealth(unitInfo.health);
        }

        // Once again for the right:
        // Check if there exist units, which shouldn't
        foreach (var pos in _rightUnits.Keys)
        {
            if (!rightUnits.ContainsKey(pos))
            {
                GD.PushWarning("A unit on the right still exists, even though it shouldn't! Removing it...");
                _rightUnits[pos].QueueFree();
                _rightUnits.Remove(pos);
            }
        }

        // (who cares about code duplication?)
        // Check for wrong data or units that don't exist
        foreach (var pos in rightUnits.Keys)
        {
            (UnitType unitType, int health) unitInfo = GetTuple(rightUnits[pos]);

            if (!_rightUnits.ContainsKey(pos) || _rightUnits[pos].GetUnitType() != unitInfo.unitType)
            {
                // If there was a wrong unit, kill it
                if (_rightUnits.ContainsKey(pos))
                {
                    _rightUnits[pos].QueueFree();
                    _rightUnits.Remove(pos);
                }
                GD.PushWarning("Wrong unit or no unit on the right side!");
                // Either there is no unit, but should be, or there is the wrong one
                var newUnit = UnitFactory.GetInstance().GetUnit(unitInfo.unitType, false);
                SpawnUnit(false, _size - 1 - pos, newUnit);

            }
            // No matter what, we set the health
            _rightUnits[pos].SetHealth(unitInfo.health);
        }

    }

    // Godot doesn't support pairs, so we just extract the first dict entry
    private (UnitType, int) GetTuple(Dictionary<UnitType, int> pair)
    {
        foreach (var unitType in pair.Keys)
        {
            return (unitType, pair[unitType]);
        }
        return (UnitType.NoUnit, 0);
    }
}
