<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="Clock" />
        <signal name="Clear" />
        <signal name="Preset" />
        <signal name="Qn" />
        <signal name="Q" />
        <signal name="XLXN_7" />
        <signal name="T" />
        <port polarity="Input" name="Clock" />
        <port polarity="Input" name="Clear" />
        <port polarity="Input" name="Preset" />
        <port polarity="Output" name="Qn" />
        <port polarity="Output" name="Q" />
        <port polarity="Input" name="T" />
        <blockdef name="JK_Preset_MS">
            <timestamp>2015-12-27T14:22:40</timestamp>
            <rect width="256" x="64" y="-320" height="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="JK_Preset_MS" name="JK_MS">
            <blockpin signalname="T" name="J" />
            <blockpin signalname="Clock" name="Clock" />
            <blockpin signalname="Clear" name="Clear" />
            <blockpin signalname="Preset" name="Preset" />
            <blockpin signalname="T" name="K" />
            <blockpin signalname="Qn" name="Qn" />
            <blockpin signalname="Q" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1120" y="1472" name="JK_MS" orien="R0">
        </instance>
        <branch name="Clock">
            <wire x2="1120" y1="1248" y2="1248" x1="1072" />
        </branch>
        <branch name="Clear">
            <wire x2="1120" y1="1312" y2="1312" x1="1072" />
        </branch>
        <branch name="Preset">
            <wire x2="1120" y1="1376" y2="1376" x1="1088" />
        </branch>
        <iomarker fontsize="28" x="1088" y="1376" name="Preset" orien="R180" />
        <iomarker fontsize="28" x="1072" y="1312" name="Clear" orien="R180" />
        <iomarker fontsize="28" x="1072" y="1248" name="Clock" orien="R180" />
        <branch name="Qn">
            <wire x2="1520" y1="1184" y2="1184" x1="1504" />
        </branch>
        <branch name="Q">
            <wire x2="1520" y1="1440" y2="1440" x1="1504" />
        </branch>
        <iomarker fontsize="28" x="1520" y="1440" name="Q" orien="R0" />
        <iomarker fontsize="28" x="1520" y="1184" name="Qn" orien="R0" />
        <branch name="T">
            <wire x2="944" y1="1184" y2="1184" x1="896" />
            <wire x2="1120" y1="1184" y2="1184" x1="944" />
            <wire x2="944" y1="1184" y2="1440" x1="944" />
            <wire x2="1120" y1="1440" y2="1440" x1="944" />
        </branch>
        <iomarker fontsize="28" x="896" y="1184" name="T" orien="R180" />
    </sheet>
</drawing>