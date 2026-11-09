export LM_LICENSE_FILE=/home/dhanumjaya_atyam/Downloads/questasim/license.dat
export MGLS_LICENSE_FILE=$(LM_LICENSE_FILE)

all: clean compile run

clean:
	rm -rf work transcript *.wlf

compile:
	vlib work
	vlog -sv tb_top.sv

run:
	vsim -c tb_top -do "run -all; quit"
