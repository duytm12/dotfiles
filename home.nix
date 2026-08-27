{  config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # cli i use constantly
    ripgrep   # fast search
    fd        # fast find
    fzf       # fuzzy finder
    jq        # json on the command line
    awscli2   # aws cli v2
    lazygit
    neovim
    zoxide    # cd replacement with learning
    # node.js toolchain
    nodejs_22 # node runtime + npm
    pnpm      # fast, disk-efficient package manager
    # the font everything renders in
    nerd-fonts.hack
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
  };
  # put pnpm global binaries on PATH
  home.sessionPath = [ "${config.home.homeDirectory}/.local/share/pnpm" ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;      # ghost text from history
    syntaxHighlighting.enable = true;  # commands turn green when valid
    initContent = ''
      bindkey '^f' autosuggest-accept
      eval "$(zoxide init zsh)"
    '';
    shellAliases = {
      ".." = "cd ..";
      # shortcuts
      k = "kiro";
      kc = "kiro-cli";
      kc3 = "kiro-cli --v3";
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gpush = "git push";
      gpull = "git pull";
      c = "clear";
      he = "herdr";
      dbx = "databricks";
      tf = "terraform";
      ll = "ls -la";
      la = "ls -a";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.git = {
    enable = true;
    # Global default identity = company (applies everywhere).
    settings.user = {
      name = "Billy-IDF";
      email = "minhduy.truong@wnco.com";
    };
    # Personal identity = only for repos under ~/github/.
    includes = [
      {
        condition = "gitdir:~/github/";
        contents.user = {
          name = "Bi";
          email = "duytm112@gmail.com";
        };
      }
    ];
  };

  home.file.".config/starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/starship.toml";

  # Global npm / pnpm settings.
  home.file.".npmrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.npmrc";

  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr";
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.claude/settings.json";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".codex/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".config/opencode/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";

  # Kiro CLI + Kiro IDE: global steering via the AGENTS.md standard.
  # Both read ~/.kiro/steering/; AGENTS.md files are always included, no frontmatter needed.
  home.file.".kiro/steering/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
}
