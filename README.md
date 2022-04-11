Este repositório contém a minha configuração do [neovim](https://neovim.io/), um editor de texto livre de terminal. Todos os arquivos que a integram fazem parte do domínio público, como expresso pela [UNLICENSE](https://unlicense.org/). Portanto, se você encontrar qualquer utilidade para eles, sinta-se livre para usá-los como bem entender.

A versão mínima do neovim requerida para esta configuração é a 0.7.0, que atualmente é a versão nigthly do editor. No Fedora Linux, você pode baixá-la adicionando [este copr](https://copr.fedorainfracloud.org/coprs/agriffis/neovim-nightly/). Com a versão correta do neovim instalada, há apenas dois passos para acionar a config: clonar este repositório no diretório correto e instalar o [packer](https://github.com/wbthomason/packer.nvim), o gerenciador de plugins que eu uso.

```sh
$ mkdir ~/.config/nvim
$ git clone https://github.com/eduardo-antunes/vimrc ~/.config/nvim
$ git clone https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
