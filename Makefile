# directory locations
VHDL_RTL_DIR 	= ./src/vhdl
VLOG_RTL_DIR 	= ./src/vlog
SV_RTL_DIR 		= ./src/sv
VHDL_TB_DIR 	= ./tb/vhdl
VLOG_TB_DIR 	= ./tb/vlog
SV_TB_DIR 		= ./tb/sv
WORK_LIB 		= work.lib
WORK_DIR		= ./build

# create work library
library:
	mkdir -p build
	vlib $(WORK_DIR)/$(WORK_LIB)

# create modelsim.ini
modelsim: Makefile
	rm -rf modelsim.ini
	echo [Library] >> modelsim.ini
	echo others = "$$"MODEL_TECH/../modelsim.ini >> modelsim.ini
	echo work = $(WORK_DIR)/$(WORK_LIB) >> modelsim.ini
	echo $(WORK_LIB) = $(WORK_DIR)/$(WORK_LIB) >> modelsim.ini

# compile verilog
vlog_rtl:
	$(eval SRC_FILES :=$(wildcard $(VLOG_RTL_DIR)/*.v))
	$(eval NO_OF_FILES := $(words $(SRC_FILES)))
	@if [ ${NO_OF_FILES} -gt 0 ] ; then \
        for file in $(SRC_FILES); do \
			vlog -work $(WORK_LIB) $${file}; \
		done \
    fi

vlog_tb:
	$(eval SRC_FILES :=$(wildcard $(VLOG_TB_DIR)/*.v))
	$(eval NO_OF_FILES := $(words $(SRC_FILES)))
	@if [ ${NO_OF_FILES} -gt 0 ] ; then \
        for file in $(SRC_FILES); do \
			vlog -work $(WORK_LIB) $${file}; \
		done \
    fi

# compile vhdl
vhdl_rtl: 
	$(eval SRC_FILES :=$(wildcard $(VHDL_RTL_DIR)/*.vhd))
	$(eval NO_OF_FILES := $(words $(SRC_FILES)))
	@if [ ${NO_OF_FILES} -gt 0 ] ; then \
        for file in $(SRC_FILES); do \
			vcom -2008 -work $(WORK_LIB) $${file}; \
		done \
    fi

vhdl_tb:
	$(eval SRC_FILES :=$(wildcard $(VHDL_TB_DIR)/*.vhd))
	$(eval NO_OF_FILES := $(words $(SRC_FILES)))
	@if [ ${NO_OF_FILES} -gt 0 ] ; then \
        for file in $(SRC_FILES); do \
			vcom -2008 -work $(WORK_LIB) $${file}; \
		done \
    fi

# compile sv
sv_rtl:
	$(eval SRC_FILES :=$(wildcard $(SV_RTL_DIR)/*.sv))
	$(eval NO_OF_FILES := $(words $(SRC_FILES)))
	@if [ ${NO_OF_FILES} -gt 0 ] ; then \
        for file in $(SRC_FILES); do \
			vlog -work $(WORK_LIB) $${file}; \
		done \
    fi

sv_tb:
	$(eval SRC_FILES :=$(wildcard $(SV_TB_DIR)/*.sv))
	$(eval NO_OF_FILES := $(words $(SRC_FILES)))
	@if [ ${NO_OF_FILES} -gt 0 ] ; then \
        for file in $(SRC_FILES); do \
			vlog -work $(WORK_LIB) $${file}; \
		done \
    fi

all: library modelsim\
		vlog_rtl vlog_tb \
		vhdl_rtl vhdl_tb \
		sv_rtl sv_tb 

init: library modelsim

clean:
	@echo Deleting libraries
	@rm -rf $(WORK_DIR)/
	@echo Deleting modelsim.ini
	@rm -f modelsim.ini
	@echo Deleting any waveform files or transcripts
	@rm -f *.wlf *.log transcript
