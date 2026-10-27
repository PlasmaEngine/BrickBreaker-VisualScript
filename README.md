# Brick Breaker — VisualScript

A 3D Brick Breaker with the same table, controls and rules as the C++, C# and AngelScript versions, scripted the way a
VisualScript project is scripted in practice: four small graphs, each on the object it controls, talking through messages.
The scene, render pipeline and GameUI are authored assets. No gameplay C++ build, managed runtime or physics package is
required.

## Open in the editor

Requires Windows and Plasma Engine 0.11.2.

Get the project from the Plasma Launcher's **Samples** page (BrickBreaker, Visual Script), or clone this repository and
use **Add Existing Project**. The first time the editor opens it, it offers to install the packages listed in
`Editor/Packages.ddl` (VisualScript 1.3.2, GameUI 1.4.1 and Particles 1.9.1). Accept, and they are
installed into the project's `Plugins` folder. Then open `Scenes/Main.plScene` and play.

A/D or arrows move, Space or left click launches, P pauses, R restarts. Escape closes the standalone Player (that is the
engine's close key), so it is not a pause key here.

## Build and play without the editor

```powershell
.\Build.ps1 -Run
```

Or double-click `Play.cmd`. The script compiles the graphs, transforms the assets, and launches the engine's `Player.exe`.
It uses the engine the launcher assigned to this project and the packages the editor installed. Pass
`-SdkRoot 'C:\path\to\engine'` to use another engine, or `-GameUiRoot` and `-ScriptPackageRoot` to use built package
folders.

## The scripts

| Script | Lives on | Does | Nodes |
| --- | --- | --- | ---: |
| `Scripts/Paddle` | Paddle | Reads Left/Right from its own input component and slides along the table, clamped to the rails. | 24 |
| `Scripts/Ball` | Ball | Sits on the paddle until Space, then flies: bounces off the rails, the back wall and the paddle's top face (the hit offset sets the angle), drains below the table. | 121 |
| `Scripts/Brick` | Brick 1 … Brick 24 (one class, 24 instances) | Checks every frame whether the ball overlaps it, tells the ball which face it came through, counts hits and hides its mesh when spent. | 73 |
| `Scripts/GameManager` | Brick Breaker (root) | Lives, score, round state, Restart and Pause keys, and the HUD blackboard. | 127 |

The scripts never read each other's variables. They talk through `plMsgGenericEvent` messages:

| From | To | Message | Meaning |
| --- | --- | --- | --- |
| Brick | Ball | `PushLeft`, `PushRight`, `PushUp`, `PushDown` | Leave the brick through this face. The ball only turns around if it is still heading into the brick, so two bricks hit in the same frame cannot cancel each other out. |
| Brick | GameManager | `BrickDestroyed` | Score and remaining count. |
| Ball | GameManager | `BallLaunched`, `BallLost` | Round state and lives. |
| GameManager | every child (recursive) | `Reset`, `Pause`, `Resume` | Fresh table, freeze, unfreeze. Win and loss freeze the table with `Pause`; R sends `Reset`. |

Public script variables show up on the script component in the editor: `Speed` on the paddle, `InitialSpeed`,
`MaximumSpeed` and `SpeedUpPerBrick` on the ball, `Hits` on each brick (set it to 2 for a tougher brick), and
`StartingLives`, `BrickCount` and `PointsPerBrick` on the manager.

Objects are looked up where they are used (`GetParent`, `FindChildByName`, `FindComponentByTypeName`) rather than cached
in variables at start: the start event can run before neighbouring objects are ready, and the lookups are cheap.

## Edit the project

Open any script in the node editor. Execution runs left to right along a lane, the values a node needs sit below and to
the left of it, and a branch or event case that leaves the lane continues on a new lane underneath. Every graph has three
entry points: `OnSimulationStarted`, `Update` and the `OnMsgGenericEvent` handler with a string switch on the message name.

Edit `Scenes/Main.plScene` for the camera, lights and table; `UI/BrickBreakerHUD.plUiDocumentAsset` for the HUD; and
`RenderPipelines/BrickBreaker.plRenderPipelineAsset` for rendering. Keep object names and the table layout aligned when
changing the scene: the ball and the bricks use the same measurements as the other language versions.

## Things to know

- Do not add comment boxes to these graphs yet: the VisualScript transform currently fails on a document that contains one.
- An expression node needs at least one input; a constant-only expression fails to compile (its output type is never resolved).
