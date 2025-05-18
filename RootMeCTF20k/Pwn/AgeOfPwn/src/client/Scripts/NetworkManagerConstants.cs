using System.Net;
using System.Net.Sockets;

public static class NetworkManagerConstants
{
    public const int CreateLobby = -1;

    public enum PacketType : ushort
    {
        ERROR = 0xff,

        BUY_UNIT = 0x10,
        OPPO_BUY_UNIT = 0x11,
        TICK_UPDATE = 0x1f,

        VICTORY = 0x30,
        DEFEAT = 0x31,
        FORFEIT = 0x32,
        VICTORY_BY_FORFEIT = 0x33,
        GAME_START = 0x3F,

        PING = 0x42,
    }

    // Copied from https://stackoverflow.com/a/150974/9820072
    public static int FreeTcpPort()
    {
        TcpListener l = new TcpListener(IPAddress.Loopback, 0);
        l.Start();
        int port = ((IPEndPoint)l.LocalEndpoint).Port;
        l.Stop();
        return port;
    }
}
