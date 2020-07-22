all: analyse run

analyse:
	ghdl -a reset_logic.vhd
	ghdl -a reset_logic_tb.vhd

run:
	ghdl -r reset_logic_tb --assert-level=failure --vcd=reset_logic_tb.vcd

gtkwave:
	gtkwave reset_logic_tb.vcd &

clean:
	ghdl --remove
	rm *.vcd
