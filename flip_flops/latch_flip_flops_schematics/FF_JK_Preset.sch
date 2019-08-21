<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="XLXN_2" />
        <signal name="Clear" />
        <signal name="Preset" />
        <signal name="J" />
        <signal name="K" />
        <signal name="Clock" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13" />
        <signal name="Qn" />
        <signal name="Q" />
        <port polarity="Input" name="Clear" />
        <port polarity="Input" name="Preset" />
        <port polarity="Input" name="J" />
        <port polarity="Input" name="K" />
        <port polarity="Input" name="Clock" />
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
        <blockdef name="and2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <blockdef name="buf">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="0" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="64" y1="-64" y2="0" x1="64" />
        </blockdef>
        <block symbolname="latch_rs_enabled_preset" name="XLXI_1">
            <blockpin signalname="Clock" name="Clock" />
            <blockpin signalname="XLXN_1" name="S" />
            <blockpin signalname="XLXN_2" name="R" />
            <blockpin signalname="Clear" name="Clear" />
            <blockpin signalname="Preset" name="Preset" />
            <blockpin signalname="XLXN_12" name="Qn" />
            <blockpin signalname="XLXN_13" name="Q" />
        </block>
        <block symbolname="and2" name="XLXI_2">
            <blockpin signalname="J" name="I0" />
            <blockpin signalname="XLXN_12" name="I1" />
            <blockpin signalname="XLXN_1" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_3">
            <blockpin signalname="XLXN_13" name="I0" />
            <blockpin signalname="K" name="I1" />
            <blockpin signalname="XLXN_2" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_4">
            <blockpin signalname="XLXN_12" name="I" />
            <blockpin signalname="Qn" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_5">
            <blockpin signalname="XLXN_13" name="I" />
            <blockpin signalname="Q" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1616" y="1040" name="XLXI_1" orien="R0">
        </instance>
        <instance x="1056" y="912" name="XLXI_2" orien="R0" />
        <instance x="1056" y="1104" name="XLXI_3" orien="R0" />
        <branch name="XLXN_1">
            <wire x2="1616" y1="816" y2="816" x1="1312" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="1344" y1="1008" y2="1008" x1="1312" />
            <wire x2="1344" y1="880" y2="1008" x1="1344" />
            <wire x2="1616" y1="880" y2="880" x1="1344" />
        </branch>
        <branch name="Clear">
            <wire x2="1456" y1="944" y2="1184" x1="1456" />
            <wire x2="1616" y1="944" y2="944" x1="1456" />
        </branch>
        <branch name="Preset">
            <wire x2="1536" y1="1008" y2="1184" x1="1536" />
            <wire x2="1616" y1="1008" y2="1008" x1="1536" />
        </branch>
        <branch name="J">
            <wire x2="1056" y1="848" y2="848" x1="1040" />
        </branch>
        <branch name="K">
            <wire x2="1056" y1="976" y2="976" x1="1040" />
        </branch>
        <branch name="Clock">
            <wire x2="1616" y1="752" y2="752" x1="1584" />
        </branch>
        <iomarker fontsize="28" x="1584" y="752" name="Clock" orien="R180" />
        <branch name="XLXN_12">
            <wire x2="1040" y1="592" y2="784" x1="1040" />
            <wire x2="1056" y1="784" y2="784" x1="1040" />
            <wire x2="2016" y1="592" y2="592" x1="1040" />
            <wire x2="2016" y1="592" y2="752" x1="2016" />
            <wire x2="2016" y1="752" y2="752" x1="2000" />
        </branch>
        <branch name="XLXN_13">
            <wire x2="1008" y1="1040" y2="1152" x1="1008" />
            <wire x2="2032" y1="1152" y2="1152" x1="1008" />
            <wire x2="1056" y1="1040" y2="1040" x1="1008" />
            <wire x2="2032" y1="1008" y2="1008" x1="2000" />
            <wire x2="2032" y1="1008" y2="1152" x1="2032" />
        </branch>
        <instance x="2016" y="784" name="XLXI_4" orien="R0" />
        <instance x="2032" y="1040" name="XLXI_5" orien="R0" />
        <branch name="Qn">
            <wire x2="2272" y1="752" y2="752" x1="2240" />
        </branch>
        <iomarker fontsize="28" x="2272" y="752" name="Qn" orien="R0" />
        <branch name="Q">
            <wire x2="2288" y1="1008" y2="1008" x1="2256" />
        </branch>
        <iomarker fontsize="28" x="2288" y="1008" name="Q" orien="R0" />
        <iomarker fontsize="28" x="1456" y="1184" name="Clear" orien="R90" />
        <iomarker fontsize="28" x="1536" y="1184" name="Preset" orien="R90" />
        <iomarker fontsize="28" x="1040" y="848" name="J" orien="R180" />
        <iomarker fontsize="28" x="1040" y="976" name="K" orien="R180" />
    </sheet>
</drawing>
