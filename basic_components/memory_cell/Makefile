COMPONENT=memory_cell
WORKDIR=./
GHDL_OPTS=--ieee=synopsys
GHDL_OPTS+=--workdir=${WORKDIR}

include ${WORKDIR}/${COMPONENT}.mk

all: analyse run

analyse: ${DEPS}
	@ghdl -a ${GHDL_OPTS} $?

run:
	@ghdl -r ${GHDL_OPTS} ${TB_ENTITY_NAME} --wave=${TB_ENTITY_NAME}.ghw

wave:
	@gtkwave ${WORKDIR}/${TB_ENTITY_NAME}.ghw ${WORKDIR}/${TB_ENTITY_NAME}.gtkw &

clean:
	@-ghdl --remove
	@-rm *.ghw
