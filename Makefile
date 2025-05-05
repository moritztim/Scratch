NAME = Project

SRC_DIR = src
PROJECT_FILE = project.json
ASSETS_DIR = assets
BIN_DIR = bin
EXT = sb3
BIN_FILE = $(BIN_DIR)/$(NAME).$(EXT)
TEMP := $(shell mktemp -d)

extract: $(SRC_DIR) $(ASSETS_DIR)
	@echo "Extracting $(BIN_FILE)..."
	@unzip -q $(BIN_FILE) -d $(TEMP)
	@echo "Moving project file to $(SRC_DIR)"
	@mv $(TEMP)/$(PROJECT_FILE) $(SRC_DIR)/$(PROJECT_FILE)
	@echo "Moving assets to $(ASSETS_DIR)"
	@mv $(TEMP)/* $(ASSETS_DIR)/
	@echo "Cleaning up temp directory..."
	@rm -rf $(TEMP)

# Ensure necessary directories exist
$(SRC_DIR):
	@echo "Creating src/ directory..."
	@mkdir -p $(SRC_DIR)

$(ASSETS_DIR):
	@echo "Creating assets/ directory..."
	@mkdir -p $(ASSETS_DIR)
