# === CUSTOMIZABLE PROJECT-SPECIFIC SETTINGS ===
# Settings can be changed by editing the quoted values. The quotes must be kept.
# Spaces are allowed, special characters are not.
# To reference other variables, wrap them like $(THIS) and use their exact name.
# More information on each setting is available in the ENVIRONMENT.md file
#
# Unless you know what you're doing, only edit this section (marked by ===).*
# *You may also modify any lines starting with "#", since they're just comments.
# If you do know what you're doing, consider making a fork of the template!

# == METADATA ==
NAME = "Project"
TYPE = "project"
SCRATCH_PROJECT_ID = ""
# == END OF METADATA ==

# == PROJECT STRUCTURE ==
SRC_DIR = "src"
ASSETS_DIR = "assets"
OUT_DIR = "dist"
OUT_FILE_LOCATION = $(OUT_DIR)
# == END OF PROJECT STRUCTURE ==

# don't edit below this line unless you know what you're doing!*
# === END OF CUSTOMIZABLE PROJECT-SPECIFIC SETTINGS ===

# == COMMANDS ==
FORMAT_COMMAND = "prettier" "--write"
OPEN_BROWSER_COMMAND = "xdg-open"
MAKE_COMMAND = "make"
REMOVE_EXTRA_SLASHES_COMMAND = sed -E "s|(.*)//([^/]*)$$|\1/\2|"
# == END OF COMMANDS ==

# == SCRATCH WEBSITE
SCRATCH_BASE_URL = "https://scratch.mit.edu"
SCRATCH_PROJECT_URL = $(SCRATCH_BASE_URL)"/projects/"$(SCRATCH_PROJECT_ID)
# == END OF SCRATCH WEBSITE ==

# ==SCRATCH FILE FORMAT==
HASH_ALGORYTHM = md5
ASSETS_OUT_DIR = $(OUT_DIR)"/assets"
OUT_JSON_FILE = $(TYPE)".json"
OUT_FILE_EXTENSION := $(shell if [ "$(TYPE)" = "project" ]; then echo "sb3"; else echo "sprite3"; fi)

OUT_FILE = $(OUT_FILE_LOCATION)/$(NAME).$(OUT_FILE_EXTENSION)
# ==END OF SCRATCH FILE FORMAT==

TEMP := $(shell mktemp -d)

extract: "$(SRC_DIR)" "$(ASSETS_DIR)"
	@echo 'Extracting "$(OUT_JSON_FILE)" and assets from "$(OUT_FILE)"...'
	unzip -q "$(OUT_FILE)" -d "$(TEMP)"
	mv "$(TEMP)"/"$(OUT_JSON_FILE)" $(SRC_DIR)/$(OUT_JSON_FILE)
	mv "$(TEMP)"/* "$(ASSETS_DIR)"/
	rm -rf "$(TEMP)"

format:
	@echo 'Formatting $(OUT_JSON_FILE)...'
	prettier --write $(SRC_DIR)/$(OUT_JSON_FILE)

build: clean "$(SRC_DIR)" "$(ASSETS_DIR)" "$(OUT_DIR)" "$(ASSETS_OUT_DIR)"
	@echo 'Building project "$(NAME)"...'
	zip $(OUT_FILE) $(SRC_DIR)/$(OUT_JSON_FILE)
	for file in $(ASSETS_DIR)/*; do \
		[ -f "$$file" ] || continue; \
		ext=$${file##*.}; \
		base=$$(basename "$$file"); \
		hash=$$($(HASH_ALGORYTHM)sum "$$file" | cut -d' ' -f1); \
		target_name="$$hash.$$ext"; \
		target_path="$(ASSETS_OUT_DIR)/$$target_name"; \
		if [ "$$base" != "$$target_name" ] && [ ! -f "$$target_path" ]; then \
			cp "$$file" "$$target_path"; \
		else \
			target_path="$$file"; \
		fi; \
		zip -j $(OUT_FILE) "$$target_path"; \
	done
	sha256sum $(OUT_FILE)

clean:
	@echo 'Cleaning up build files and temp dir...'
	rm -f "$(OUT_DIR)"/"$(NAME)"."$(OUT_FILE_EXTENSION)"
	rm -rf "$(ASSETS_OUT_DIR)"/*.*
	rm -rf "$(TEMP)"

check-browser-command:
	@if ! command -v "$(OPEN_BROWSER_COMMAND)" &> /dev/null; then \
		echo 'Error: Open command "$(OPEN_BROWSER_COMMAND)" not found.'; \
		exit 1; \
	fi

check-project-id:
	@if [ -z "$(SCRATCH_PROJECT_ID)" ]; then \
		echo 'Error: SCRATCH_PROJECT_ID is not set.'; \
		echo 'Please set it in the Makefile before running this target.'; \
		exit 1; \
	fi

open: check-browser-command check-project-id
	@echo 'Opening project page in Scratch...'
	$(OPEN_BROWSER_COMMAND) $(SCRATCH_PROJECT_URL)

edit: check-browser-command
	@if $(MAKE_COMMAND) check-project-id; then \
		echo 'Opening project in Scratch editor...'; \
	else \
		echo 'Creating new project in Scratch...'; \
	fi

	$(OPEN_BROWSER_COMMAND) "$$( \
		echo "$(SCRATCH_PROJECT_URL)/editor" | $(REMOVE_EXTRA_SLASHES_COMMAND) \
	)"


# Ensure necessary directories exist
%:
	@echo Creating directory $@...
	mkdir -p $@
