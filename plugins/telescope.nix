{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
        ];
        set_env.COLORTERM = "truecolor";
      };
    };
  };
}
