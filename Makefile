MINIFY:=0
ELM_MAKE_FLAGS:=

.PHONY=all
all: dist/elm.js dist/index.html

.PHONY=clean
clean:
	rm -rf dist/*

.PHONY=dist
dist: MINIFY:=1
dist: ELM_MAKE_FLAGS += --optimize
dist: clean all

dist/index.html: src/index.html 
	cp $< $@

dist/elm.js: src/Main.elm
	@echo "Compiling $@ from $<"
	elm make $< --output=$@ $(ELM_MAKE_FLAGS)

.PHONY=watch
watch:
	@find src -name '*.elm' -or -name '*.html' | entr $(MAKE)
