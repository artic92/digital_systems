<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="Clock" />
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <signal name="XLXN_5" />
        <signal name="Qn" />
        <signal name="Q" />
        <signal name="S" />
        <signal name="R" />
        <signal name="Clear" />
        <signal name="Preset" />
        <port polarity="Input" name="Clock" />
        <port polarity="Output" name="Qn" />
        <port polarity="Output" name="Q" />
        <port polarity="Input" name="S" />
        <port polarity="Input" name="R" />
        <port polarity="Input" name="Clear" />
        <port polarity="Input" name="Preset" />
        <blockdef name="nor3">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="48" y1="-64" y2="-64" x1="0" />
            <line x2="72" y1="-128" y2="-128" x1="0" />
            <line x2="48" y1="-192" y2="-192" x1="0" />
            <line x2="216" y1="-128" y2="-128" x1="256" />
            <circle r="12" cx="204" cy="-128" />
            <line x2="48" y1="-64" y2="-80" x1="48" />
            <line x2="48" y1="-192" y2="-176" x1="48" />
            <line x2="48" y1="-80" y2="-80" x1="112" />
            <line x2="48" y1="-176" y2="-176" x1="112" />
            <arc ex="48" ey="-176" sx="48" sy="-80" r="56" cx="16" cy="-128" />
            <arc ex="192" ey="-128" sx="112" sy="-80" r="88" cx="116" cy="-168" />
            <arc ex="112" ey="-176" sx="192" sy="-128" r="88" cx="116" cy="-88" />
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
        <block symbolname="nor3" name="XLXI_1">
            <blockpin signalname="XLXN_5" name="I0" />
            <blockpin signalname="XLXN_2" name="I1" />
            <blockpin signalname="Preset" name="I2" />
            <blockpin signalname="XLXN_4" name="O" />
        </block>
        <block symbolname="nor3" name="XLXI_2">
            <blockpin signalname="Clear" name="I0" />
            <blockpin signalname="XLXN_3" name="I1" />
            <blockpin signalname="XLXN_4" name="I2" />
            <blockpin signalname="XLXN_5" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_3">
            <blockpin signalname="Clock" name="I0" />
            <blockpin signalname="S" name="I1" />
            <blockpin signalname="XLXN_2" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_4">
            <blockpin signalname="R" name="I0" />
            <blockpin signalname="Clock" name="I1" />
            <blockpin signalname="XLXN_3" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_5">
            <blockpin signalname="XLXN_4" name="I" />
            <blockpin signalname="Qn" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_6">
            <blockpin signalname="XLXN_5" name="I" />
            <blockpin signalname="Q" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1344" y="992" name="XLXI_1" orien="R0" />
        <instance x="1344" y="1232" name="XLXI_2" orien="R0" />
        <instance x="832" y="960" name="XLXI_3" orien="R0" />
        <instance x="832" y="1200" name="XLXI_4" orien="R0" />
        <branch name="Clock">
            <wire x2="800" y1="976" y2="976" x1="768" />
            <wire x2="816" y1="976" y2="976" x1="800" />
            <wire x2="816" y1="976" y2="1072" x1="816" />
            <wire x2="832" y1="1072" y2="1072" x1="816" />
            <wire x2="832" y1="896" y2="896" x1="816" />
            <wire x2="816" y1="896" y2="976" x1="816" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="1344" y1="864" y2="864" x1="1088" />
        </branch>
        <branch name="XLXN_3">
            <wire x2="1344" y1="1104" y2="1104" x1="1088" />
        </branch>
        <branch name="XLXN_4">
            <wire x2="1344" y1="976" y2="1040" x1="1344" />
            <wire x2="1680" y1="976" y2="976" x1="1344" />
            <wire x2="1680" y1="864" y2="864" x1="1600" />
            <wire x2="1680" y1="864" y2="976" x1="1680" />
        </branch>
        <branch name="XLXN_5">
            <wire x2="1344" y1="928" y2="944" x1="1344" />
            <wire x2="1664" y1="944" y2="944" x1="1344" />
            <wire x2="1664" y1="944" y2="1104" x1="1664" />
            <wire x2="1664" y1="1104" y2="1104" x1="1600" />
        </branch>
        <instance x="1680" y="896" name="XLXI_5" orien="R0" />
        <instance x="1664" y="1136" name="XLXI_6" orien="R0" />
        <branch name="Qn">
            <wire x2="1936" y1="864" y2="864" x1="1904" />
        </branch>
        <iomarker fontsize="28" x="1936" y="864" name="Qn" orien="R0" />
        <branch name="Q">
            <wire x2="1920" y1="1104" y2="1104" x1="1888" />
        </branch>
        <iomarker fontsize="28" x="1920" y="1104" name="Q" orien="R0" />
        <iomarker fontsize="28" x="768" y="976" name="Clock" orien="R180" />
        <branch name="S">
            <wire x2="832" y1="832" y2="832" x1="800" />
        </branch>
        <iomarker fontsize="28" x="800" y="832" name="S" orien="R180" />
        <branch name="R">
            <wire x2="832" y1="1136" y2="1136" x1="800" />
        </branch>
        <iomarker fontsize="28" x="800" y="1136" name="R" orien="R180" />
        <branch name="Clear">
            <wire x2="1344" y1="1168" y2="1168" x1="1312" />
        </branch>
        <iomarker fontsize="28" x="1312" y="1168" name="Clear" orien="R180" />
        <branch name="Preset">
            <wire x2="1344" y1="800" y2="800" x1="1312" />
        </branch>
        <iomarker fontsize="28" x="1312" y="800" name="Preset" orien="R180" />
    </sheet>
</drawing>