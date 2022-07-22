NAME         := i3term
CREATED      := 2022-07-14
UPDATED      := 2022-07-22
VERSION      := 2022.07.22
DESCRIPTION  := launch terminals with i3run
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs/i3term
ORGANISATION := budlabs
LICENSE      := 0BSD
USAGE        := $(NAME) [OPTIONS]

PREFIX       ?= /usr

MANPAGE_DEPS =                       \
	$(CACHE_DIR)/help_table.txt        \
	$(CACHE_DIR)/long_help.md          \
	$(wildcard $(DOCS_DIR)/examples/*) \
	$(DOCS_DIR)/links.md               \
	$(CACHE_DIR)/copyright.txt

manpage_section = 1
MANPAGE = $(NAME).$(manpage_section)
.PHONY: manpage
manpage: $(MANPAGE)

$(MANPAGE): config.mak $(MANPAGE_DEPS) 
	@$(info making $@)
	uppercase_name=$(NAME)
	uppercase_name=$${uppercase_name^^}
	{
		# this first "<h1>" adds "corner" info to the manpage
		echo "# $$uppercase_name "           \
				 "$(manpage_section) $(UPDATED)" \
				 "$(ORGANISATION) \"User Manuals\""

		# main sections (NAME|OPTIONS..) should be "<h2>" (##), sub (###) ...
	  printf '%s\n' '## NAME' \
								  '$(NAME) - $(DESCRIPTION)'

		echo "## USAGE"
		echo '`$(USAGE)`'
		# cat $(DOCS_DIR)/description.md
		echo "## OPTIONS"
		sed 's/^/    /g' $(CACHE_DIR)/help_table.txt
		cat $(CACHE_DIR)/long_help.md

		echo "## EXAMPLES"
		cat $(DOCS_DIR)/examples/*

		printf '%s\n' '## CONTACT' \
			"Send bugs and feature requests to:  " "$(CONTACT)/issues"

		printf '%s\n' '## COPYRIGHT'
		cat $(CACHE_DIR)/copyright.txt
		cat $(DOCS_DIR)/links.md

	} | go-md2man > $@

README_DEPS =                        \
	$(CACHE_DIR)/help_table.txt        \
	$(CACHE_DIR)/long_help.md          \
	$(wildcard $(DOCS_DIR)/examples/*) \
	$(DOCS_DIR)/links.md               \
	$(DOCS_DIR)/readme_install.md      \
	$(DOCS_DIR)/readme_banner.md       \
	$(DOCS_DIR)/links.md

README.md: $(README_DEPS)
	@$(making $@)
	{
	  cat $(DOCS_DIR)/readme_banner.md
	  echo "## installation"
	  cat $(DOCS_DIR)/readme_install.md
	  echo "## usage"
	  echo '```'
	  echo '$(USAGE)'
	  cat "$(CACHE_DIR)/help_table.txt"
	  echo '```'
	  echo "## examples"
	  cat $(DOCS_DIR)/examples/*
	  cat $(DOCS_DIR)/links.md
	} > $@

$(CACHE_DIR)/_$(NAME).out: $(MONOLITH)
	sed 's|@@DATA_DIR@@|$(PREFIX)/share/$(NAME)|' $< >$@

.PHONY: install uninstall

installed_script    := $(DESTDIR)$(PREFIX)/bin/$(NAME)
installed_license   := $(DESTDIR)$(PREFIX)/share/licenses/$(NAME)/LICENSE
installed_manpage   := \
	$(DESTDIR)$(PREFIX)/share/man/man$(manpage_section)/$(MANPAGE)

DATA_DIR := $(DESTDIR)$(PREFIX)/share/$(NAME)

install: $(CACHE_DIR)/_$(NAME).out all
	install -Dm644 $(MANPAGE)                $(installed_manpage)
	install -Dm755 $(CACHE_DIR)/_$(NAME).out $(installed_script)
	install -Dm644 LICENSE                   $(installed_license)
	install -Dm644 data/palettes/*        -t $(DATA_DIR)/palettes
	install -Dm644 data/config            -t $(DATA_DIR)

uninstall:
	rm $(installed_script)
	rm -rf $(DATA_DIR)
	rm $(installed_manpage)
	rm $(installed_license)
	rmdir $(dir $(installed_license))
