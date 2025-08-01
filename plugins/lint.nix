{
  programs.nixvim.plugins = {
    lint = {
      enable = true;
      lintersByFt = {
        python = [ "pylint" ];
      };
    };
  };
}
