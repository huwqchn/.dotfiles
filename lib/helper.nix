{lib, ...}: let
  inherit (lib.trivial) mod;
  # Generate key bindings for a single workspace number using a list of command definitions
  mkWorkspaceBindings = commands: format: n: let
    # Calculate the digit key (1-9, 0 wraps at 10)
    wsDigit = mod n 10;
    key = toString wsDigit;
  in
    # Apply the format function to each command definition
    builtins.map (cmd: format cmd key (toString n)) commands;

  # Generate bindings for workspaces 1 through n, given a list of command definitions
  mkWorkspaces = commands: format: n:
    builtins.concatLists (
      builtins.genList (i: mkWorkspaceBindings commands format (i + 1)) n
    );

  # Example format function: Hyprland style
  hyprlandFormat = cmd: key: workspaceNum:
    lib.concatStringsSep ", " [
      cmd.modifier
      key
      cmd.action
      workspaceNum
    ];

  mkHyprWorkspaces = actions: n:
    mkWorkspaces [
      # Define the command definitions for workspace bindings
      {
        modifier = "$mod";
        action = builtins.elemAt actions 0;
      }
      {
        modifier = "$mod SHIFT";
        action = builtins.elemAt actions 1;
      }
      {
        modifier = "$mod CTRL";
        action = builtins.elemAt actions 2;
      }
    ]
    hyprlandFormat
    n;

  mkHyprMoveTo = actions: n:
    mkWorkspaces [
      {
        modifier = "$mod";
        action = builtins.elemAt actions 0;
      }
      {
        modifier = "$mod SHIFT";
        action = builtins.elemAt actions 1;
      }
    ]
    hyprlandFormat
    n;

  aerospaceFormat = cmd: key: workspaceNum: {
    name = "${cmd.modifier}-${key}";
    value = "${cmd.action} ${workspaceNum}";
  };

  mkAerospaceWorkspaces = n: let
    ws =
      mkWorkspaces [
        {
          modifier = "alt";
          action = "workspace";
        }
        {
          modifier = "alt-shift";
          action = "move-node-to-workspace";
        }
      ]
      aerospaceFormat
      n;
  in
    builtins.listToAttrs ws;

  vec2 = x: y: let
    x_str = toString x;
    y_str = toString y;
  in
    lib.strings.concatStringsSep " " [x_str y_str];

  getProgramName = program: builtins.baseNameOf program;

  toggle = program: let
    programName = getProgramName program;
  in ''
    if pgrep -x -u "$USER" -- "${programName}" >/dev/null 2>&1; then
      pkill  -x -u "$USER" -- "${programName}"
    else
      exec uwsm app -- "${program}"
    fi
  '';

  runOnce = program: let
    programName = getProgramName program;
  in ''
    if ! pgrep -x -u "$USER" -- "${programName}" >/dev/null 2>&1; then
      exec uwsm app -- "${program}"
    fi
  '';
in {
  inherit mkWorkspaces mkHyprWorkspaces mkHyprMoveTo mkAerospaceWorkspaces vec2 toggle runOnce;
}
