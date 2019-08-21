<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="T" />
        <signal name="Clock" />
        <signal name="Preset" />
        <signal name="Clear" />
        <signal name="Q" />
        <signal name="Qn" />
        <port polarity="Input" name="T" />
        <port polarity="Input" name="Clock" />
        <port polarity="Input" name="Preset" />
        <port polarity="Input" name="Clear" />
        <port polarity="Output" name="Q" />
        <port polarity="Output" name="Qn" />
        <blockdef name="FF_JK_Preset">
            <timestamp>2015-12-12T18:32:3</timestamp>
            <rect width="256" x="64" y="-320" height="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="FF_JK_Preset" name="XLXI_1">
            <blockpin signalname="Clear" name="Clear" />
            <blockpin signalname="Preset" name="Preset" />
            <blockpin signalname="T" name="J" />
            <blockpin signalname="T" name="K" />
            <blockpin signalname="Clock" name="Clock" />
            <blockpin signalname="Qn" name="Qn" />
            <blockpin signalname="Q" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1488" y="1472" name="XLXI_1" orien="R0">
        </instance>
        <branch name="T">
            <wire x2="1472" y1="1344" y2="1344" x1="1408" />
            <wire x2="1472" y1="1344" y2="1376" x1="1472" />
            <wire x2="1488" y1="1376" y2="1376" x1="1472" />
            <wire x2="1488" y1="1312" y2="1312" x1="1472" />
            <wire x2="1472" y1="1312" y2="1344" x1="1472" />
        </branch>
        <branch name="Clock">
            <wire x2="1472" y1="1440" y2="1440" x1="1456" />
            <wire x2="1488" y1="1440" y2="1440" x1="1472" />
        </branch>
        <branch name="Preset">
            <wire x2="1488" y1="1248" y2="1248" x1="1472" />
        </branch>
        <branch name="Clear">
            <wire x2="1472" y1="1184" y2="1184" x1="1456" />
            <wire x2="1488" y1="1184" y2="1184" x1="1472" />
        </branch>
        <branch name="Q">
            <wire x2="1888" y1="1440" y2="1440" x1="1872" />
            <wire x2="1920" y1="1440" y2="1440" x1="1888" />
        </branch>
        <iomarker fontsize="28" x="1920" y="1440" name="Q" orien="R0" />
        <iomarker fontsize="28" x="1456" y="1184" name="Clear" orien="R180" />
        <iomarker fontsize="28" x="1472" y="1248" name="Preset" orien="R180" />
        <iomarker fontsize="28" x="1408" y="1344" name="T" orien="R180" />
        <iomarker fontsize="28" x="1456" y="1440" name="Clock" orien="R180" />
        <branch name="Qn">
            <wire x2="1888" y1="1184" y2="1184" x1="1872" />
            <wire x2="1920" y1="1184" y2="1184" x1="1888" />
        </branch>
        <iomarker fontsize="28" x="1920" y="1184" name="Qn" orien="R0" />
    </sheet>
</drawing>