{
  config,
  lib,
  pkgs,
  ...
}:

let
  files = ../../files;
  configFiles = files + "/config";
  homeFiles = files + "/home";

  recursiveConfig = name: {
    source = configFiles + "/${name}";
    recursive = true;
  };

  commonConfigDirectories = [
    "alacritty"
    "fish"
    "fuchi"
    "ghostty"
    "herdr"
    "nvim"
    "tmux"
    "wezterm"
    "zellij"
  ];
  darwinConfigDirectories = [
    "aerospace"
    "borders"
    "iterm"
    "raycast"
    "sketchybar"
    "skhd"
    "yabai"
    "yashiki"
  ];

  claudeInstructions = builtins.readFile (files + "/claude/CLAUDE.md");
  codexInstructions = lib.replaceStrings [ "# CLAUDE.md" ] [ "# AGENTS.md" ] claudeInstructions;
  codexConfigFilter = files + "/codex/ensure-status-line.sh";
in
{
  home.file = {
    ".gitconfig".source =
      if pkgs.stdenv.hostPlatform.isDarwin then
        homeFiles + "/.gitconfig-darwin"
      else
        homeFiles + "/.gitconfig-linux";
    ".gitignore".source = homeFiles + "/.gitignore";
    ".hushlogin".source = homeFiles + "/.hushlogin";
    ".ideavimrc".source = homeFiles + "/.ideavimrc";
    ".tmux.conf".source = homeFiles + "/.tmux.conf";
    "zettelkasten/.obsidian.vimrc".source = homeFiles + "/zettelkasten/.obsidian.vimrc";

    ".claude/CLAUDE.md".source = files + "/claude/CLAUDE.md";
    ".claude/settings.json".source = files + "/claude/settings.json";
    ".claude/statusline.sh" = {
      source = files + "/claude/statusline.sh";
      executable = true;
    };

    ".codex/AGENTS.md".text = codexInstructions;
  };

  xdg.configFile =
    lib.genAttrs commonConfigDirectories recursiveConfig
    // {
      "starship.toml".source = configFiles + "/starship.toml";
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin (
      lib.genAttrs darwinConfigDirectories recursiveConfig
    );

  home.activation.ensureCodexStatusLine = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config_dir="$HOME/.codex"
    config_file="$config_dir/config.toml"

    if [[ -n "''${DRY_RUN_CMD:-}" ]]; then
      echo "Would ensure Codex status-line settings in $config_file"
    else
      mkdir -p "$config_dir"
      tmp_file=$(mktemp "$config_dir/.config.toml.XXXXXX")
      trap 'rm -f "$tmp_file"' EXIT

      if [[ -f "$config_file" ]]; then
        ${pkgs.bash}/bin/bash ${codexConfigFilter} < "$config_file" > "$tmp_file"
      else
        ${pkgs.bash}/bin/bash ${codexConfigFilter} < /dev/null > "$tmp_file"
      fi

      if [[ ! -f "$config_file" ]] || ! cmp -s "$tmp_file" "$config_file"; then
        chmod 600 "$tmp_file"
        mv "$tmp_file" "$config_file"
      fi

      trap - EXIT
      rm -f "$tmp_file"
    fi
  '';
}
