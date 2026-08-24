{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.edenGit = {
    pkgs,
    lib,
    ...
  }: {

    #programs.gitui.enable = true;
    #programs.git-credential-oauth.enable = true;

    programs.git = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.edenGit;
    };
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.edenGit = inputs.wrapper-modules.wrappers.git.wrap {
      inherit pkgs;
        settings = {
          user.name = "edensiiln";
          user.email = "siiln@protonmail.com";

          core.editor = lib.getExe pkgs.neovim;
          core.whitespace = "trailing-space,space-before-tab";

          url."git@github.com:".insteadOf = "gh";
          url."git@github.com:edensiiln".insteadOf = "en";
          url."git@github.com:xysspon".insteadOf = "xysspon";

          status.branch = true;
          status.showStash = true;
          status.showUntrackedFiles = "all";

          diff.context = 3;
          diff.renames = "copies";
          diff.interHunkContext = 10;

          #pager.diff = "diff-so-fancy | $PAGER";

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

          signing.format = "openpgp";
      };
    };
  };
}
