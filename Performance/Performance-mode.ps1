$var = (Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Samsung\SamsungSettings\ModulePerformance -Name Value).Value

$long = ""
$short = ""
$epp = ""
$ssmax = ""
$name = ""

switch ($var) {
	3 {
		$long = ("0x001B8{0:X3}" -f (18 * 8))
		$short = ("0x00438{0:X3}" -f (22 * 8))
		$epp = "84"
		$ssmax = "0x{0:X}01" -f 59
		$name = "High performance"
	}
	2 {
		$long = ("0x001B8{0:X3}" -f (15 * 8))
		$short = ("0x00438{0:X3}" -f (18 * 8))
		$epp = "84"
		$ssmax = "0x{0:X}01" -f 29
		$name = "Optimized"
	}
	1 {
		$long = ("0x001B8{0:X3}" -f (12 * 8))
		$short = ("0x00438{0:X3}" -f (14 * 8))
		$epp = "153"
		$ssmax = "0x{0:X}01" -f 59
		$name = "Quiet"
	}
	0 {
		$long = ("0x001B8{0:X3}" -f (8 * 8))
		$short = ("0x00438{0:X3}" -f (10 * 8))
		$epp = "153"
		$ssmax = "0x{0:X}01" -f 29
		$name = "Silent"
	}
}

$settings = "[ThrottleStop]`nProfileName1=$name`nPowerLimitEAX0=$long`nPowerLimitEDX0=$short`nEnPerfPref0=$epp`nSpeedShiftMaxMin0=$ssmax`nStartFailed=0`nDTSAlarm=1`nGPUAlarm=105`nLowBattPercent=0`nProfile=0`nProfileName2=-`nProfileName3=-`nProfileName4=-`nLogFileDirectory=C:\Windows\Resources\ThrottleStop`nOptions1=0x001008A0`nOptions2=0x001009A0`nOptions3=0x001009A0`nOptions4=0x001009A0`nDutyCycle1=16`nDutyCycle2=16`nDutyCycle3=16`nDutyCycle4=16`nEIST=14`nDTSButton=0`nColorIndex=0`nCPUColor=0xFFFFFF`nGPUColor=0xFFFFFF`nCPUMHzColor=0xFFFFFF`nPowerColor=0xFFFFFF`nMainIcon=1`nCPUIcon=0`nGPUIcon=0`nCPUMHzIcon=0`nPowerIcon=0`nGridLines=1`nBlackIcon=0`nLogoMin=1`nTaskBar=0`nNoTitleBar=0`nZeroChipset=0`nTimePeriodAC=16`nNewWinProfile=0x082082`nNewCStateLimit=0x8888`nHaswellOverclock=0`nWDBoost=1`nBatteryMonitoring=0`nDCExitTime=0`nBeforeRunProgram=15`nBatteryButton=0`nPSMinimum=0`nPayload1=0xC00`nPayload2=0xC00`nPayload3=0xC00`nPayload4=0xC00`nDisableSafeStart=1`nEnPerfPref1=128`nEnPerfPref2=128`nEnPerfPref3=128`nSSTEPP=1`nColor00=0x202020`nColor01=0xFFFFFF`nColor02=0x293DA3`nColor03=0x1F199F`nColor04=0x0000E8`nColor05=0x303030`nColor06=0xFFFFFF`nColor07=0x293DA3`nColor08=0x202020`nColor09=0xFFFFFF`nColor10=0x202020`nColor11=0xFFFFFF`nColor12=0xDD5496`nColor13=0xDD3E8B`nColor14=0xE85CA2`nColor15=0x404040`nColor16=0xFFFFFF`nColor17=0xDD3E8B`nColor18=0x202020`nColor19=0xFFFFFF`nColor20=0xF0F0F0`nColor21=0x000000`nColor22=0xDCDCDC`nColor23=0xDCDCDC`nColor24=0x000000`nColor25=0xE1E1E1`nColor26=0x000000`nColor27=0xD77800`nColor28=0xFFFFFF`nColor29=0x000000`nColor30=0x202020`nColor31=0xFFFFFF`nColor32=0x293DA3`nColor33=0x1F199F`nColor34=0x0000E8`nColor35=0x303030`nColor36=0xFFFFFF`nColor37=0x293DA3`nColor38=0x202020`nColor39=0xFFFFFF`nHotKey0=0x0`nHotKey1=0x0`nHotKey2=0x0`nHotKey3=0x0`nHotKey4=0x0`nFIVRRowHeight=24`nPowerLimitEAX1=0x00DD8060`nPowerLimitEDX1=0x00438060`nPowerLimitEAX2=0x00DD8060`nPowerLimitEDX2=0x00438060`nPowerLimitEAX3=0x00DD8060`nPowerLimitEDX3=0x00438060`nMSRLock=0x0`nPROCHOT_Offset0=0x6`nPROCHOT_Offset1=0x6`nPROCHOT_Offset2=0x6`nPROCHOT_Offset3=0x6`nPROCHOT_Activate=0`nPP0POWERLIMITEAX=0x00000000`nPP0Lock=0`nTDPLevel=0x00000000`nTDPLevelControl=0`nPowerBalancePP0=9`nPowerBalancePP1=13`nPowerPolicy=0`nPowerLimit4=0x00000000`nSpeedShift=1`nSpeedShiftMaxMin1=0x3B01`nSpeedShiftMaxMin2=0x3B01`nSpeedShiftMaxMin3=0x3B01`nNoSetPL=0x0`nSyncMMIO=0x0`nLockPowerLimits=1`nNewCStateDemotion=0xEBAEBA`nMiniMode=0`nSuperMiniMode=0`nStopMonitoring=0`nRowHeight=20`nHeadingView=0`nPROCHOT_Lock=0`n"
Set-Content -Path $PSScriptRoot\ThrottleStop.ini -Value $settings -Force -Encoding Ascii

try {
	Stop-Process -Name "ThrottleStop" -ErrorAction Stop
    "Restarting ThrottleStop..."
}
catch {
	"ThrottleStop wasn't running!"
    "Starting ThrottleStop..."
}
finally {
	Start-Process -FilePath $PSScriptRoot\ThrottleStop.exe -NoNewWindow
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Samsung\SamsungSettings\ModulePerformance" -Name "TabletMode" -Value 0
}