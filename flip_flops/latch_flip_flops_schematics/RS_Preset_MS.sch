<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="XLXN_3" />
        <signal name="Clock" />
        <signal name="Clear" />
        <signal name="Preset" />
        <signal name="S" />
        <signal name="R" />
        <signal name="Qn" />
        <signal name="Q" />
        <signal name="XLXN_14" />
        <signal name="XLXN_15" />
        <port polarity="Input" name="Clock" />
        <port polarity="Input" name="Clear" />
        <port polarity="Input" name="Preset" />
        <port polarity="Input" name="S" />
        <port polarity="Input" name="R" />
        <port polarity="Output" name="Qn" />
        <port polarity="Output" name="Q" />
        <blockdef name="latch_rs_enabled_preset">
            <timestamp>2015-12-14T9:28:23</timestamp>
            <rect width="256" x="64" y="-320" height="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <block symbolname="latch_rs_enabled_preset" name="Master">
            <blockpin signalname="XLXN_1" name="Clock" />
            <blockpin signalname="S" name="S" />
            <blockpin signalname="R" name="R" />
            <blockpin signalname="Clear" name="Clear" />
            <blockpin signalname="Preset" name="Preset" />
            <blockpin signalname="XLXN_14" name="Qn" />
            <blockpin signalname="XLXN_15" name="Q" />
        </block>
        <block symbolname="latch_rs_enabled_preset" name="Slave">
            <blockpin signalname="Clock" name="Clock" />
            <blockpin signalname="XLXN_15" name="S" />
            <blockpin signalname="XLXN_14" name="R" />
            <blockpin signalname="Clear" name="Clear" />
            <blockpin signalname="Preset" name="Preset" />
            <blockpin signalname="Qn" name="Qn" />
            <blockpin signalname="Q" name="Q" />
        </block>
        <block symbolname="inv" name="XLXI_3">
            <blockpin signalname="Clock" name="I" />
            <blockpin signalname="XLXN_1" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1680" y="1376" name="Slave" orien="R0">
        </instance>
        <instance x="976" y="1376" name="Master" orien="R0">
        </instance>
        <branch name="Clock">
            <wire x2="1600" y1="896" y2="896" x1="1232" />
            <wire x2="1664" y1="896" y2="896" x1="1600" />
            <wire x2="1664" y1="896" y2="1088" x1="1664" />
            <wire x2="1680" y1="1088" y2="1088" x1="1664" />
            <wire x2="1600" y1="816" y2="896" x1="1600" />
        </branch>
        <instance x="1232" y="864" name="XLXI_3" orien="R180" />
        <branch name="XLXN_1">
            <wire x2="928" y1="896" y2="1088" x1="928" />
            <wire x2="976" y1="1088" y2="1088" x1="928" />
            <wire x2="1008" y1="896" y2="896" x1="928" />
        </branch>
        <iomarker fontsize="28" x="1600" y="816" name="Clock" orien="R270" />
        <branch name="Preset">
            <wire x2="944" y1="1344" y2="1504" x1="944" />
            <wire x2="1632" y1="1504" y2="1504" x1="944" />
            <wire x2="944" y1="1504" y2="1568" x1="944" />
            <wire x2="976" y1="1344" y2="1344" x1="944" />
            <wire x2="1680" y1="1344" y2="1344" x1="1632" />
            <wire x2="1632" y1="1344" y2="1504" x1="1632" />
        </branch>
        <branch name="Clear">
            <wire x2="976" y1="1280" y2="1280" x1="848" />
            <wire x2="848" y1="1280" y2="1440" x1="848" />
            <wire x2="1568" y1="1440" y2="1440" x1="848" />
            <wire x2="848" y1="1440" y2="1568" x1="848" />
            <wire x2="1680" y1="1280" y2="1280" x1="1568" />
            <wire x2="1568" y1="1280" y2="1440" x1="1568" />
        </branch>
        <iomarker fontsize="28" x="944" y="1568" name="Preset" orien="R90" />
        <iomarker fontsize="28" x="848" y="1568" name="Clear" orien="R90" />
        <branch name="S">
            <wire x2="976" y1="1152" y2="1152" x1="944" />
        </branch>
        <iomarker fontsize="28" x="944" y="1152" name="S" orien="R180" />
        <branch name="R">
            <wire x2="976" y1="1216" y2="1216" x1="944" />
        </branch>
        <iomarker fontsize="28" x="944" y="1216" name="R" orien="R180" />
        <branch name="Qn">
            <wire x2="2096" y1="1088" y2="1088" x1="2064" />
        </branch>
        <iomarker fontsize="28" x="2096" y="1088" name="Qn" orien="R0" />
        <branch name="Q">
            <wire x2="2096" y1="1344" y2="1344" x1="2064" />
        </branch>
        <iomarker fontsize="28" x="2096" y="1344" name="Q" orien="R0" />
        <branch name="XLXN_14">
            <wire x2="1408" y1="1088" y2="1088" x1="1360" />
            <wire x2="1408" y1="1088" y2="1216" x1="1408" />
            <wire x2="1680" y1="1216" y2="1216" x1="1408" />
        </branch>
        <branch name="XLXN_15">
            <wire x2="1488" y1="1344" y2="1344" x1="1360" />
            <wire x2="1488" y1="1152" y2="1344" x1="1488" />
            <wire x2="1680" y1="1152" y2="1152" x1="1488" />
        </branch>
        <text style="fontsize:40;fontname:Arial" x="1828" y="872">Rising edge</text>
    </sheet>
</drawing>
