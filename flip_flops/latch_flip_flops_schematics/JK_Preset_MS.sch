<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="J" />
        <signal name="Clock" />
        <signal name="Clear" />
        <signal name="Preset" />
        <signal name="Qn" />
        <signal name="Q" />
        <signal name="K" />
        <signal name="XLXN_20" />
        <signal name="XLXN_21" />
        <port polarity="Input" name="J" />
        <port polarity="Input" name="Clock" />
        <port polarity="Input" name="Clear" />
        <port polarity="Input" name="Preset" />
        <port polarity="Output" name="Qn" />
        <port polarity="Output" name="Q" />
        <port polarity="Input" name="K" />
        <blockdef name="RS_Preset_MS">
            <timestamp>2015-12-27T14:2:8</timestamp>
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
        <block symbolname="RS_Preset_MS" name="RS_MS">
            <blockpin signalname="Clock" name="Clock" />
            <blockpin signalname="Clear" name="Clear" />
            <blockpin signalname="Preset" name="Preset" />
            <blockpin signalname="XLXN_21" name="S" />
            <blockpin signalname="XLXN_20" name="R" />
            <blockpin signalname="Qn" name="Qn" />
            <blockpin signalname="Q" name="Q" />
        </block>
        <block symbolname="and2" name="QnAndJ">
            <blockpin signalname="J" name="I0" />
            <blockpin signalname="Qn" name="I1" />
            <blockpin signalname="XLXN_21" name="O" />
        </block>
        <block symbolname="and2" name="QandK">
            <blockpin signalname="Q" name="I0" />
            <blockpin signalname="K" name="I1" />
            <blockpin signalname="XLXN_20" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1376" y="1456" name="RS_MS" orien="R0">
        </instance>
        <branch name="Clock">
            <wire x2="1376" y1="1168" y2="1168" x1="1328" />
        </branch>
        <branch name="Clear">
            <wire x2="1376" y1="1232" y2="1232" x1="1328" />
        </branch>
        <branch name="Preset">
            <wire x2="1376" y1="1296" y2="1296" x1="1344" />
        </branch>
        <iomarker fontsize="28" x="1344" y="1296" name="Preset" orien="R180" />
        <iomarker fontsize="28" x="1328" y="1232" name="Clear" orien="R180" />
        <iomarker fontsize="28" x="1328" y="1168" name="Clock" orien="R180" />
        <instance x="880" y="1408" name="QnAndJ" orien="R0" />
        <instance x="880" y="1568" name="QandK" orien="R0" />
        <branch name="J">
            <wire x2="880" y1="1344" y2="1344" x1="848" />
        </branch>
        <iomarker fontsize="28" x="848" y="1344" name="J" orien="R180" />
        <branch name="Qn">
            <wire x2="1888" y1="1008" y2="1008" x1="800" />
            <wire x2="1888" y1="1008" y2="1168" x1="1888" />
            <wire x2="800" y1="1008" y2="1280" x1="800" />
            <wire x2="880" y1="1280" y2="1280" x1="800" />
            <wire x2="1776" y1="1168" y2="1168" x1="1760" />
            <wire x2="1888" y1="1168" y2="1168" x1="1776" />
            <wire x2="1776" y1="1168" y2="1248" x1="1776" />
            <wire x2="1904" y1="1248" y2="1248" x1="1776" />
        </branch>
        <branch name="Q">
            <wire x2="880" y1="1504" y2="1504" x1="800" />
            <wire x2="800" y1="1504" y2="1664" x1="800" />
            <wire x2="1888" y1="1664" y2="1664" x1="800" />
            <wire x2="1776" y1="1424" y2="1424" x1="1760" />
            <wire x2="1888" y1="1424" y2="1424" x1="1776" />
            <wire x2="1888" y1="1424" y2="1664" x1="1888" />
            <wire x2="1904" y1="1328" y2="1328" x1="1776" />
            <wire x2="1776" y1="1328" y2="1424" x1="1776" />
        </branch>
        <branch name="K">
            <wire x2="880" y1="1440" y2="1440" x1="848" />
        </branch>
        <iomarker fontsize="28" x="848" y="1440" name="K" orien="R180" />
        <iomarker fontsize="28" x="1904" y="1248" name="Qn" orien="R0" />
        <iomarker fontsize="28" x="1904" y="1328" name="Q" orien="R0" />
        <branch name="XLXN_20">
            <wire x2="1200" y1="1472" y2="1472" x1="1136" />
            <wire x2="1200" y1="1424" y2="1472" x1="1200" />
            <wire x2="1376" y1="1424" y2="1424" x1="1200" />
        </branch>
        <branch name="XLXN_21">
            <wire x2="1200" y1="1312" y2="1312" x1="1136" />
            <wire x2="1200" y1="1312" y2="1360" x1="1200" />
            <wire x2="1376" y1="1360" y2="1360" x1="1200" />
        </branch>
    </sheet>
</drawing>