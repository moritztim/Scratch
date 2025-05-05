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

# zip file structure
ZIP_JSON_FILE = "$(TYPE)".json
ZIP_FILE_EXTENSION := $(shell if [ "$(TYPE)" = "project" ]; then echo "sb3"; else echo "sprite3"; fi)

ZIP_FILE = "$(BIN_DIR)"/"$(NAME)"."$(ZIP_FILE_EXTENSION)"
TEMP := $(shell mktemp -d)

extract: "$(SRC_DIR)" "$(ASSETS_DIR)"
	@echo 'Extracting "$(ZIP_FILE)"...'
	@unzip -q "$(ZIP_FILE)" -d "$(TEMP)"
	@echo 'Moving project file to "$(SRC_DIR)"'
	@mv "$(TEMP)"/"$(ZIP_JSON_FILE)" "$(SRC_DIR)"/"$(ZIP_JSON_FILE)"
	@echo 'Moving assets to "$(ASSETS_DIR)"'
	@mv "$(TEMP)"/* "$(ASSETS_DIR)"/
	@echo 'Cleaning up temp directory...'
	@rm -rf "$(TEMP)"

format:
	@echo 'Formatting $(ZIP_JSON_FILE)...'
	@prettier --write "$(SRC_DIR)"/"$(ZIP_JSON_FILE)"

build: clean "$(SRC_DIR)" "$(ASSETS_DIR)" "$(BIN_DIR)"
	@echo 'Building "$(NAME)"...'
	@cd "$(SRC_DIR)" && zip -r ../"$(ZIP_FILE)" ./*
	@cd "$(ASSETS_DIR)" && zip -r ../"$(ZIP_FILE)" ./*
	@echo 'Build complete.'
	@sha256sum "$(ZIP_FILE)"

clean:
	@echo 'Cleaning up build file and temp dir...'
	@rm -f "$(BIN_DIR)"/"$(NAME)"."$(ZIP_FILE_EXTENSION)"
	@rm -rf "$(TEMP)"

# Ensure necessary directories exist
"$(SRC_DIR)":
	@echo 'Creating "$(SRC_DIR)" directory...'
	@mkdir -p "$(SRC_DIR)"

"$(ASSETS_DIR)":
	@echo 'Creating "$(ASSETS_DIR)" directory...'
	@mkdir -p "$(ASSETS_DIR)"
"$(BIN_DIR)":
	@echo 'Creating "$(BIN_DIR)" directory...'
	@mkdir -p "$(BIN_DIR)"
