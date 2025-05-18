using Godot;

public partial class GameState : Node
{

    private Player _playerLeft;
    private Player _playerRight;
    private bool _hasPlayerLeft;
    private bool _hasPlayerRight;
    private MapController _map;
    private PackedScene _gameEndScene;
    public ushort Seed = 0xACE1;

    public Player PlayerLeft
    {
        set
        {
            _playerLeft = value;
            value.SetIsLeft(true);
            value.UnitBought += OnLeftSpawnUnit;
            _hasPlayerLeft = true;
        }
        get { return _playerLeft; }
    }

    public Player PlayerRight
    {
        set
        {
            _playerRight = value;
            value.SetIsLeft(false);
            value.UnitBought += OnRightSpawnUnit;
            _hasPlayerRight = true;
        }
        get { return _playerRight; }
    }

    private void LoadWorld()
    {
        var world = (PackedScene)GD.Load("res://Map.tscn");
        _gameEndScene = (PackedScene)GD.Load("res://GameEnd.tscn");
        GetTree().Root.AddChild(world.Instantiate());

        // Hide the lobby
        GetTree().Root.GetNode<Lobby>("Lobby").Hide();

        // Add the players to the map
        _map = GetTree().Root.GetNode<MapController>("Map");
        _map.AddPlayer(_playerLeft);
        _map.AddPlayer(_playerRight);
        _map.SetGameState(this);
        _playerLeft.SetMap(_map);
        _playerRight.SetMap(_map);
        _map.GameEnded += OnGameEnded;
    }

    public void BeginGame()
    {
        // At this point, a controller node for the local player
        // and a RemotePlayer should be set
        if (!_hasPlayerLeft || !_hasPlayerRight)
        {
            GD.PushWarning("Can't begin game: not both players are set!");
            return;
        }

        LoadWorld();
    }


    public void OnLeftSpawnUnit(int spawnPoint, Unit unit)
    {
        _map.SpawnUnit(true, spawnPoint, unit);
    }

    public void OnRightSpawnUnit(int spawnPoint, Unit unit)
    {
        _map.SpawnUnit(false, spawnPoint, unit);
    }

    private void OnGameEnded(bool leftLost)
    {
        // Unsubscribe from event
        _map.GameEnded -= OnGameEnded;

        var endScene = (EndScene)_gameEndScene.Instantiate();
        GetTree().Root.AddChild(endScene);

        if (_playerLeft is PlayerControl || _playerLeft is NetworkPlayerControl)
        {
            endScene.SetGameOver(leftLost);
        }
        else
        {
            endScene.SetGameOver(!leftLost);
        }

        _map.QueueFree();
        _playerLeft = null;
        _playerRight = null;
        _hasPlayerLeft = false;
        _hasPlayerRight = false;
    }

    public MapController GetMap()
    {
        return _map;
    }
}
