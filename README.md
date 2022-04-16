Este repositório contém a minha configuração do [neovim](https://neovim.io/), um editor de texto livre de terminal. Todos os arquivos que a integram fazem parte do domínio público, como expresso pela [UNLICENSE](https://unlicense.org/). Portanto, se você encontrar qualquer utilidade para eles, sinta-se livre para usá-los como bem entender.

A versão mínima do neovim requerida para esta configuração é a 0.7.0, que atualmente é a versão estável mais recente do editor. No Fedora Linux, você pode baixá-la adicionando [este copr](https://copr.fedorainfracloud.org/coprs/agriffis/neovim-nightly/). Com a versão correta do neovim instalada, o único passo necessário para ativar a config é cloná-la no diretório correto.

```sh
$ mkdir ~/.config/nvim
# Clone diretamente com o git:
$ git clone https://github.com/eduardo-antunes/vimrc ~/.config/nvim
# Ou com a CLI oficial do github:
$ gh repo clone eduardo-antunes/vimrc ~/.config/nvim
```
