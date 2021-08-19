.PHONY: tags cscope

all: tags cscope

tags:
	@echo "[GEN] tags"
	@ctags -R --exclude=@.ctagsignore

# I like to have separate src and include directories. This generates cscope
# files for those
cscope:
	@echo "[GEN] cscope"
	@find . \
		\( -path "./src/*" -o -path "./include/*" \) \
		\( -name "*.[ch]" -o -name "*.cpp" \) \
		-print > $(PWD)/cscope.files
	@cscope -b -q -k
