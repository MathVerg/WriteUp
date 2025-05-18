using Godot;
using System;
using System.Net;
using System.Net.Sockets;
using System.Threading.Tasks;
using Godot.Collections;


public partial class NetworkManager : Node
{
    private TcpClient client;

    [Signal]
    public delegate void GameStartedEventHandler();

    [Signal]
    public delegate void ClientJoinedEventHandler();

    [Signal]
    public delegate void RemotePlayerBoughtUnitEventHandler(int spawnPoint, UnitType type);

    [Signal]
    public delegate void TickUpdatedEventHandler(int leftMoney, int leftHealth, int rightMoney, int rightHealth,
    Dictionary<int, Dictionary<UnitType, int>> leftUnits, Dictionary<int, Dictionary<UnitType, int>> rightUnits);

    public int LobbyId { get; private set; }

    private int _pingIntervalSec = 10;

    // Internal stuff
    public enum Error
    {
        Success,
        InvalidIP,
        ConnectionError, // If we can't reach the server
        ServerError, // If server sends back an error
        LobbyNotExist,
        UnknownError
    }

    /**
     * On host we send a 32-bit integer with -1 for the lobbyId
     * and get the ID of a new lobby back - a 32-bit integer.
     *
     * If the lobby ID from the server is -1, the server wasn't able to
     * create a lobby.
     */
    public Error Host(string ipString, int port, out int lobbyId)
    {
        lobbyId = -1;
        try
        {
            client = new TcpClient(ipString, port);
            byte[] data = BitConverter.GetBytes(NetworkManagerConstants.CreateLobby);
            client.GetStream().Write(data, 0, data.Length);
            // Receive the id of the new lobby
            if (client.GetStream().Read(data, 0, data.Length) != 4)
            {
                return Error.ConnectionError;
            }
            lobbyId = BitConverter.ToInt32(data);
            if (lobbyId == -1)
            {
                return Error.ServerError;
            }
            LobbyId = lobbyId;
            Task.Run(() => WaitForOtherClient());
            return Error.Success;
        }
        catch (FormatException)
        {
            GD.PushWarning($"Illegal ip string: \"{ipString}\"");
            return Error.InvalidIP;
        }
        catch (SocketException e)
        {
            GD.PushWarning($"Connection failed: {e.Message}");
            return Error.ConnectionError;
        }
    }

    /**
     * If some other player already created the lobby, we can join
     * by sending the lobby ID. On success, we get the lobby ID back.
     *
     * We now start listening for game packets
     */
    public Error Join(string ipString, int port, int lobbyId)
    {
        try
        {
            client = new TcpClient(ipString, port);
            byte[] data = BitConverter.GetBytes(lobbyId);
            client.GetStream().Write(data, 0, data.Length);
            // Receive the id to confirm join
            if (client.GetStream().Read(data, 0, data.Length) != 4)
            {
                return Error.ConnectionError;
            }
            int receivedLobbyId = BitConverter.ToInt32(data);
            if (receivedLobbyId == lobbyId)
            {
                LobbyId = lobbyId;
                Task.Run(() => Read());
                Task.Run(() => Ping());
                return Error.Success;
            }
            else if (receivedLobbyId == -1)
                return Error.LobbyNotExist;
            else
                return Error.UnknownError;
        }
        catch (FormatException)
        {
            GD.PushWarning($"Illegal ip string: \"{ipString}\"");
            return Error.InvalidIP;
        }
        catch (SocketException e)
        {
            GD.PushWarning($"Connection failed: {e.Message}");
            return Error.ConnectionError;
        }
    }

    /**
     * Once the server created a lobby, we wait until a client joins
     * (signaled by the lobby id again)
     *
     * If no client joins after some time, we get -1 and the lobby
     * creation failed.
     */
    private async Task WaitForOtherClient()
    {
        var stream = client.GetStream();
        byte[] lobbyIdBuf = new byte[4];
        await stream.ReadAsync(lobbyIdBuf, 0, lobbyIdBuf.Length);

        // TODO probably error handling, if -1 or something
        GD.Print("Other client joined!");

        CallDeferred("emit_signal", "ClientJoined");
        Task.WaitAll(Read(), Ping());
    }

