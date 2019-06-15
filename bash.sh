#!/bin/sh
BASHRC=~/.bashrc
BASHPROF=~/.bash_profile
BASHRC_TMP=~/.bashrc_tmp
BASHPROF_TMP=~/.bash_profile_tmp
ICEBERG_TERMINAL=https://gist.github.com/cocopon/a04be63f5e0856daa594702299c13160/archive/dd2499198fd1f5e1373167769f7da28a7e1a2152.zip

cat << EOF > $BASHRC_TMP
# default:cyan / root:red
if [ $UID -eq 0 ]; then
    PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
else
    PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
fi

# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示
alias ls='ls -FG'
alias ll='ls -alFG'
EOF

cat <<EOF2 > $BASHPROF_TMP
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
EOF2

sed -e '/EOF/d' $BASHRC_TMP > $BASHRC
sed -e '/EOF2/d' $BASHPROF_TMP > $BASHPROF

rm $BASHRC_TMP
rm $BASHPROF_TMP

brew install wget
wget $ICEBERG_TERMINAL -O ~/Downloads/iceberg.zip
unzip ~/Downloads/iceberg.zip -d ~/Downloads/Iceberg/
ICEBERG=`find ~/Downloads/Iceberg | grep .terminal`

TERM_PROFILE="Iceberg"
open "$ICEBERG"
defaults write com.apple.Terminal "Default Window Settings" -string "$TERM_PROFILE"
defaults write com.apple.Terminal "Startup Window Settings" -string "$TERM_PROFILE"
defaults write com.apple.Terminal TerminalOpaqueness 0.9
defaults import com.apple.Terminal "$HOME/Library/Preferences/com.apple.Terminal.plist"

cat <<EOF3 >> $BASHRC

if [ $UID -eq 0 ]; then
    PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
else
    PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
fi
EOF3

sed -e '/EOF/d' $BASHRC
