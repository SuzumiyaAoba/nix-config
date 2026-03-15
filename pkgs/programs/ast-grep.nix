{ ast-grep }:
ast-grep.overrideAttrs (old: {
  doCheck = false;
  doInstallCheck = old.doInstallCheck or false;
})
