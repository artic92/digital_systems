# generates a clock with 50 MHz frequency, 50% duty cycle ad 2ns offset
create_clock -period 20 -waveform {2 7} p:clock
