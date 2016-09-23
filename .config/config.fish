

# Promptline -----------------------------------------------------------------
function fish_prompt
  env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.shell_prompt.sh left
end

function fish_right_prompt
  env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.shell_prompt.sh right
end

set EDITOR /usr/bin/gedit
set TERM "xterm-256color"


# Phabricator ----------------------------------------------------------------
alias arc /opt/arcanist/arc


# DevOps stuff----------------------------------------------------------------
set -gx PATH ~/FBuildPy/NonVersioned $PATH
set -gx PATH ~/FBuildPy $PATH
set -gx PATH ~/FBuildTools $PATH


# Get TP rc ------------------------------------------------------------------
if test -f ~/.tpauthrc
   source ~/.tpauthrc
end


# Get Bugzilla rc ------------------------------------------------------------
if test -f ~/.bugauthrc
   source ~/.bugauthrc
end

# QA  ------------------------------------------------------------------------
set -gx QA_MODULES '/workspace/Katana/QA_Resources/Resources/Apps/Katana/Modules'
alias k 'python $QA_MODULES/FnKatanaLauncher.py'
alias ik 'python $QA_MODULES/FnKatanaInstaller.py'


# Aliases --------------------------------------------------------------------
alias nuke '/usr/local/Nuke9.0v6/Nuke9.0'
alias maya '/usr/autodesk/maya2015-x64/bin/maya'
alias kk 'k --vray=adv_161002_katana_2_0_linux_x64 --prman=20.5 --arnold=4.2.12.0 --force-search-path local --no-prman-netqa-shaders'
# navigation + git
alias qares 'cd /workspace/Katana/QA_Resources/Resources/Apps/Katana'
alias mydev 'cd /mnt/netdev/krzysztof.klimczyk'
alias testh 'cd /workspace/Katana/TestHarness/Tests/Apps/Katana'
alias sabre 'cd /workspace/Katana/sabre'
alias kgit 'cd /workspace/Katana/2.5dev/Apps/Katana'
alias dev 'cd /opt/Foundry/Katana2.5dev'
alias ggrep 'kgit;git grep'
alias gg 'git grep'
alias gs 'git status'
abbr -a gcm git checkout master
abbr -a gc21 git checkout KATANA_17A_45B_BRANCH
#
alias kdbuild 'cd /workspace/Katana/2.5dev;./FnBuild -j 16 FnOptType=debug FnInternalPlugins=1'
alias krbuild 'cd /workspace/Katana/2.5dev;./FnBuild -j 16 FnOptType=release'
alias kdebug "kk /workspace/Katana/2.5dev/Apps/Katana/objects/linux-64-x86-debug-410-gcc/Dist/"
alias krelease "kk /workspace/Katana/2.5dev/Apps/Katana/objects/linux-64-x86-release-410-gcc/Dist/"


# Jenkins --------------------------------------------------------------------
set -gx JENKINS_HOST jenkinsii


# Perforce -------------------------------------------------------------------
set -gx P4PORT perforce1:1669
set -gx P4USER krzysztof.klimczyk
set -gx P4CLIENT katana_main_test_danvers_krzysztof
set -gx P4IGNORE ~/.p4ignore

set -gx foundry_LICENSE 4101@mother
set -gx FOUNDRY_LICENSE_FILE /usr/local/foundry/RLM/foundry.license


# Sabre ----------------------------------------------------------------------
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib


# Maya -----------------------------------------------------------------------
set -gx MAYA_LICENSE Unlimited
set -gx MAYA_LICENSE_METHOD Network
set -gx MAYA_LOCATION /usr/autodesk/maya2015-x64/bin
set -gx PATH $PATH /usr/autodesk/maya2015-x64/bin
#set -gx PYTHONPATH $PYTHONPATH /lib64/python2.7/site-packages
# Maya Plugin
set -gx RMSTREE /opt/pixar/RenderManStudio-19.0-maya2015
set -gx MAYA_PLUG_IN_PATH $RMSTREE/plug-ins
set -gx MAYA_SCRIPT_PATH $RMSTREE/scripts
#set -gx XBMLANGPATH "$RMSTREE/icons/%B"


