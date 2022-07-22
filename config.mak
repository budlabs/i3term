NAME         := i3term
CREATED      := 2022-07-14
UPDATED      := today
VERSION      := 0
DESCRIPTION  := short description for the script
AUTHOR       := budRich
CONTACT      := https://github.com/budlabs
ORGANISATION := budlabs
USAGE        := $(NAME) [OPTIONS]

PREFIX       ?= /usr

.PHONY: manpage
manpage: $(MANPAGE)

MANPAGE      := $(NAME).1

$(MANPAGE): config.mak $(CACHE_DIR)/help_table.txt
	@$(info making $@)
	uppercase_name=$(NAME)
	uppercase_name=$${uppercase_name^^}
	{
		echo "# $$uppercase_name "           \
				 "$(manpage_section) $(UPDATED)" \
				 "$(ORGANISATION) \"User Manuals\""

	  printf '%s\n' '## NAME' \
								  '$(NAME) - $(DESCRIPTION)' \
	                '## OPTIONS'

	  cat $(CACHE_DIR)/help_table.txt

	} | go-md2man > $@


README.md: $(CACHE_DIR)/help_table.txt
	@$(making $@)
	{
	  cat $(CACHE_DIR)/help_table.txt
	} > $@

$(CACHE_DIR)/_$(NAME).out: $(MONOLITH)
	sed 's|@@DATA_DIR@@|$(PREFIX)/share/$(NAME)|' $< >$@

.PHONY: install uninstall

installed_script    := $(DESTDIR)$(PREFIX)/bin/$(NAME)
installed_license   := $(DESTDIR)$(PREFIX)/share/licenses/$(NAME)/LICENSE
installed_manpage   := \
	$(DESTDIR)$(PREFIX)/share/man/man$(subst .,,$(suffix $(MANPAGE)))/$(MANPAGE)

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
