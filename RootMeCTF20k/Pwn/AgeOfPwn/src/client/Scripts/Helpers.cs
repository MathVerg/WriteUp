public partial class Helpers
{
    public static string IntToMoney(int value)
    {
        int dollars = value / 100;
        int cents = value % 100;

        return $"${dollars}.{cents:D2}";
    }
}
