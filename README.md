# Compilação do projeto LaTeX

O projeto utiliza o `latexmk` para automatizar o processo de compilação. Ele executa o `pdflatex`, o `bibtex` e as passagens adicionais necessárias para resolver referências, citações e sumário.

## Comandos principais

| Comando          | Descrição                                                            |
| ---------------- | -------------------------------------------------------------------- |
| `make`           | Compila o projeto e gera/atualiza o arquivo `main.pdf`.              |
| `make pdf`       | Equivalente a `make`; gera ou atualiza `main.pdf`.                   |
| `make check`     | Verifica se `latexmk`, `pdflatex` e `bibtex` estão instalados.       |
| `make watch`     | Monitora alterações nos arquivos e recompila automaticamente.        |
| `make clean`     | Remove arquivos auxiliares da compilação, preservando `main.pdf`.    |
| `make distclean` | Remove os arquivos auxiliares e também `main.pdf`.                   |
| `make rebuild`   | Remove os arquivos gerados e realiza uma compilação completa.        |
| `make view`      | Compila o projeto e abre `main.pdf` no visualizador padrão do Linux. |

## Ferramentas utilizadas

### `latexmk`

O `latexmk` controla automaticamente todas as etapas necessárias para compilar o documento.

A compilação principal utilizada pelo projeto corresponde a:

```bash
latexmk -pdf -synctex=1 -interaction=nonstopmode -file-line-error -halt-on-error main.tex
```

As opções utilizadas são:

* `-pdf`: utiliza `pdflatex` para gerar o PDF;
* `-synctex=1`: habilita sincronização entre o código-fonte e o PDF;
* `-interaction=nonstopmode`: evita que a compilação fique parada aguardando interação do usuário;
* `-file-line-error`: exibe erros indicando o arquivo e a linha onde ocorreram;
* `-halt-on-error`: interrompe a compilação quando ocorre um erro LaTeX.

### `pdflatex`

O `pdflatex` é o compilador utilizado para transformar os arquivos `.tex` em PDF.

O `latexmk` executa o `pdflatex` automaticamente quantas vezes forem necessárias.

### `bibtex`

O `bibtex` processa o arquivo de referências bibliográficas do projeto:

```text
elementos-postextuais/referencias.bib
```

Ele também é chamado automaticamente pelo `latexmk` quando a bibliografia precisa ser atualizada.

## Limpeza dos arquivos auxiliares

Para remover arquivos auxiliares mantendo o PDF:

```bash
make clean
```

Esse comando utiliza:

```bash
latexmk -c main.tex
```

Para remover também o PDF:

```bash
make distclean
```

que utiliza:

```bash
latexmk -C main.tex
```

## Compilação automática durante a edição

O comando:

```bash
make watch
```

executa:

```bash
latexmk -pdf -synctex=1 -interaction=nonstopmode -file-line-error -halt-on-error -pvc main.tex
```

A opção `-pvc` mantém o `latexmk` monitorando os arquivos do projeto. Quando um arquivo `.tex`, `.bib` ou outra dependência é alterado, o documento é recompilado automaticamente.

## Fluxo de compilação

De forma simplificada, o `latexmk` executa automaticamente um fluxo equivalente a:

```text
pdflatex
   ↓
bibtex
   ↓
pdflatex
   ↓
pdflatex
   ↓
main.pdf
```

Passagens adicionais podem ser realizadas automaticamente sempre que forem necessárias para atualizar referências cruzadas, citações, sumário e outros elementos do documento.
