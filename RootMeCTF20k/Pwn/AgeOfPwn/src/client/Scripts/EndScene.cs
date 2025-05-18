using Godot;

public partial class EndScene : Control
{
    [Export]
    private Label label;
    [Export]
    private BoxContainer hints;

    public void SetGameOver(bool hasLost)
    {
        label.Text = hasLost ? "GAME OVER" : "YOU WON";
        hints.Visible = !hasLost;
    }

    private void OnButtonPressed()
    {
        // Show lobby
        GetTree().Root.GetNode<Lobby>("Lobby").Show();
        // kys
        QueueFree();
    }
}
