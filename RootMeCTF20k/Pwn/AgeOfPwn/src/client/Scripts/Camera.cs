using Godot;
using System;

public partial class Camera : Camera2D
{
    private const float _threshold = 100;
    private const float _moveSpeed = 10;
    public override void _Process(double delta)
    {

        if (Input.IsActionPressed("move_right"))
        {
            GlobalPosition = new Vector2(GlobalPosition.X + _moveSpeed, GlobalPosition.Y);
        }
        else if (Input.IsActionPressed("move_left"))
        {
            GlobalPosition = new Vector2(GlobalPosition.X - _moveSpeed, GlobalPosition.Y);
        }
    }
}
