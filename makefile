# ================================
# OpenModelica Sparse Build
# ================================

OM_HOME := $(HOME)/OpenModelica
OM_BUILD := $(OM_HOME)/build
OM_INSTALL := $(OM_BUILD)/install

.PHONY: deps clone configure build install clean all

all: deps clone configure build install


# -------------------------------
# 1. Install system dependencies
# -------------------------------
deps:
	sudo apt update
	sudo apt install -y \
		build-essential \
		cmake \
		git \
		gfortran \
		liblapack-dev \
		libblas-dev \
		libsuitesparse-dev \
		libxml2-dev \
		libexpat1-dev \
		libreadline-dev \
		libncurses-dev \
		libssl-dev \
		zlib1g-dev \
		libboost-all-dev \
		python3-dev \
		swig \
		pkg-config


# -------------------------------
# 2. Clone OpenModelica
# -------------------------------
clone:
	if [ ! -d "$(OM_HOME)" ]; then \
		cd $(HOME) && \
		git clone --recursive https://github.com/OpenModelica/OpenModelica.git; \
	else \
		echo "OpenModelica already exists at $(OM_HOME)"; \
	fi


# -------------------------------
# 3. Configure with Sparse + KLU
# -------------------------------
configure:
	rm -rf $(OM_BUILD)
	mkdir -p $(OM_BUILD)
	cd $(OM_BUILD) && \
	cmake .. \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$(OM_INSTALL) \
		-DOM_ENABLE_GUI_CLIENTS=OFF


# -------------------------------
# 4. Build
# -------------------------------
build:
	cd $(OM_BUILD) && make -j$$(nproc)


# -------------------------------
# 5. Install
# -------------------------------
install:
	cd $(OM_BUILD) && make install
	@echo ""
	@echo "========================================="
	@echo "OpenModelica installed at:"
	@echo "$(OM_INSTALL)"
	@echo ""
	@echo "Add to PATH with:"
	@echo "export PATH=$(OM_INSTALL)/bin:\$$PATH"
	@echo "========================================="
	$(OM_INSTALL)/bin/omc ./msl_setup.mos


# -------------------------------
# 6. Clean everything
# -------------------------------
clean:
	rm -rf $(OM_HOME)

export_fmu:
	~/OpenModelica/build/install/bin/omc ./BobDyn/FMI/OrionChassis.mos