# Makefile para o projeto de TCC
# Documento principal: main.tex
# Fluxo: latexmk -> pdflatex + bibtex + passagens adicionais necessárias

MAIN       := main
TEX        := $(MAIN).tex
PDF        := $(MAIN).pdf
LATEXMK    := latexmk
LATEXMKOPT := -pdf -synctex=1 -interaction=nonstopmode -file-line-error -halt-on-error

.PHONY: all pdf check watch clean distclean rebuild view help

# Compilação padrão
all: pdf

# Gera/atualiza o PDF.
# O latexmk controla automaticamente as dependências do projeto,
# incluindo \input, imagens, bibliografia e referências cruzadas.
pdf: check
	$(LATEXMK) $(LATEXMKOPT) $(TEX)

# Confere se as ferramentas necessárias estão disponíveis.
check:
	@command -v $(LATEXMK) >/dev/null 2>&1 || { echo "Erro: latexmk não encontrado no PATH."; exit 1; }
	@command -v pdflatex   >/dev/null 2>&1 || { echo "Erro: pdflatex não encontrado no PATH."; exit 1; }
	@command -v bibtex     >/dev/null 2>&1 || { echo "Erro: bibtex não encontrado no PATH."; exit 1; }

# Monitora os arquivos e recompila automaticamente quando houver alterações.
watch: check
	$(LATEXMK) $(LATEXMKOPT) -pvc $(TEX)

# Remove arquivos auxiliares, preservando o PDF.
clean:
	$(LATEXMK) -c $(TEX)

# Remove arquivos auxiliares e também o PDF gerado.
distclean:
	$(LATEXMK) -C $(TEX)

# Força uma compilação completa desde o início.
rebuild: distclean pdf

# Abre o PDF no visualizador padrão do Linux.
view: pdf
	@xdg-open $(PDF) >/dev/null 2>&1 &

help:
	@echo "Alvos disponíveis:"
	@echo "  make           - gera/atualiza main.pdf"
	@echo "  make pdf       - gera/atualiza main.pdf"
	@echo "  make check     - verifica latexmk, pdflatex e bibtex"
	@echo "  make watch     - recompila automaticamente ao editar"
	@echo "  make clean     - remove auxiliares e preserva o PDF"
	@echo "  make distclean - remove auxiliares e o PDF"
	@echo "  make rebuild   - limpa tudo e recompila"
	@echo "  make view      - compila e abre o PDF"
