using Godot;

public partial class Lobby : Control
{
	private GameState _gameState;
	private NetworkManager _networkManager;
	[ExportGroup("UI")]
	[Export]
	private Button _playButton;

	[Export]
	private LineEdit _ipLineEdit;
	[Export]
	private LineEdit _portLineEdit;
	[Export]
	private Button _hostButton;
	[Export]
	private LineEdit _lobbyIdEdit;
	[Export]
	private Button _joinButton;
	[Export]
	private Label _errorLabel;

	[ExportGroup("Scenes")]
	[Export]
	private PackedScene _playerControl;
	[Export]
	private PackedScene _bot;
	[Export]
	private PackedScene _networkPlayer;
	[Export]
	private PackedScene _networkPlayerControl;

	private bool _thisJoined = false;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_gameState = GetNode<GameState>("/root/GameState");
		_networkManager = GetNode<NetworkManager>("/root/NetworkManager");
	}

	private void OnPlayPressed()
	{
		_gameState.PlayerRight = (Bot)_bot.Instantiate();

		// Instantiate the player control as a scene
		_gameState.PlayerLeft = (PlayerControl)_playerControl.Instantiate();
		_gameState.BeginGame();
	}

	private void OnHostPressed()
	{
		int port;
		int lobby;
		if (!int.TryParse(_portLineEdit.Text, out port))
		{
			_errorLabel.Text = "Port is invalid!";
			return;
		}

		switch (_networkManager.Host(_ipLineEdit.Text, port, out lobby))
		{
			case NetworkManager.Error.Success:
				_errorLabel.Text = $"Lobby created with ID: {lobby}";
				_lobbyIdEdit.Text = lobby.ToString();
				_networkManager.ClientJoined += OnClientJoined;
				_networkManager.GameStarted += OnGameStarted;
				break;
			case NetworkManager.Error.ServerError:
				_errorLabel.Text = "Server encountered an error :(";
				break;
			case NetworkManager.Error.ConnectionError:
				_errorLabel.Text = "Connection failed :(";
				break;
			case NetworkManager.Error.InvalidIP:
				_errorLabel.Text = "Invalid IP :(";
				break;
			default:
				_errorLabel.Text = "Something went wrong";
				break;
		}
	}

	// If we host and the opponent joins
	public void OnClientJoined()
	{
		_errorLabel.Text = "Client joined!";
	}

	private void OnJoinPressed()
	{
		int port;
		int lobby;
		if (!int.TryParse(_portLineEdit.Text, out port))
		{
			_errorLabel.Text = "Port is invalid!";
			return;
		}
		else if (!int.TryParse(_lobbyIdEdit.Text, out lobby))
		{
			_errorLabel.Text = "Lobby is invalid!";
			return;
		}

		switch (_networkManager.Join(_ipLineEdit.Text, port, lobby))
		{
			case NetworkManager.Error.Success:
				_errorLabel.Text = $"Successfully joined {lobby}";
				_thisJoined = true; // So we know that we have to be on the right
				_networkManager.GameStarted += OnGameStarted;
				break;
			case NetworkManager.Error.LobbyNotExist:
				_errorLabel.Text = $"Lobby {lobby} does not exist";
				break;
			case NetworkManager.Error.InvalidIP:
				_errorLabel.Text = $"Invalid IP :(";
				break;
			default:
				_errorLabel.Text = "Something went wrong";
				break;
		}
	}

	public void OnGameStarted()
	{
		GD.Print("lobby noticed that the game started");
		var networkPlayerControl = (NetworkPlayerControl)_networkPlayerControl.Instantiate();
		var networkPlayer = (NetworkPlayer)_networkPlayer.Instantiate();

		// If we joined, the control needs to be on the right
		if (_thisJoined)
		{
			_gameState.PlayerLeft = networkPlayer;
			_gameState.PlayerRight = networkPlayerControl;
		}
		else
		{
			_gameState.PlayerLeft = networkPlayerControl;
			_gameState.PlayerRight = networkPlayer;
		}
		networkPlayerControl.UnitBought += _networkManager.OnLocalUnitBought;
		_networkManager.RemotePlayerBoughtUnit += networkPlayer.OnUnitBought;

		_gameState.Seed = (ushort)(_networkManager.LobbyId & 0xFFFF);
		_gameState.BeginGame();
		_errorLabel.Text = "";
		_networkManager.TickUpdated += _gameState.GetMap().OnTickUpdate;
	}

	private void OnQuitPressed()
	{
		GetTree().Quit();
	}
}
