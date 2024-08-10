# Makefile

SCRIPT = main.sh

# Regla por defecto
all: run

# Regla para ejecutar el script
run:
	@echo "Ejecutando el script..."
	bash $(SCRIPT)

# Regla de limpieza (opcional)
.PHONY: clean
clean:
	@echo "No hay archivos generados para limpiar."

# Regla para verificar el script
check:
	@echo "Verificando el script con shellcheck..."
	shellcheck $(SCRIPT)
