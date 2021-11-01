zinit snippet PZT::modules/helper/init.zsh

# oh-my-zshのセットアップ
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit cdclear -q

# プロンプトのカスタマイズ
setopt promptsubst
zinit snippet OMZT::gnzh
zinit light agnoster/agnoster-zsh-theme # <- ここで好きなテーマのGitHubリポジトリを Group/Repository で指定。

# 補完
zinit light zsh-users/zsh-autosuggestions

# シンタックスハイライト
# zinit light zdharma/fast-syntax-highlighting

# Ctrl+r でコマンド履歴を検索
# zinit light zdharma/history-search-multi-word
