{
  programs.nixvim.plugins = {
    obsidian = {
      enable = true;
      settings = {
        workspaces = [
          {
            name = "notes";
            path = "~/Documents/OMSCS Notes";
          }
        ];
      };
    };
  };
}
