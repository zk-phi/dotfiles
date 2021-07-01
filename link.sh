ln -s -i $(PWD)/zsh/.zshenv ~/.zshenv
ln -s -i $(PWD)/zsh/.zshrc ~/.zshrc
ln -s -i $(PWD)/zsh/.zsh.d ~/.zsh.d

ln -s -i $(PWD)/hyper/.hyper.js ~/.hyper.js

ln -s -i $(PWD)/git/.gitconfig ~/.gitconfig
ln -s -i $(PWD)/git/.gitignore_global ~/.gitignore_global
ln -s -i $(PWD)/git/.git_template ~/.git_template

mkdir ~/.emacs.d
ln -s -i $(PWD)/emacs/.emacs.d/init.el ~/.emacs.d/init.el
ln -s -i $(PWD)/emacs/.emacs.d/early-init.el ~/.emacs.d/early-init.el
ln -s -i $(PWD)/emacs/.emacs.d/snippets ~/.emacs.d/snippets

rm -r /Applications/Emacs.app/Contents/Resources/site-lisp
ln -s -i $(PWD)/emacs/site-lisp /Applications/Emacs.app/Contents/Resources/site-lisp

ln -s -i $(PWD)/asdf/.asdfrc ~/.asdfrc
ln -s -i $(PWD)/asdf/.tool-versions ~/.tool-versions
