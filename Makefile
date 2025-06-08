# metadata (customizable)

# used for name of binary file
# spaces allowed
NAME = Project
# project or sprite
# must be lowercase
TYPE = project

# project structure (customizable)
SRC_DIR = src
ASSETS_DIR = assets
BIN_DIR = bin
BIN_ASSETS_DIR = "$(BIN_DIR)"/assets

# zip file structure
ZIP_JSON_FILE = "$(TYPE)".json
ZIP_FILE_EXTENSION := $(shell if [ "$(TYPE)" = "project" ]; then echo "sb3"; else echo "sprite3"; fi)

ZIP_FILE = "$(BIN_DIR)"/"$(NAME)"."$(ZIP_FILE_EXTENSION)"
TEMP := $(shell mktemp -d)

extract: "$(SRC_DIR)" "$(ASSETS_DIR)"
	@echo 'Extracting "$(ZIP_JSON_FILE)" and assets from "$(ZIP_FILE)"...'
	unzip -q "$(ZIP_FILE)" -d "$(TEMP)"
	mv "$(TEMP)"/"$(ZIP_JSON_FILE)" "$(SRC_DIR)"/"$(ZIP_JSON_FILE)"
	mv "$(TEMP)"/* "$(ASSETS_DIR)"/
	rm -rf "$(TEMP)"

format:
	@echo 'Formatting $(ZIP_JSON_FILE)...'
	prettier --write "$(SRC_DIR)"/"$(ZIP_JSON_FILE)"

build: clean "$(SRC_DIR)" "$(ASSETS_DIR)" "$(BIN_DIR)" "$(BIN_ASSETS_DIR)"
	@echo 'Building project "$(NAME)"...'
	zip "$(ZIP_FILE)" "$(SRC_DIR)/$(ZIP_JSON_FILE)"
	for file in $(ASSETS_DIR)/*; do \
		[ -f "$$file" ] || continue; \
		ext=$${file##*.}; \
		base=$$(basename "$$file"); \
		hash=$$(md5sum "$$file" | cut -d' ' -f1); \
		target_name="$$hash.$$ext"; \
		target_path="$(BIN_ASSETS_DIR)/$$target_name"; \
		if [ "$$base" != "$$target_name" ] && [ ! -f "$$target_path" ]; then \
			cp "$$file" "$$target_path"; \
		else \
			target_path="$$file"; \
		fi; \
		zip -j "$(ZIP_FILE)" "$$target_path"; \
	done
	sha256sum "$(ZIP_FILE)"

clean:
	@echo 'Cleaning up build files and temp dir...'
	rm -f "$(BIN_DIR)"/"$(NAME)"."$(ZIP_FILE_EXTENSION)"
	rm -rf "$(BIN_ASSETS_DIR)"/*.*
	rm -rf "$(TEMP)"


# Ensure necessary directories exist
"$(SRC_DIR)":
	@echo 'Creating "$(SRC_DIR)" directory...'
	mkdir -p "$(SRC_DIR)"
"$(ASSETS_DIR)":
	@echo 'Creating "$(ASSETS_DIR)" directory...'
	mkdir -p "$(ASSETS_DIR)"
"$(BIN_DIR)":
	@echo 'Creating "$(BIN_DIR)" directory...'
	mkdir -p "$(BIN_DIR)"
"$(BIN_ASSETS_DIR)":
	@echo 'Creating "$(BIN_ASSETS_DIR)" directory...'
	mkdir -p "$(BIN_ASSETS_DIR)"