{
  lib,
  config,
  ...
}:
{
  options = {
    gitModule.enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf config.gitModule.enable {
    
    programs.git-credential-oauth.enable = true;
    programs.gitui.enable = true;

    # https://www.youtube.com/watch?v=G3NJzFX6XhY

    programs.diff-so-fancy.enable = true;
    programs.diff-so-fancy.enableGitIntegration = true;
    programs.diff-so-fancy.settings.markEmptyLines = true;

    programs.git = {
      enable = true;

      settings = {

        user.name = "edensiiln";
	user.email = "siiln@protonmail.com";

        core.editor = "nvim";
        core.whitespace = "trailing-space,space-before-tab";

        url."git@github.com:".insteadOf = "gh";
        url."git@github.com:edensiiln/".insteadOf = "en";
        url."git@github.com/Xysspon/".insteadOf = "xysspon";

        status.branch = true;
        status.showStash = true;
        status.showUntrackedFiles = "all";

        diff.context = 3;
        diff.renames = "copies";
        diff.interHunkContext = 10;

        pager.diff = "diff-so-fancy | $PAGER";

        #diff-so-fancy.markEmptyLines = false;

        #interactive.diffFilter = lib.mkForce "diff-so-fancy --patch";
        interactive.singleKey = true;

        push.autoSetupRemote = true;
        push.default = "current";
        push.followTags = true;

        pull.default = "current";
        pull.rebase = true;

        rebase.autoStash = true;
        rebase.missingCommitsCheck = "warn";

        log.abbrevCommit = true;
        log.graphColors = "blue,yellow,cyan,magenta,green,red";

        color.decorate.HEAD = "red";
        color.decorate.branch = "blue";
        color.decorate.tag = "yellow";
        color.decorate.remoteBranch = "magenta";

        color.branch.current = "magenta";
        color.branch.local = "default";
        color.branch.remote = "yellow";
        color.branch.upstream = "green";
        color.branch.plain = "blue";

        branch.sort = "-committerdate";

        tag.sort = "-taggerdate";

        pager.branch = false;
        pager.tag = false;
      };
    };
  };
}
