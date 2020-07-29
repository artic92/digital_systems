GHDL_OPTS=--ieee=synopsys

TOP_LEVEL=tb_register_n_bit
DEPS=register_n_bit_pkg.vhd register_n_bit.vhd tb_register_n_bit.vhd

all: analyse run

analyse: ${DEPS}
	@ghdl -a ${GHDL_OPTS} $?

run:
	@ghdl -r ${GHDL_OPTS} ${TOP_LEVEL} --wave=${TOP_LEVEL}.ghw

wave:
	@gtkwave ${TOP_LEVEL}.ghw ${TOP_LEVEL}.gtkw

clean:
	@-ghdl --remove
	@-rm *.cf
	@-rm *.ghw

