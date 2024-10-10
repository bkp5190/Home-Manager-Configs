{
  programs.nixvim = {
    plugins.markdown-preview = {
      enable = true;

      settings = {
        auto_close = 1;
        theme = "dark";
      };
    };
  };
}
