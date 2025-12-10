.PHONY: keymap keymap-parse clean help

KEYMAP_FILE := config/lily58.keymap
YAML_OUTPUT := lily58_keymap.yaml
SVG_OUTPUT := lily58_keymap.svg
PNG_OUTPUT := lily58_keymap.png

help:
	@echo "Available targets:"
	@echo "  keymap  - Generate keymap visualization (YAML + SVG)"
	@echo "  keymap-parse - Parse keymap to YAML only"
	@echo "  clean        - Remove generated files"

keymap-parse:
	@echo "Parsing keymap to YAML..."
	keymap parse -z $(KEYMAP_FILE) > $(YAML_OUTPUT)
	@echo "Created $(YAML_OUTPUT)"

keymap: keymap-parse
	@echo "Drawing keymap SVG..."
	keymap draw $(YAML_OUTPUT) > $(SVG_OUTPUT)
	@echo "Created $(SVG_OUTPUT)"
	@if command -v inkscape >/dev/null 2>&1; then \
		echo "Converting SVG to PNG..."; \
		inkscape $(SVG_OUTPUT) --export-filename=$(PNG_OUTPUT) --export-dpi=300; \
		echo "Created $(PNG_OUTPUT)"; \
	else \
		echo "Install inkscape to generate PNG: sudo dnf install inkscape"; \
	fi

clean:
	rm -f $(YAML_OUTPUT) $(SVG_OUTPUT) $(PNG_OUTPUT)
	@echo "Cleaned generated files"
