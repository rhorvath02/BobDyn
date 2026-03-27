# Makefile for manipulating Modelica packages

# Usage examples:
#   make model path=MyLib.Components name=SpringDamper
#   make function path=MyLib.Utils name=interpolate
#   make package path=MyLib name=SubPkg

# Translate dots to slashes for filesystem paths
FS_PATH := $(subst .,/,$(path))

# Detect Python
PYTHON := $(shell command -v python3 2>/dev/null)

ifndef PYTHON
$(error "Python not found. Please install python3 and ensure it is on PATH.")
endif

# Arg validation
# ifndef path
# $(error You must provide 'path', e.g., path=MyLib.Components)
# endif

# ifndef name
# $(error You must provide 'name', e.g., name=SpringDamper)
# endif

# Helper: parent directory of FS_PATH
PARENT := $(dir $(FS_PATH))

# Default rule
all:
	@echo "Use 'make model', 'make function', or 'make package' with path=... name=..."

# Create a Model
model:
	@mkdir -p $(FS_PATH)
	@echo "within $(path);" > $(FS_PATH)/$(name).mo
	@echo "model $(name)" >> $(FS_PATH)/$(name).mo
	@echo "" >> $(FS_PATH)/$(name).mo
	@echo "end $(name);" >> $(FS_PATH)/$(name).mo
	@echo "Created model: $(FS_PATH)/$(name).mo"
	@if [ -f $(FS_PATH)/package.order ]; then \
	  grep -qx '$(name)' $(FS_PATH)/package.order || echo '$(name)' >> $(FS_PATH)/package.order; \
	  echo "Updated package.order in $(FS_PATH)"; \
	fi

# Create a Function
function:
	@mkdir -p $(FS_PATH)
	@echo "within $(path);" > $(FS_PATH)/$(name).mo
	@echo "function $(name)" >> $(FS_PATH)/$(name).mo
	@echo "  // TODO: add inputs/outputs" >> $(FS_PATH)/$(name).mo
	@echo "end $(name);" >> $(FS_PATH)/$(name).mo
	@echo "Created function: $(FS_PATH)/$(name).mo"
	@if [ -f $(FS_PATH)/package.order ]; then \
	  grep -qx '$(name)' $(FS_PATH)/package.order || echo '$(name)' >> $(FS_PATH)/package.order; \
	  echo "Updated package.order in $(FS_PATH)"; \
	fi

# Create a Package
package:
	@mkdir -p $(FS_PATH)/$(name)
	@echo "within $(path);" > $(FS_PATH)/$(name)/package.mo
	@echo "package $(name)" >> $(FS_PATH)/$(name)/package.mo
	@echo "" >> $(FS_PATH)/$(name)/package.mo
	@echo "end $(name);" >> $(FS_PATH)/$(name)/package.mo
	@touch $(FS_PATH)/$(name)/package.order
	@echo "Created package: $(FS_PATH)/$(name)"
	@if [ -f $(FS_PATH)/package.order ]; then \
	  grep -qx '$(name)' $(FS_PATH)/package.order || echo '$(name)' >> $(FS_PATH)/package.order; \
	  echo "Updated package.order in $(FS_PATH)"; \
	fi

records:
	$(PYTHON) ./Tools/TIRES/convert_mf52_tir_to_record.py ./BobLib/Resources/JSONs/TIRES/Fr_tire.tir
	$(PYTHON) ./Tools/TIRES/convert_mf52_tir_to_record.py ./BobLib/Resources/JSONs/TIRES/Rr_tire.tir
	$(PYTHON) ./Tools/SUS/convert_suspension_json_to_record.py ./BobLib/Resources/JSONs/SUS/tune.json
	$(PYTHON) ./Tools/SUS/convert_massprops_json_to_record.py ./BobLib/Resources/JSONs/MASSPROPS/mass_props.json

init:
	sudo apt install gcc-arm-linux-gnueabihf  # arm linux
	sudo apt install gcc-mingw-w64-x86-64     # windows

omc:
	cd ../
	git clone --recursive https://github.com/OpenModelica/OpenModelica.git
	cd OpenModelica
	git checkout v1.26.2
	git submodule update --init --recursive

	sudo apt update
	sudo apt install \
		build-essential cmake git \
		libsuitesparse-dev \
		liblapack-dev libblas-dev \
		libboost-all-dev \
		libcurl4-openssl-dev \
		libssl-dev \
		libxml2-dev \
		libexpat1-dev \
		libsqlite3-dev \
		gfortran
	
	mkdir build
	cd build
	cmake .. \
  		-DCMAKE_BUILD_TYPE=Release \
  		-DENABLE_SUITESPARSE=ON \
  		-DENABLE_KLU=ON \
  		-DOM_OMEDIT_ENABLE=OFF \
  		-DOM_ENABLE_GUI_CLIENTS=OFF
	
	make -j$(nproc)
	make install
	
	export OPENMODELICAHOME=$HOME/shared/OpenModelica/build/install_cmake
	export PATH=$OPENMODELICAHOME/bin:$PATH]

setup:
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash Miniconda3-latest-Linux-x86_64.sh

	conda create -n fmu_ida -c conda-forge python=3.11
	conda activate fmu_ida

	conda install -c conda-forge \
		fmpy \
		scikits-odes \
		scikits-odes-sundials \
		numpy \
		scipy \
		matplotlib \
		lxml

setup2:
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

	cd ~/
# 	git clone --recursive https://github.com/OpenModelica/OpenModelica.git
	cd OpenModelica

	mkdir build
	cd build

	cmake .. \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$PWD/install \
		-DENABLE_SUITESPARSE=ON \
		-DENABLE_KLU=ON \
		-DOM_OMEDIT_ENABLE=OFF \
		-DOM_ENABLE_GUI_CLIENTS=OFF