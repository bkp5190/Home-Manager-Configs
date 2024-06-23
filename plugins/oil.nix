{
  programs.nixvim.plugins = {
    oil = {
      enable = true;
      settings = {
        skip_confirm_for_simple_edits = true;
        keymaps = {
        "<C-l>" = false;
        "<C-r>" = "actions.refresh";
        "y." = "actions.copy_entry_path";
        };
      };
    };
  };
}
