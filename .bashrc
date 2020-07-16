# グローバルな設定ファイルが存在するなら読み込む 
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# コマンドプロンプトのカスタマイズ
export PS1='\[\e[35m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\] \[\e[32m\][\w]\[\e[0m\] \$ '