    /**
     * Once we are here, we can listen for actual game packets,
     * we are now connected to the game server.
     *
     * Every packet we send and receive has the following structure:
     * - uint16: size of remaining packet
     * - uint16: packet type (see NetworkManagerConstants)
     * - (...): type specific data
     */
    private async Task Read()
    {
        GD.Print("Started reading!");
        NetworkStream stream = client.GetStream();
        byte[] sizeBuffer = new byte[2];
        while (true)
        {
            int bytesRead = await stream.ReadAsync(sizeBuffer, 0, sizeBuffer.Length);

            if (bytesRead == 0)
            {
                return;  // Stream closed
            }

            GD.Print($"Received {bytesRead} bytes form the server!");

            ushort sizeOfPacket = BitConverter.ToUInt16(sizeBuffer);
            GD.Print($"Packet size is: {sizeOfPacket}");
            byte[] rest = new byte[sizeOfPacket];
            if (sizeOfPacket != stream.Read(rest, 0, rest.Length))
            {
                GD.PushWarning($"Only received {sizeOfPacket} bytes instead of the expected {sizeOfPacket}. Ignoring...");
                continue;
            }
            var packetType = (NetworkManagerConstants.PacketType)BitConverter.ToUInt16(rest);
            GD.Print($"Received packet: {packetType}");
            switch (packetType)
            {
                case NetworkManagerConstants.PacketType.GAME_START:
                    CallDeferred("emit_signal", "GameStarted");
                    break;
                case NetworkManagerConstants.PacketType.OPPO_BUY_UNIT:
                    var unit = BitConverter.ToUInt16(rest, 2);
                    CallDeferred("emit_signal", "RemotePlayerBoughtUnit", 0, unit);
                    break;
                case NetworkManagerConstants.PacketType.TICK_UPDATE:
                    HandleTickUpdate(rest);
                    break;
                default:
                    GD.PushWarning($"Packet type handler of {packetType} not implemented!");
                    break;
            }
        }
    }

    /*
     * Ping the server every couple of seconds
     */
    private async Task Ping()
    {
        byte[] packet = CreateGamePacket(new byte[0], NetworkManagerConstants.PacketType.PING);
        client.GetStream().Write(packet, 0, packet.Length);
        client.GetStream().Flush();
        await Task.Delay(_pingIntervalSec * 1000);
        await Ping();
    }


    /*
     * Functions for handling local events and sending them to the server
     */
    public void OnLocalUnitBought(int spawnPoint, Unit unit)
    {
        byte[] data = BitConverter.GetBytes((ushort)unit.GetUnitType());
        data = CreateGamePacket(data, NetworkManagerConstants.PacketType.BUY_UNIT);
        GD.Print($"Network manager noticed that a unit was bought. data legth: {data.Length}");
        client.GetStream().Write(data, 0, data.Length);
        client.GetStream().Flush();
    }

    private byte[] CreateGamePacket(byte[] data, NetworkManagerConstants.PacketType type)
    {
        byte[] len = BitConverter.GetBytes((ushort)data.Length + 2);
        byte[] typ = BitConverter.GetBytes((ushort)type);
        byte[] res = new byte[4 + data.Length];
        len.CopyTo(res, 0);
        typ.CopyTo(res, 2);
        data.CopyTo(res, 4);
        return res;
    }

    /*
     * This is just used to sync the client, if he predicted something wrong
     */
    private void HandleTickUpdate(byte[] data)
    {
        int leftMoney = BitConverter.ToInt32(data, 2);
        int leftHealth = BitConverter.ToInt32(data, 6);

        int rightMoney = BitConverter.ToInt32(data, 10);
        int rightHealth = BitConverter.ToInt32(data, 14);

        int idx;
        var leftUnits = ParseUnits(data, true, 18, out idx);
        var rightUnits = ParseUnits(data, false, idx, out idx);

        CallDeferred("emit_signal", "TickUpdated", leftMoney, leftHealth, rightMoney, rightHealth, leftUnits, rightUnits);
    }

    private Dictionary<int, Dictionary<UnitType, int>> ParseUnits(byte[] data, bool isLeft, int startIdx, out int endIdx)
    {
        var result = new Dictionary<int, Dictionary<UnitType, int>>();

        endIdx = startIdx;
        for (int i = 0; i < 15; i++)
        {
            var unit = (UnitType)data[endIdx];
            endIdx++;
            if (unit != UnitType.NoUnit)
            {
                var health = BitConverter.ToInt32(data, endIdx);
                if (isLeft)
                {
                    result.Add(i, new Dictionary<UnitType, int>{{unit, health}});
                }
                else
                {
                    result.Add(14 - i, new Dictionary<UnitType, int>{{unit, health}});
                }
                endIdx += 4;
            }
        }
        return result;
    }
}
