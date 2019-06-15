#!/bin/sh
BASHRC=~/.bashrc
BASHPROF=~/.bash_profile
ICEBERG_TERMINAL=https://gist.github.com/cocopon/a04be63f5e0856daa594702299c13160/archive/dd2499198fd1f5e1373167769f7da28a7e1a2152.zip

cat << EOF > $BASHRC
# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示
alias ls='ls -FG'
alias ll='ls -alFG'

EOF

cat <<EOF2 > $BASHPROF
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
EOF2

sed -e '/EOF/d' $BASHRC
sed -e '/EOF2/d' $BASHPROF

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
sed -e '/EOF3/d' $BASHRC

wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
chmod a+x ~/.git-completion.bash
echo "source ~/.git-completion.bash" >> $BASHRC
source $BASHRC

wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
chmod a+x ~/.git-prompt.sh
echo "source ~/.git-prompt.sh" >> $BASHRC
source $BASHRC

cat <<EOF3 >> $BASHRC

# プロンプトに各種情報を表示
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1

############### ターミナルのコマンド受付状態の表示変更
# \u ユーザ名
# \h ホスト名
# \W カレントディレクトリ
# \w カレントディレクトリのパス
# \n 改行
# \d 日付
# \[ 表示させない文字列の開始
# \] 表示させない文字列の終了
# \$ $
EOF3

echo "PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]\$(__git_ps1)\[\033[00m\] \$ '" >> $BASHRC

cat <<EOF >> $BASHRC
osascript \
-e 'tell application "Terminal"' \
-e 'set bounds of front window to {1, 1, 1000, 800}' \
-e 'end tell'
EOF

brew install tig

source $BASHRC

