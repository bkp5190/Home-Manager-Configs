{
  programs.nixvim = {
    plugins.neoscroll = {
      enable = true;

      settings = {
        mappings = [
          "<C-u>"
          "<C-d>"
        ];
      };
    };
  };
}
