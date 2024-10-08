' ______  __ __    ___   ____  ______  ____     ___       ___   _____      ___ ___   ____   ____  ____   __ 
'|      ||  |  |  /  _] /    ||      ||    \   /  _]     /   \ |     |    |   |   | /    | /    ||    | /  ]
'|      ||  |  | /  [_ |  o  ||      ||  D  ) /  [_     |     ||   __|    | _   _ ||  o  ||   __| |  | /  / 
'|_|  |_||  _  ||    _]|     ||_|  |_||    / |    _]    |  O  ||  |_      |  \_/  ||     ||  |  | |  |/  /  
'  |  |  |  |  ||   [_ |  _  |  |  |  |    \ |   [_     |     ||   _]     |   |   ||  _  ||  |_ | |  /   \_ 
'  |  |  |  |  ||     ||  |  |  |  |  |  .  \|     |    |     ||  |       |   |   ||  |  ||     | |  \     |
'  |__|  |__|__||_____||__|__|  |__|  |__|\_||_____|     \___/ |__|       |___|___||__|__||___,_||____\____|
'
'
' Theatre of Magic - IPDB No. 2845
' © Bally/Midway 1995
' VPX recreation by ninuzzu & Tom Tower
' Thanks to all the authors (JPSalas, Jamin, PacDude, Fuseball, Sacha) who made this table before us.
' Thanks to Clark Kent for the pics and the advices
' Thanks to Hauntfreaks for the magnet decal
' Thanks to Flupper for retexturing and remeshing the plastic ramps
' Thanks to zany for the domes, flippers and bumpers models
' Thanks to knorr for some sound effects I borrowed from his tables
' Thanks to VPDev Team fop the freaking amazing VPX
'
' Theatre of Magic 2.0 by team - Fleep, Rothbauerw, 3rdaxis, Skitso
' Physics redesign, flashers and many logic scripts redesign by Rothbauerw
' Completely new sound system and files by Fleep
' Visuals redesign - GI, Inserts, Flasher, and partial playfield redraw by Skitso
' LUT sets by Skitso, 3rdaxis, Fleep, CalleV
' Advice, Support and Various adjustments, fixes, blade art editing, gold saw mod and script additions by 3rdaxis

' Thanks to ninuzzu & Tom Tower for their VPX recreation
' Thanks to bord for new primitive playfield
' Thanks to G5K for his primitive flippers
' Thanks to flupper for his flasher dome and texture
' Thanks to nickbuol and CalleV for their support and advice regarding TOM real table
' Thanks to CalleV for high res blade art scans

' Special thanks to:
' nickbuol, CalleV, Amazaley1, Jon Osborne - for assisting with pinball recordings of videos and sounds for this big sound project



' Notes (from experience during development):
' In rare cases restarting VPM will reset the switches without properly reinitialize the them. 
' As result - the trunk does not function properly or the table has a missing ball. In such case delete NVRAM and cfg file and restart the game.



Option Explicit
Randomize

Dim FlipperType,FlipperCoilRampupMode, TDFlasher, TDFlasherColor, TrunkShake, TigerSaw, CenterPost, VROn, BladeArt, TigerSawMod, FlasherMod, GoldRails
Dim OutlaneDifficulty
Dim LUTset, DisableLUTSelector, LutToggleSound


'////////////////////////////  MECHANICAL SOUNDS OPTIONS  ///////////////////////////
'//  For the entire sound system scripts see mechanical sounds block at the end of this project.


'///////////////////////-----General Sound Options-----///////////////////////
'//  VolumeDial:
'//  VolumeDial is the actual global volume multiplier for the mechanical sounds.
'//  Values smaller than 1 will decrease mechanical sounds volume.
'//  Recommended values should be no greater than 1.
Const VolumeDial = 0.8


'//  PositionalSoundPlaybackConfiguration:
'//  Specifies the sound playback configuration. Options:
'//  1 = Mono
'//  2 = Stereo (Only L+R channels)
'//  3 = Surround (Full surround sound support for SSF - Front L + Front R + Rear L + Rear R channels)
Const PositionalSoundPlaybackConfiguration = 3


'//  RelaysPosition:
'//  1 = Relays positioned with power board (Provides sound spread from the left and right back channels)
'//  2 = Relays positioned with GI strings (Provides sound spread from left/right/front/rear surround channels)
Const RelaysPosition = 2



'************************************************************************
'* TABLE OPTIONS ********************************************************
'************************************************************************

'***********	Set the default LUT set	*********************************
'LUTset Types:
'0 = Fleep Natural Dark 1
'1 = Fleep Natural Dark 2
'2 = Fleep Warm Dark
'3 = Fleep Warm Bright
'4 = Fleep Warm Vivid Soft
'5 = Fleep Warm Vivid Hard
'6 = Skitso Natural and Balanced
'7 = Skitso Natural High Contrast
'8 = 3rdaxis Referenced THX Standard
'9 = CalleV Punchy Brightness and Contrast
'10 = TT & Ninuzzu Original

'You can change LUT option within game with left and right CTRL keys

LUTset = 8
DisableLUTSelector = 0  ' Disables the ability to change LUT option with magna saves in game when set to 1
LutToggleSound = 1			'0 = Disable LUT toggle sound, 1 = Enable LUT toggle sound

' For LUT sound volume level look in sound scripts down below

'***********	Set the Flippers Type	*********************************

FlipperType = 0 			'0 = white , 1 = yellow , 2 = random

' FlipperCoilRampupMode
' Flipper coil ramp behavior in-game:
' Either of the following modes may feel more natural
' Depends on various factors such as system specifications, playfield monitor, GPU settings, flipper keys vs. leaf switches

' 0 - Static - flipper coil-ramp up is static; Underpowered systems may need to use this mode.
' 1 - Dynamic - flipper coil-ramp up changes dynamically for a better simulation of tap pass capabilities. Requires a fast system - otherwise may introduce a possible flipper lag

FlipperCoilRampupMode = 0

'***********	Enable Flasher under the TrapDoor 	*********************

TDFlasher = 1			'0 = no , 1 = yes
TDFlasherColor = 3		'0 = red, 1 = green, 2 = blue, 3 = yellow, 4 = purple, 5= cyan

'***********	Shake the Trunk on Hit		*****************************

TrunkShake = 1			'0 = no , 1 = yes

'***********	Rotate the TigerSaw (only in prototypes) ****************

TigerSaw = 1				'0 = no , 1 = yes

'***********    Tiger Saw Mod    ****************************************

TigerSawMod = 0  			' 0 = Silver, 1 = Gold

'***********	Enable Center Post (only in prototypes) *****************

CenterPost = 0			'0 = no , 1 = yes

'***********	Outlane gap drain difficulty adjustment ***************** 'AXS

OutlaneDifficulty = 2	 ' 1 = EASY, 2 = MEDIUM (Factory), 3 = HARD

'***********	Enable VR                               *****************

VROn = 0 					' 0 = Off, 1 = On

'***********    Blade Art Mod    ****************************************

BladeArt = 0  			' 0 = Off, 1 = On

'***********    Modulated Flashers   ************************************

' Select 0 for better performance, 1 if you want more realistic Flasher effects

FlasherMod = 0  			' 0 = On/Off, 1 = Modulated

'***********    Gold Rails and Lockdown Bar    **************************

GoldRails = 0                        ' 0 = Chrome, 1 = Gold

'************************************************************************
'* END OF TABLE OPTIONS *************************************************
'************************************************************************

Dim Ballsize,BallMass
BallSize = 50
BallMass = 1

On Error Resume Next
ExecuteGlobal GetTextFile("controller.vbs")
If Err Then MsgBox "You need the controller.vbs in order to run this table, available in the vp10 package"
On Error Goto 0

Dim DesktopMode:DesktopMode = Table1.ShowDT
If VROn = 1 Then DesktopMode = True:ScoreText.visible = false

Dim UseVPMColoredDMD:UseVPMColoredDMD= DesktopMode
'Dim UseVPMDMD:UseVPMDMD = DesktopMode

'********************
'Standard definitions
'********************

Const UseSolenoids = 2
Const UseLamps = 0
Const UseSync = 0
Const HandleMech = 0
If FlasherMod = 1 Then Const UseVPMModSol = 1

Const cSingleLFlip = False
Const cSingleRFlip = False

 ' Standard Sounds
Const SSolenoidOn = ""
Const SSolenoidOff = ""
Const SFlipperOn = ""
Const SFlipperOff = ""
'Const SCoin = "Coin_In_3"

LoadVPM "01560000", "WPC.VBS", 3.50
 
Set GiCallback2 = GetRef("UpdateGI")
 
Dim LeftMagnet, RightMagnet

' using table width and height in script slows down the performance
dim tablewidth: tablewidth = Table1.width
dim tableheight: tableheight = Table1.height

'******************************************************
' 					TABLE INIT
'******************************************************

 Const cGameName = "tom_13" '1.3x arcade rom - with credits

Dim  TOMBall1, TOMBall2, TOMBall3, TOMBall4, zz
Dim CapL1, CapL2

 Sub Table1_Init
	vpmInit Me
	With Controller
		.GameName = cGameName
		.SplashInfoLine = "Theatre of Magic - Bally 1995"
		.HandleKeyboard = 0
		.ShowTitle = 0
		.ShowDMDOnly = 1
		.ShowFrame = 0
		.HandleMechanics = 0
		.Hidden = DesktopMode
		On Error Resume Next
		.Run GetPlayerHWnd
		If Err Then MsgBox Err.Description
		On Error Goto 0
		.Switch(22) = 1			'close coin door
		.Switch(24) = 1 		'and keep it close
	End With
	
	' Initialize Trunk
	Controller.Switch(55) = 1
	Controller.Switch(56) = 0
	Controller.Switch(57) = 1
	Controller.Switch(58) = 1

	 ' Nudging
	 vpmNudge.TiltSwitch = 14
	 vpmNudge.Sensitivity = 3
	 vpmNudge.TiltObj = Array(Bumper1, Bumper2, Bumper3, LeftSlingshot, RightSlingshot)

	 ' Left Magnet
	 Set LeftMagnet = New cvpmMagnet
	 With LeftMagnet
		 .InitMagnet LMagnet, 30
		 .CreateEvents "LeftMagnet"
		 .GrabCenter = 0
	 End With
 
	 ' Right Magnet
	 Set RightMagnet = New cvpmMagnet
	 With RightMagnet
		 .InitMagnet RMagnet, 30
		 .CreateEvents "RightMagnet"
		 .GrabCenter = 0
	 End With

	 ' Main Timer init
	 PinMAMETimer.Interval = PinMAMEInterval
	 PinMAMETimer.Enabled = 1

	'************  Trough init
	Set TOMBall1 = sw32.CreateSizedBallWithMass (Ballsize/2, BallMass)
	Set TOMBall2 = sw33.CreateSizedBallWithMass (Ballsize/2, BallMass)
	Set TOMBall3 = sw34.CreateSizedBallWithMass (Ballsize/2, BallMass)
	Set TOMBall4 = sw35.CreateSizedBallWithMass (Ballsize/2, BallMass)

	Controller.Switch(35) = 1
	Controller.Switch(34) = 1
	Controller.Switch(33) = 1
	Controller.Switch(32) = 1

	'************  Captive Balls
	Set CapL1 = CapKicker1.CreateSizedballWithMass (Ballsize/2,Ballmass)
	Set CapL2 = CapKicker.CreateSizedballWithMass (Ballsize/2,Ballmass)

	CapKicker1.kick 0,0,0
	CapKicker.kick 0,0,0

	CapL1.FrontDecal = "NoScratches"
	CapL2.FrontDecal = "NoScratches"

	Controller.Switch(52) = 1

	'************  Mirror Balls	
	Set BallM(1) = MKick(1).CreateSizedBallWithMass (Ballsize/2, BallMass)
	Set BallM(2) = MKick(2).CreateSizedBallWithMass (Ballsize/2, BallMass)
	Set BallM(3) = MKick(3).CreateSizedBallWithMass (Ballsize/2, BallMass)
	Set BallM(4) = MKick(4).CreateSizedBallWithMass (Ballsize/2, BallMass)

	'************  Mirrored Primitives and lights init
	InitMirror sw66p, sw66m
	InitMirror sw67p, sw67m
	InitMirror LLoopGateP, LLoopGatePm
	InitMirror RLoopGateP, RLoopGatePm
	InitMirror2 LLoopGateSw, LLoopGateSwm
	InitMirror2 RLoopGateSw, RLoopGateSwm
	InitMirror Wiregate, Wiregatem
	InitMirror Prim_Lane1, Prim_Lane1m
	InitMirror Prim_Lane2, Prim_Lane2m
	InitMirror Prim_Lane3, Prim_Lane3m
	InitMirror PegMetal10, PegMetal10m
	InitMirror PegPlastic19, PegPlastic19m
	InitMirror PegPlastic20, PegPlastic20m
	InitMirror PegPlastic21, PegPlastic21m
	InitMirror PegPlastic22, PegPlastic22m
	InitMirror PegPlastic23, PegPlastic23m
	InitMirror PegPlastic24, PegPlastic24m 'AXS (this was missing) Fixed
	InitMirror bracket14, bracket14m
	InitMirror Screw3, Screw3m
	InitMirror Screw4, Screw4m
	InitMirror Screw5, Screw5m
	InitMirror Screw6, Screw6m
	InitMirror Screw7, Screw7m
	InitMirror Screw8, Screw8m
	InitMirror Plastics10, Plastics10m
	InitMirror Plastics13, Plastics13m
	InitMirror Plastics13, Plastics13m
	InitMirror BS1, BS4 'AXS (these don't seem to be showing Up) Fix
	InitMirror BB1, BB4
	InitMirror BR1, BR4
	InitMirror BC1, BC4
	InitMirror Rub7, Rub7m
	InitMirror Rub8, Rub8m
	InitMirror Rub9, Rub9m
	InitMirror Rub10, Rub10m
	InitMirror Rub11, Rub11m
	InitMirror Rub12, Rub12m
	InitMirror Rub13, Rub13m
	InitMLights l37a, - 345.9, 1    
	InitMLights l38a, - 345.9, 1    
	InitMLights GIa, - 363, 58
	InitMLights GIa1, - 258, 58
	InitMLights GIa2, - 263, 58
	InitMLights GIa3, - 240.5, 58
	InitMLights GIa4, - 223, 58
	RLoopGatePm.visible = DesktopMode
	RLoopGateSwm.visible = DesktopMode
	LLoopGatePm.visible = DesktopMode
	LLoopGateSwm.visible = DesktopMode
	RailL.visible = DesktopMode And GoldRails = 0
	RailR.visible = DesktopMode And GoldRails = 0
	Primary_LockDownBar.visible = DesktopMode And GoldRails = 0
        RailBarGold.visible = DesktopMode And GoldRails = 1


	'************  Misc Stuff init
	SolTrapDoorUp 0
	DivPost.IsDropped = 1
	LoopPost.IsDropped = 1
	sw85.IsDropped = 0 			' Default start position
	TrunkBlock.IsDropped = 1
	CPC.IsDropped = 1

	PreloadImages

	'****************   Init flashers   ******************
	If FlasherMod = 1 Then 
		SetModLamp 120, 0
		SetModLamp 123, 0
		SetModLamp 124, 0
		SetModLamp 125, 0
		SetModLamp 126, 0
		SetModLamp 127, 0
		SetModLamp 128, 0
	Else
		SetLamp 120, 0
		SetLamp 123, 0
		SetLamp 124, 0
		SetLamp 125, 0
		SetLamp 126, 0
		SetLamp 127, 0
		SetLamp 128, 0
	End If

	for each zz in Inserts
		zz.FadeSpeedUp = zz.FadeSpeedUp / 2
		zz.FadeSpeedDown = zz.FadeSpeedDown / 2
	next

 End Sub


'******************************************************
' 						KEYS
'******************************************************
Dim SwordNum, FootStepNum
SwordNum = 0
FootStepNum = 0

Sub Table1_KeyDown(ByVal Keycode)
	
	If keycode = StartGameKey Then soundStartButton()
	If keycode = KeyFront Then Controller.Switch(23) = 1 : SoundStartButton()
	If keycode = PlungerKey Then Plunger.Pullback : SoundPlungerPull()
	If keycode = LeftTiltKey Then Nudge 90, 4 : SoundNudgeLeft()
	If keycode = RightTiltKey Then Nudge 270, 4 : SoundNudgeRight()
	If keycode = CenterTiltKey Then Nudge 0, 5 : SoundNudgeCenter()

	If keycode = LeftFlipperKey Then FlipperActivate LeftFlipper, LFPress
	If keycode = RightFlipperKey Then FlipperActivate RightFlipper, RFPress 

	If keycode = keyInsertCoin1 or keycode = keyInsertCoin2 or keycode = keyInsertCoin3 or keycode = keyInsertCoin4 Then
		Select Case Int(rnd*3)
			Case 0: PlaySoundAtLevelStatic ("Coin_In_1"), CoinSoundLevel, OutHole
			Case 1: PlaySoundAtLevelStatic ("Coin_In_2"), CoinSoundLevel, OutHole
			Case 2: PlaySoundAtLevelStatic ("Coin_In_3"), CoinSoundLevel, OutHole
		End Select
	End If

	If vpmKeyDown(keycode) Then Exit Sub
End Sub

Sub Table1_KeyUp(ByVal Keycode)
	If Keycode = KeyFront Then Controller.Switch(23) = 0
	If keycode = PlungerKey Then 
		Plunger.Fire
		If controller.switch(15) = True Then 	'If true then ball in shooter lane, else no ball is shooter lane
			SoundPlungerReleaseBall()			'Plunger release sound when there is a ball in shooter lane
		Else
			SoundPlungerReleaseNoBall()			'Plunger release sound when there is no ball in shooter lane
		End If
	End If

	If keycode = LeftFlipperKey Then FlipperDeActivate LeftFlipper, LFPress
	If keycode = RightFlipperKey Then FlipperDeActivate RightFlipper, RFPress

	If keycode = RightMagnaSave Then 'AXS 'Fleep
		if DisableLUTSelector = 0 then
			If LutToggleSound Then
				Playsound "LUT_Toggle_Up_Front", 0, LutToggleSoundLevel * VolumeDial, 0, 0.2, 0, 0, 0, 1
				Playsound "LUT_Toggle_Up_Rear", 0, LutToggleSoundLevel * VolumeDial, 0, 0.2, 0, 0, 0, -1
			End If
            LUTSet = LUTSet  + 1
			if LutSet > 10 then LUTSet = 0
			SetLUT
			ShowLUT
		end if
	end if
	If keycode = LeftMagnaSave Then
		if DisableLUTSelector = 0 then
			If LutToggleSound Then
				Playsound "LUT_Toggle_Down_Front", 0, LutToggleSoundLevel * VolumeDial, 0, 0.2, 0, 0, 0, 1
				Playsound "LUT_Toggle_Down_Rear", 0, LutToggleSoundLevel * VolumeDial, 0, 0.2, 0, 0, 0, -1
			End If
			LUTSet = LUTSet - 1
			if LutSet < 0 then LUTSet = 10
			SetLUT
			ShowLUT
		end if
	end if

	If vpmKeyUp(keycode) Then Exit Sub
End Sub

Sub Table1_Paused: Controller.Pause = 1:End Sub
Sub Table1_UnPaused: Controller.Pause = 0:End Sub
Sub Table1_Exit(): Controller.Stop:End Sub


'******************************************************
' 					LUT
'******************************************************


Sub SetLUT  'AXS
	UpdateGI 4, 8
end sub 

Sub LUTBox_Timer
	LUTBox.TimerEnabled = 0 
	LUTBox.Visible = 0
End Sub

Sub ShowLUT
	LUTBox.visible = 1
	Select Case LUTSet
		Case 0: LUTBox.text = "Fleep Natural Dark 1"
		Case 1: LUTBox.text = "Fleep Natural Dark 2"
		Case 2: LUTBox.text = "Fleep Warm Dark"
		Case 3: LUTBox.text = "Fleep Warm Bright"
		Case 4: LUTBox.text = "Fleep Warm Vivid Soft"
		Case 5: LUTBox.text = "Fleep Warm Vivid Hard"
		Case 6: LUTBox.text = "Skitso Natural and Balanced"
		Case 7: LUTBox.text = "Skitso Natural High Contrast"
		Case 8: LUTBox.text = "3rdaxis Referenced THX Standard"
		Case 9: LUTBox.text = "CalleV Punchy Brightness and Contrast"
		Case 10: LUTBox.text = "TT & Ninuzzu Original"
	End Select
	LUTBox.TimerEnabled = 1
End Sub



'******************************************************
' 					SWITCHES
'******************************************************

'**********Rollovers
 Sub Switches_Hit(idx)
	Controller.Switch(Switches(idx).timerinterval)=1
	If Switches(idx).timerinterval = 15 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 25 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 26 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 27 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 28 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 52 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 53 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 54 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 66 Then sw66m.transZ = -30 * dCos(mAngle) : sw66m.transY =  -30 * dSin(mAngle) : RandomSoundRollover()
	If Switches(idx).timerinterval = 67 Then sw67m.transZ = -30 * dCos(mAngle): sw66m.transY = - 30 * dSin(mAngle) : RandomSoundRollover()
	If Switches(idx).timerinterval = 77 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 78 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 81 Then RandomSoundRollover()
	If Switches(idx).timerinterval = 86 Then RandomSoundRollover()
 End Sub

 Sub Switches_UnHit(idx)
	Controller.Switch(Switches(idx).timerinterval)=0
	If Switches(idx).timerinterval = 66 Then sw66m.transZ = 0 : sw66m.transY = 0
	If Switches(idx).timerinterval = 67 Then sw67m.transZ = 0 : sw67m.transY = 0
 End Sub

'**********Ramp Switches
 Sub RampSwitches_Hit(idx)
	vpmTimer.PulseSw (RampSwitches(idx).timerinterval)
	If RampSwitches(idx).timerinterval = 73 Then sw73flip.RotatetoEnd
	If RampSwitches(idx).timerinterval = 74 Then sw74flip.RotatetoEnd
	If RampSwitches(idx).timerinterval = 75 Then If ActiveBall.VelY < 0 Then SoundRampBrktGate1(SoundOn) : Else SoundRampBrktGate1(SoundOff) : End If
	If RampSwitches(idx).timerinterval = 76 Then If ActiveBall.VelY < 0 Then SoundRampBrktGate2(SoundOn) : Else SoundRampBrktGate2(SoundOff) : End If
	If RampSwitches(idx).timerinterval = 87 Then sw87flip.RotatetoEnd
 End Sub

 Sub RampSwitches_UnHit(idx)
	If RampSwitches(idx).timerinterval = 73 Then sw73flip.RotatetoStart
	If RampSwitches(idx).timerinterval = 74 Then sw74flip.RotatetoStart
	If RampSwitches(idx).timerinterval = 87 Then sw87flip.RotatetoStart
 End Sub
'**********Spinner
 Sub sw37_Spin():vpmTimer.PulseSw 37:SoundSpinner():End Sub

'**********Targets
Sub sw51_Hit
	vpmTimer.PulseSw 51
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
 		RandomSoundTargetHitStrong()
		RandomSoundBallBouncePlayfieldSoft()
	End if
	If finalspeed <= 10 then
 		RandomSoundTargetHitWeak()
 	End If	
End Sub

Sub sw51b_Hit
	vpmTimer.PulseSw 51
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
 		RandomSoundTargetHitStrong()
		RandomSoundBallBouncePlayfieldSoft()
	End if
	If finalspeed <= 10 then
 		RandomSoundTargetHitWeak()
 	End If	
End Sub

Sub sw38_Hit
	vpmTimer.PulseSw 38
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
 		RandomSoundTargetHitStrong()
		RandomSoundBallBouncePlayfieldSoft()
	End if
	If finalspeed <= 10 then
 		RandomSoundTargetHitWeak()
 	End If	
End Sub

Sub sw82_Hit
	vpmTimer.PulseSw 82
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
 		RandomSoundTargetHitStrong()
		RandomSoundBallBouncePlayfieldSoft()
	End if
	If finalspeed <= 10 then
 		RandomSoundTargetHitWeak()
 	End If	
End Sub

Sub sw82b_Hit
	vpmTimer.PulseSw 82
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
 		RandomSoundTargetHitStrong()
		RandomSoundBallBouncePlayfieldSoft()
	End if
	If finalspeed <= 10 then
 		RandomSoundTargetHitWeak()
 	End If	
End Sub

Sub LLoopGate_Hit() : RandomSoundMetal() : End Sub
Sub RLoopGate_Hit() : RandomSoundMetal() : End Sub


'******************************************************
'					SOLENOIDS
'******************************************************

'standard coils
SolCallback(1) = "SolRelease"							'Ball Trough
SolCallback(2) = "SolSpiritRing"							'Magnet Diverter
SolCallback(3) = "SolTrapDoorUp"							'Trap Door Up
SolCallback(4) = "SolSubwayPopper"						'Subway Popper
SolCallback(5) = "SolRightMagnet"						'Right Drain Magnet
SolCallback(6) = "SolLoopPost"							'Center Loop Post
SolCallback(7) = "SolKnocker"							'Knocker
SolCallback(8) = "SolDivPost"							'Top Diverter Post
'SolCallback(9) = "SolLSling"							'Left Slingshot
'SolCallback(10) = "SolRSling"							'RIght Slingshot
'SolCallback(11) = "SolBottomJet"						'Bottom Bumper
'SolCallback(12) = "SolMiddleJet"						'Middle Bumper
'SolCallback(13) = "SolTopJet"							'Top Bumper
SolCallback(14) = "SolTrapDoorHold"						'Trap Door Hold
SolCallBack(15) = "SolGate3"								'Left Up/Down Gate
SolCallback(16) = "SolGate1"								'Right Up/Down Gate
SolCallback(17) = "SolTrunkMotorCW"						'Move Trunk Clockwise
SolCallback(18) = "SolTrunkMotorCCW"						'Move Trunk Counter Clockwise
SolCallback(21) = "SolTopKickout"						'Top Kickout

If FlasherMod = 0 Then
	SolCallBack(20) = "SetLamp 120,"							'Return Lane Flasher (x2)
	If CenterPost Then SolCallback(23) = "SetLamp 123,"		'Magic Post Flasher (***)
	SolCallback(24) = "SetLamp 124,"							'Trap Door Flasher (x2)
	SolCallback(25) = "SetLamp 125,"							'Spirit Ring Flasher (x2)
	SolCallback(26) = "SetLamp 126,"							'Saw Flasher (x4)
	SolCallback(27) = "SetLamp 127,"							'Bumper Flasher (x4)
	SolCallBack(28) = "SetLamp 128,"							'Trunk Flasher (x3)
Else
	SolModCallBack(20) = "SetModLamp 120,"					'Return Lane Flasher (x2)
	If CenterPost Then SolModCallback(23) = "SetModLamp 123,"	'Magic Post Flasher (***)
	SolModCallback(24) = "SetModLamp 124,"					'Trap Door Flasher (x2)
	SolModCallback(25) = "SetModLamp 125,"					'Spirit Ring Flasher (x2)
	SolModCallback(26) = "SetModLamp 126,"					'Saw Flasher (x4)
	SolModCallback(27) = "SetModLamp 127,"					'Bumper Flasher (x4)
	SolModCallBack(28) = "SetModLamp 128,"					'Trunk Flasher (x3)
End If

'aux board
SolCallback(33) = "SolTrunkMagnet"						'Trunk Magnet
SolCallback(34) = "SolSubBallRelease"					'Subway BallRelease
SolCallback(35) = "SolLeftMagnet"						'Left Drain Magnet

'fliptronic board
 SolCallback(sLLFlipper) = "SolLFlipper"					'Left Flipper
 SolCallback(sLRFlipper) = "SolRFlipper"					'Right Flipper

'prototype extra coils
If CenterPost Then SolCallback(36) = "SolMagicPost"		'Magic Post Up/Down (***)
If TigerSaw Then SolCallBack(19) = "SolTigerSaw"		'Move the TigerSaw (***)

'******************************************************
'			TROUGH BASED ON FOZZY'S
'******************************************************

Dim BIP : BIP = 0

Sub sw35_Hit():Controller.Switch(35) = 1:UpdateTrough: End Sub
Sub sw35_UnHit():Controller.Switch(35) = 0:UpdateTrough:End Sub

Sub sw34_Hit():Controller.Switch(34) = 1:End Sub
Sub sw34_UnHit():Controller.Switch(34) = 0:UpdateTrough:End Sub

Sub sw33_Hit():Controller.Switch(33) = 1:End Sub
Sub sw33_UnHit():Controller.Switch(33) = 0:UpdateTrough:End Sub

Sub sw32_Hit():Controller.Switch(32) = 1:End Sub
Sub sw32_UnHit():Controller.Switch(32) = 0:UpdateTrough:End Sub

Sub sw31_Hit():vpmTimer.PulseSw 31 : BIP = BIP + 1:End Sub

Sub UpdateTrough()
	Subway.TimerInterval = 300
	Subway.TimerEnabled = 1
End Sub

Sub Subway_Timer()
	If sw32.BallCntOver = 0 Then sw33.kick 65, 6
	If sw33.BallCntOver = 0 Then sw34.kick 65, 6
	If sw34.BallCntOver = 0 Then sw35.Kick 65, 6
	If sw35.BallCntOver = 0 Then OutHole.kick 65,8
	If sw41.BallCntOver = 0 Then sw42.kick 120, 6
	If sw42.BallCntOver = 0 Then sw43.kick 120, 6
	Me.TimerEnabled = 0
End Sub

'******************************************************
'				DRAIN & RELEASE
'******************************************************

Sub OutHole_Hit()
	RandomSoundDrain()
	UpdateTrough
	BIP = BIP - 1
End Sub


Sub SolRelease(enabled)
	If Enabled Then
		RandomSoundBallRelease()
		sw32.kick 65, 8
		UpdateTrough
	End If
End Sub

'RandomSoundBottomArchBallGuide - Soft Bounces
Sub Wall014_Hit() : RandomSoundBottomArchBallGuide() : End Sub
Sub Wall015_Hit() : RandomSoundBottomArchBallGuide() : End Sub

'RandomSoundBottomArchBallGuide - Hard Hit
Sub Wall008_Hit() : RandomSoundBottomArchBallGuideHardHit() : End Sub
Sub Wall009_Hit() : RandomSoundBottomArchBallGuideHardHit() : End Sub

'RandomSoundFlipperBallGuide
Sub Wall2_Hit() : RandomSoundFlipperBallGuide() : End Sub
Sub Wall13_Hit() : RandomSoundFlipperBallGuide() : End Sub

'RandomSoundWireformAntiRebountRail
Sub rail001_Hit() : RandomSoundWireformAntiRebountRail() : End Sub
Sub rail002_Hit() : RandomSoundWireformAntiRebountRail() : End Sub

'******************************************************
'					DIVERTERS & GATES
'******************************************************

Dim isVanishLockGranted : isVanishLockGranted = 0

Sub SolLoopPost(enabled)
	If Enabled Then
		LoopPost.IsDropped = 0
		RandomSoundLoopPostSolenoid(Up)
		SoundLoopPostMagnet(SoundOn)
	Else
		LoopPost.IsDropped = 1
		RandomSoundLoopPostSolenoid(Down)
		SoundLoopPostMagnet(SoundOff)
	End If
End Sub

Sub SolDivPost(enabled)
	If Enabled Then
		DivPost.IsDropped = 0
		SoundDiverterPostSolenoid(Up)
		SoundDiverterPostMagnet(SoundOn)
		isVanishLockGranted = 1
	Else
		DivPost.IsDropped = 1
		SoundDiverterPostSolenoid(Down)
		SoundDiverterPostMagnet(SoundOff)
		isVanishLockGranted = 0
	End If
End Sub

Sub SolGate1(enabled)
	vpmSolGate Gate1,0,enabled
	If enabled Then
		SoundGate1Actuator(ActuatorOpened)
	Else
		SoundGate1Actuator(ActuatorClosed) 
	End If
End Sub


Sub SolGate3(enabled)
	vpmSolGate Gate3,0,enabled
	If enabled Then
		SoundGate3Actuator(ActuatorOpened)
	Else
		SoundGate3Actuator(ActuatorClosed)
	End If	
End Sub


Dim Gate4Enabled : Gate4Enabled = 0
Sub Gate1_Hit():SoundBallGate1():End Sub
Sub Gate2_Hit():SoundBallGate2():End Sub
Sub Gate3_Hit():SoundBallGate3():End Sub
Sub Gate4_Hit():Gate4Enabled = 1:End Sub
Sub Gate6_Hit():SoundBallGate6():End Sub
Sub c1_Hit():SoundBallGate_c1():End Sub

'******************************************************
'					KNOCKER
'******************************************************

Sub SolKnocker(enabled)
	If enabled Then
		KnockerSolenoid()
	End If
End Sub

'****************************************************
'				VANISH LOCK
'****************************************************

Sub sw84_Hit()
	Controller.Switch(84) = 1
	SoundVanishSolenoidLock(Vanish_sw84)
End Sub
Sub sw84_UnHit():Controller.Switch(84) = 0:End Sub

Sub sw83_Hit()
	Controller.Switch(83) = 1	
	SoundVanishSolenoidLock(Vanish_sw83)
End Sub
Sub sw83_UnHit():Controller.Switch(83) = 0:End Sub

Sub SolTopKickout(Enabled)
	If Enabled then
		If sw83.ballcntover = 0 Then								'no ball in the vanish lock
			SoundVanishSolenoidKickout(NoBallLocked)
		Elseif sw84.ballcntover = 0 Then							' only one ball in the vanish lock
			SoundVanishSolenoidKickout(OneBallLocked)
			vpmtimer.addtimer 135, "RandomSoundVanishKickoutBallDropOnPlayfield '"
			TrunkMagnets 0
		Else													'two balls in the vanish lock
			SoundVanishSolenoidKickout(TwoBallsLocked)
			TrunkMagnets 0
		End If
		sw83.kick 295,20
	End If
End Sub

'******************************************************
'					LOCK 
'******************************************************

Sub sw44_Hit():Controller.Switch(44) = 1 : RandomSoundTrunkTrough_1() : End Sub
Sub sw44_UnHit():Controller.Switch(44) = 0 :End Sub

Sub sw43_Hit():Controller.Switch(43) = 1 : UpdateTrough : RandomSoundTrunkTrough_2_Multiball() : End Sub
Sub sw43_UnHit():Controller.Switch(43) = 0 :UpdateTrough:End Sub

Sub sw42_Hit():Controller.Switch(42) = 1 : End Sub
Sub sw42_UnHit():Controller.Switch(42) = 0: UpdateTrough : End Sub

Sub sw41_Hit():Controller.Switch(41) = 1 : SoundTrunkTrough_3() : End Sub
Sub sw41_UnHit():Controller.Switch(41) = 0 : UpdateTrough:End Sub

Sub SolSubBallRelease(Enabled)
     If Enabled Then
		RandomSoundTrapdoorSubRelease()
		sw41.kick 135,10
     End If
End sub

Sub SolSubwayPopper(Enabled)
	If Enabled Then
		sw44.kickz 192.5 + rnd*2.5, 19 + rnd*2, 0.6, 60 '1.56
		Controller.Switch(44) = 0
		RandomSoundTrapdoorEjectPopper()
		vpmtimer.addtimer 85, "RandomSoundTrapdoorBallDropOnPlayfield '"
	End If
End Sub

'******************************************************
'				SLINGSHOTS
'******************************************************

Dim LStep, RStep

Sub LeftSlingshot_Slingshot
    RandomSoundSlingshotLeft()
	'RandomSoundRubberStrong()
	vpmTimer.PulseSw 61
    LSling.Visible = 0
    LSling2.Visible = 1
    sling2.TransZ = -10
    LStep = 0
    Me.TimerEnabled = 1
End Sub

Sub LeftSlingshot_Timer
    Select Case LStep
	Case 0:LSLing1.Visible = 1:LSLing2.Visible = 0:sling2.TransZ = -20
        Case 3:LSLing1.Visible = 0:LSLing2.Visible = 1:sling2.TransZ = -10
        Case 4:LSLing2.Visible = 0:LSLing.Visible = 1:sling2.TransZ = 0:Me.TimerEnabled = 0
    End Select
    LStep = LStep + 1
End Sub

Sub RightSlingshot_Slingshot
    RandomSoundSlingshotRight()
	'RandomSoundRubberStrong()
	vpmTimer.PulseSw 62
    RSling.Visible = 0
    RSling2.Visible = 1
    sling1.TransZ = -10
    RStep = 0
    Me.TimerEnabled = 1
End Sub

Sub RightSlingshot_Timer
    Select Case RStep
	Case 0:RSLing1.Visible = 1:RSLing2.Visible = 0:sling1.TransZ = -20
        Case 3:RSLing1.Visible = 0:RSLing2.Visible = 1:sling1.TransZ = -10
        Case 4:RSLing2.Visible = 0:RSLing.Visible = 1:sling1.TransZ = 0:Me.TimerEnabled = 0
    End Select
    RStep = RStep + 1
End Sub

'******************************************************
'					BUMPERS
'******************************************************

Dim dirRing1 : dirRing1 = -1
Dim dirRing2 : dirRing2 = -1
Dim dirRing3 : dirRing3 = -1

Sub Bumper1_Hit
	vpmTimer.PulseSw 65
	RandomSoundBumperA()
	Me.TimerEnabled = 1
End Sub

Sub Bumper2_Hit
	vpmTimer.PulseSw 64
	RandomSoundBumperB()
	Me.TimerEnabled = 1
End Sub

Sub Bumper3_Hit : 
	vpmTimer.PulseSw 63
	RandomSoundBumperC()
	Me.TimerEnabled = 1
End Sub

Sub Bumper1_timer()
	BR1.Z = BR1.Z + (5 * dirRing1)
	BR4.Y = mdistY - SQR((ABS(BR1.Y)-mdistY)^2 +(BR1.Z)^2) * dCos(mangle) + BR1.Z * dSin(mangle)
	BR4.Z = BR1.Z * dCos(mangle) + SQR((ABS(BR1.Y)-mdistY)^2 +(BR1.Z)^2) * dSin(mangle)
	If BR1.Z <= 0 Then dirRing1 = 1
	If BR1.Z >= 40 Then
		dirRing1 = -1
		BR1.Z = 40
		Me.TimerEnabled = 0
	End If
End Sub

Sub Bumper2_timer()
	BR2.Z = BR2.Z + (5 * dirRing2)
	If BR2.Z <= 0 Then dirRing2 = 1
	If BR2.Z >= 40 Then
		dirRing2 = -1
		BR2.Z = 40
		Me.TimerEnabled = 0
	End If
End Sub

Sub Bumper3_timer()
	BR3.Z = BR3.Z + (5 * dirRing3)
	If BR3.Z <= 0 Then dirRing3 = 1
	If BR3.Z >= 40 Then
		dirRing3 = -1
		BR3.Z = 40
		Me.TimerEnabled = 0
	End If
End Sub

'******************************************************
'				NFOZZY'S FLIPPERS
'******************************************************

Const ReflipAngle = 20

Sub SolLFlipper(Enabled)
    If Enabled Then
		LF.Fire
			If leftflipper.currentangle < leftflipper.endangle + ReflipAngle Then 
				'Play partial flip sound
				RandomSoundReflipUpLeft()
			Else 
				'Play full flip sound
				'LeftFlipper.RotateToEnd
				SoundFlipperUpAttackLeft()
				RandomSoundFlipperUpLeft()
			End If
    Else
		LeftFlipper.RotateToStart
		If LeftFlipper.currentangle < LeftFlipper.startAngle - 5 Then
			RandomSoundFlipperDownLeft()
		End If
		FlipperLeftHitParm = FlipperUpSoundLevel
    End If
End Sub


Sub SolRFlipper(Enabled)
    If Enabled Then
		RF.Fire
			If rightflipper.currentangle > rightflipper.endangle - ReflipAngle Then
				'Play partial flip sound
				RandomSoundReflipUpRight()
			Else 
				'Play full flip sound
				'RightFlipper.RotateToEnd
				SoundFlipperUpAttackRight()
				RandomSoundFlipperUpRight()
			End If
    Else
		RightFlipper.RotateToStart
		If RightFlipper.currentangle > RightFlipper.startAngle + 5 Then
			RandomSoundFlipperDownRight()
		End If	
		FlipperRightHitParm = FlipperUpSoundLevel
    End If
End Sub


RightFlipper.timerinterval=1
Rightflipper.timerenabled=True

sub RightFlipper_timer()
	FlipperTricks LeftFlipper, LFPress, LFCount, LFEndAngle, LFState
	FlipperTricks RightFlipper, RFPress, RFCount, RFEndAngle, RFState
end sub

dim LFPress, RFPress, LFCount, RFCount
dim LFState, RFState
dim EOST, EOSA,Frampup, FElasticity,FReturn
dim RFEndAngle, LFEndAngle

EOST = leftflipper.eostorque
EOSA = leftflipper.eostorqueangle
Frampup = LeftFlipper.rampup
FElasticity = LeftFlipper.elasticity
FReturn = LeftFlipper.return
Const EOSTnew = 0.8 	'1.0 FEOST
Const EOSAnew = 1		'0.2
Const EOSRampup = 0	'0.5 
Dim SOSRampup
	Select Case FlipperCoilRampupMode
		Case 0:
			SOSRampup = 2.5
		Case 1:
			SOSRampup = 8.5
	End Select
Const LiveCatch = 8
Const LiveElasticity = 0.45
Const SOSEM = 0.815
Const EOSReturn = 0.025

LFEndAngle = Leftflipper.endangle
RFEndAngle = RightFlipper.endangle

Sub FlipperActivate(Flipper, FlipperPress)
	FlipperPress = 1
	Flipper.Elasticity = FElasticity

	Flipper.eostorque = EOST 						'new
	Flipper.eostorqueangle = EOSA 				'new
End Sub

Sub FlipperDeactivate(Flipper, FlipperPress)
	FlipperPress = 0
	Flipper.eostorqueangle = EOSA
	Flipper.eostorque = EOST*EOSReturn/FReturn 	'EOST

	
	If Abs(Flipper.currentangle) <= Abs(Flipper.endangle) + 0.1 Then
		Dim BOT, b
		BOT = GetBalls
			
		For b = 0 to UBound(BOT)
			If Distance(BOT(b).x, BOT(b).y, Flipper.x, Flipper.y) < 55 Then 'check for cradle
				If BOT(b).vely >= -0.4 Then BOT(b).vely = -0.4
			End If
		Next
	End If
End Sub

Sub FlipperTricks (Flipper, FlipperPress, FCount, FEndAngle, FState) 
	Dim Dir
	Dir = Flipper.startangle/Abs(Flipper.startangle)	'-1 for Right Flipper

	If Abs(Flipper.currentangle) > Abs(Flipper.startangle) - 0.05 Then
		If FState <> 1 Then
			Flipper.rampup = SOSRampup 
			Flipper.endangle = FEndAngle - 3*Dir
			Flipper.Elasticity = FElasticity * SOSEM
			FCount = 0 
			FState = 1
		End If
	ElseIf Abs(Flipper.currentangle) <= Abs(Flipper.endangle) and FlipperPress = 1 then
		if FCount = 0 Then FCount = GameTime

'		if GameTime - FCount < LiveCatch Then
'			Flipper.Elasticity = LiveElasticity
'		elseif GameTime - FCount < LiveCatch * 2 Then
'			Flipper.Elasticity = 0.1
'		Else
'			Flipper.Elasticity = FElasticity
'		end if

		If FState <> 2 Then
			Flipper.eostorqueangle = EOSAnew
			Flipper.eostorque = EOSTnew
			Flipper.rampup = EOSRampup			
			Flipper.endangle = FEndAngle
			FState = 2
		End If
	Elseif Abs(Flipper.currentangle) > Abs(Flipper.endangle) + 0.01 and FlipperPress = 1 Then 
		If FState <> 3 Then
			Flipper.eostorque = EOST						'EOST
			Flipper.eostorqueangle = EOSA				'EOSA
			Flipper.rampup = Frampup
			Flipper.Elasticity = FElasticity
			FState = 3
		End If

	End If
End Sub

Const LiveDistanceMin = 30  'minimum distance in vp units from flipper base live catch dampening will occur
Const LiveDistanceMax = 114  'maximum distance in vp units from flipper base live catch dampening will occur (tip protection)

Sub CheckLiveCatch(ball, Flipper, FCount, parm) 'Experimental new live catch
	Dim Dir
	Dir = Flipper.startangle/Abs(Flipper.startangle)	'-1 for Right Flipper

	if GameTime - FCount < LiveCatch and parm > 6 and ABS(Flipper.x - ball.x) > LiveDistanceMin and ABS(Flipper.x - ball.x) < LiveDistanceMax Then
		If ball.velx * Dir > 0 Then ball.velx = 0
		ball.vely = 0
		ball.angmomx= 0
		ball.angmomy= 0
		ball.angmomz= 0
	End If 
End Sub

Sub LeftFlipper_Collide(parm)
	CheckDampen Activeball, LeftFlipper, parm
	CheckLiveCatch Activeball, LeftFlipper, LFCount, parm
	LeftFlipperCollide parm
End Sub

Sub RightFlipper_Collide(parm)
	CheckDampen Activeball, RightFlipper, parm
	CheckLiveCatch Activeball, RightFlipper, RFCount, parm
	RightFlipperCollide parm
End Sub

dim angdamp, veldamp
angdamp = 0.2
veldamp = 0.8

Sub CheckDampen(ball, Flipper, parm)
	Dim Dir
	Dir = Flipper.startangle/Abs(Flipper.startangle)	'-1 for Right Flipper

	If parm > 4 and ABS(Flipper.x - ball.x) < LiveDistanceMin And  Flipper.currentangle = Flipper.endangle Then
		ball.angmomx=ball.angmomx*angdamp
		ball.angmomy=ball.angmomy*angdamp
		ball.angmomz=ball.angmomz*angdamp
		If  ball.velx*Dir > 0 Then ball.velx = ball.velx * veldamp
	End If
End Sub


'******************************************************
'				MAGNET DIVERTER
'******************************************************

Sub SolSpiritRing(Enabled)
	SpiritH1.Enabled = Enabled
	If Enabled Then		
		SoundPlasticRightRamp(SoundOff_SpiritRing)
		SoundSpiritRingSolenoidCapture()
		SoundSpiritRingMagnet(SoundOn)
	Else
		SoundSpiritRingMagnet(SoundOff)
		SpiritH1.kick 0,0,-1.56
		vpmtimer.addtimer 150, "SoundPlasticRightRampBallDropFromSpiritRing '"
	End If
	'debug.print "SpiritRing " & enabled
End Sub
 
Dim wball,xball, yball, zball, spiritspeed
Dim bsteps: bsteps = 0
SpiritSpeed = 7

Sub SpiritH1_Hit()
	SoundWireRampCatwalk(SoundOff)
	set wball = ActiveBall
	xball = SpiritH1.X
	yball = SpiritH1.Y
	zball = 155
	Me.TimerInterval = 5
	Me.TimerEnabled = 1
End Sub

Sub SpiritH1_Timer()
	wball.x = xball
	wball.y = yball
	wball.z = zball
	xball = xball - 1*spiritspeed
	yball = yball + 2*spiritspeed
	zball = zball + 2.45*spiritspeed
	bsteps = bsteps + 1
	If bsteps > 28/spiritspeed then Me.timerenabled = 0 : bsteps = 0 
End Sub

'******************************************************
'			PLAYFIELD MAGNETS
'******************************************************
 
Sub SolLeftMagnet(Enabled)
	If Enabled Then
		LeftMagnet.MagnetOn = 1
		SoundMagnaSaveLeftMagnet(SoundOn)
	Else
		LeftMagnet.MagnetOn = 0
		SoundMagnaSaveLeftMagnet(SoundOff)
	End If
	'debug.print "Left Mag " & enabled
End Sub

Sub SolRightMagnet(Enabled)
	If Enabled Then
		RightMagnet.MagnetOn = 1
		SoundMagnaSaveRightMagnet(SoundOn)
	Else
		RightMagnet.MagnetOn = 0
		SoundMagnaSaveRightMagnet(SoundOff)
	End If
	'debug.print "Right Mag " & enabled
End Sub

'******************************************************
' 				TRAP DOOR
'******************************************************

Dim TDpos, TDStep, TDDir, TDHold
TDStep = 18
TDHold = 0

TrapDoor.timerinterval = 10

Sub ShakeTrapDoor
	TDpos = 5
	TrapDoorShake.Interval = 40
	TrapDoorShake.Enabled = 1
End Sub

Sub TrapDoorShake_Timer
    TrapDoorP.transZ = TDpos
    If TDpos = 0 Then Me.Enabled = 0:Exit Sub
    If TDpos < 0 Then
        TDpos = ABS(TDpos) - 1
    Else
        TDpos = - TDpos + 1
    End If
End Sub

Sub SolTrapDoorUp(Enabled)
	If Enabled then
		RandomSoundTrapdoorOpen()
		SoundScoopLightFlashRelay(SoundOn)
		TrapDoor.timerenabled = false
		TDDir = 1
		TrapDoor.timerenabled = true
	ElseIf TDHold = 1 Then
		ShakeTrapDoor
	Else
		If TrapDoorP.z > 0 Then
			RandomSoundTrapdoorClose()
			SoundScoopLightFlashRelay(SoundOff)
		End If
		TrapDoor.timerenabled = false
		TDDir = -1
		TrapDoor.timerenabled = true
	End If
	'debug.print "TrapDoor " & enabled
End Sub

Dim PrevTrapDoorZ

Sub TrapDoor_timer()
	TrapDoorP.z = TrapDoorP.z + (TDStep * TDDir)
	if TrapDoorP.z > 0 and TrapDoorP.z < 70 then
		TrapDoor.IsDropped = 0
		TrapDoor1.collidable= 1
		TrapDoor2.collidable= 1
		TrapDoorWallDown.collidable = 0
		TrapDoorWallMid.collidable = 1
		TrapDoorWallUp.Collidable = 0
		ScoopLight.state = 2
	ElseIf TrapDoorP.z >= 70 Then
		TrapDoorP.z = 70
		TrapDoor.IsDropped = 0
		TrapDoor1.collidable= 1
		TrapDoor2.collidable= 1
		TrapDoorWallDown.collidable = 0
		TrapDoorWallMid.collidable = 0
		TrapDoorWallUp.Collidable = 1
		TDHole.enabled = 1
		ScoopLight.state = 2
		me.timerenabled = false
	Else
		TrapDoorP.z = 0
		TrapDoor.IsDropped = 1
		TrapDoor1.collidable= 0
		TrapDoor2.collidable= 0
		TrapDoorWallDown.collidable = 1
		TrapDoorWallMid.collidable = 0
		TrapDoorWallUp.Collidable = 0
		TDHole.enabled = 0
		ScoopLight.state = 0
		me.timerenabled = false
	end If

	If TDDir = 1 Then
		Dim BOT, b
		BOT = GetBalls
			
		For b = 0 to UBound(BOT)
			If InRect(BOT(b).x, BOT(b).y, 633,1384,753,1424,717,1540,597,1501) and BOT(b).z > PrevTrapDoorZ + 20 Then 
				BOT(b).z = 25 + TrapDoorP.z
				BOT(b).velz = 15
			End If
		Next
	End If

	PrevTrapDoorZ = TrapDoorP.z
End Sub

Sub SolTrapDoorHold(Enabled)
	If Enabled then
		TDHold = 1
	ElseIf TrapDoorP.z > 0 Then
		TDHold = 0
		RandomSoundTrapdoorClose()
		SoundScoopLightFlashRelay(SoundOff)
		TrapDoor.timerenabled = false
		TDDir = -1
		TrapDoor.timerenabled = true
	End If
End Sub

Sub TDHole_Hit
	If activeball.z > -20 Then 
		RandomSoundTrapdoorEnter()
	End If
End Sub

'*** Determines if a Points (px,py) is inside a 4 point polygon A-D in Clockwise/CCW order
Function InRect(px,py,ax,ay,bx,by,cx,cy,dx,dy)
	Dim AB, BC, CD, DA
	AB = (bx*py) - (by*px) - (ax*py) + (ay*px) + (ax*by) - (ay*bx)
	BC = (cx*py) - (cy*px) - (bx*py) + (by*px) + (bx*cy) - (by*cx)
	CD = (dx*py) - (dy*px) - (cx*py) + (cy*px) + (cx*dy) - (cy*dx)
	DA = (ax*py) - (ay*px) - (dx*py) + (dy*px) + (dx*ay) - (dy*ax)
 
	If (AB <= 0 AND BC <=0 AND CD <= 0 AND DA <= 0) Or (AB >= 0 AND BC >=0 AND CD >= 0 AND DA >= 0) Then
		InRect = True
	Else
		InRect = False       
	End If
End Function


'******************************************************
'       			MAGIC TRUNK
'******************************************************
 
Dim MagnetBall, TrunkMotorOn, TrunkAngle, TrunkSpeed, TrunkDir, TrunkTime

TrunkSpeed = 0.12

Sub sw85_Hit
	If TrunkShake Then ShakeTrunk
	RandomTrunkHit()
	RandomSoundWall()
End Sub

Sub TrunkBlock_Hit
	If TrunkShake Then ShakeTrunk
	RandomTrunkHit()
	RandomSoundWall()
End Sub

Sub TrunkOpen_Hit
	If TrunkShake Then ShakeTrunk
	RandomTrunkHit()
	RandomSoundWall()
End Sub

Sub solTrunkMotorCW(Enabled)
	If Enabled Then
		SoundTrunkMotor(SoundOn)
		trunktimer.enabled = true
		TrunkDir = 1
		TrunkMotorOn = 1
		TrunkBlock.IsDropped = 0				'only drop TrunkBlock if trunk is not moving
	Else
		SoundTrunkMotor(SoundOff)
		If TrunkDir = 1 Then
			TrunkMotorOn = 0
			TrunkBlock.IsDropped = 1				'only drop TrunkBlock if trunk is not moving
		End If
	End If
	'debug.print "CW " & enabled
End Sub

Sub solTrunkMotorCCW(Enabled)
	If Enabled Then
		SoundTrunkMotor(SoundOn)
		trunktimer.enabled = true
		TrunkDir = -1
		TrunkMotorOn = 1
		TrunkBlock.IsDropped = 0				'only drop TrunkBlock if trunk is not moving
	Else
		SoundTrunkMotor(SoundOff)
		If TrunkDir = - 1 Then
			TrunkMotorOn = 0
			TrunkBlock.IsDropped = 1				'only drop TrunkBlock if trunk is not moving
		End If
	End If
	'debug.print "CCW " & enabled
End Sub

Function trunkIsNear(target)
    trunkIsNear = (trunkAngle >= target - 15) AND (trunkAngle <= target + 15)
End Function

Sub TrunkTimer_Timer()
	if TrunkTime <> 0 Then
		TrunkAngle = TrunkAngle + (TrunkSpeed * TrunkDir*(Gametime -TrunkTime))
	End If
	TrunkTime = GameTime

	If TrunkAngle > 270 Then TrunkAngle = 270
	If TrunkAngle < 0 Then TrunkAngle = 0
	
	If trunkIsNear(270) Then
		Controller.Switch(57) = 0
		If TrunkMotorOn = 0 Then SetTrunkAngle(270)
	Elseif trunkIsNear(180) Then
		Controller.Switch(58) = 0
		If TrunkMotorOn = 0 Then SetTrunkAngle(180)
	Elseif trunkIsNear(90) Then
		Controller.Switch(55) = 0
		If TrunkMotorOn = 0 Then SetTrunkAngle(90)
	Elseif trunkIsNear(0) Then
		Controller.Switch(56) = 0
		If TrunkMotorOn = 0 Then SetTrunkAngle(0)
	Else
		Controller.Switch(55) = 1
		Controller.Switch(56) = 1
		Controller.Switch(57) = 1
		Controller.Switch(58) = 1
	End If

	Trunk.RotZ = TrunkAngle
	Trunk1.RotZ = Trunk.RotZ
	Trunk2.RotZ = Trunk.RotZ
	TrunkShadow.RotZ = Trunk.RotZ
	TrunkScrews.RotZ = Trunk.Rotz
	L85.X = Trunk.x - dSin(Trunk.RotZ+175)*90
	L85.Y = Trunk.y - dCos(Trunk.RotZ-5)*90
	L85.RotY = 90 * ABS(dSin(Trunk.RotZ)) + 5
	sw85.IsDropped = NOT Controller.Switch(57)			'if Trunk is rotated to last position, then drop sw85
	If Not IsEmpty(MagnetBall) Then
		MagnetHold.TimerEnabled = False
		BallPos dSin(Trunk.RotZ+85)*105.7 + Trunk.x, dCos(Trunk.Rotz-95)*105.7 + Trunk.y, 103
	End If	
End Sub

Sub SetTrunkAngle(angle)
	If TrunkDir = 1 and TrunkAngle > angle Then TrunkAngle = angle:trunktimer.enabled = false:TrunkTime = 0
	If TrunkDir = -1 and TrunkAngle < angle Then TrunkAngle = angle:trunktimer.enabled = false:TrunkTime = 0
End Sub

 Sub SolTrunkMagnet(aEnabled)
	If aEnabled Then
		SoundTrunkMagnet(SoundOn)
		TrunkMagnets 1
	Else
		If Not IsEmpty(MagnetBall) Then
			MagnetHold.kick 180,1
			CaughtByMagnet1.kick 180,1
			CaughtByMagnet2.kick 180,1
			CaughtByMagnet3.kick 180,1
			MagnetHold.TimerEnabled = False
			MagnetBall = Empty
			If TrunkBlock.IsDropped Then ' TrunkBlock is dropped only if trunk is not moving. If TrunkBlock is dropped & SolTrunkMagnet disabled - play sound of ball drop on playfield
				vpmtimer.addtimer 95, "SoundTrunkBallDrop '"
			End If
		End If
		SoundTrunkMagnet(SoundOff)
		TrunkMagnets 0
	End If
	'debug.print "TrunkMag " & enabled
 End Sub

 Sub TrunkMagnet_Hit(idx)
	RandomSoundTrunkCatch()	
	MagnetHold.Timerenabled = 1
	Set MagnetBall = Activeball
	TrunkMagnets 0
 End Sub

Dim HoldStep
HoldStep = 0.25

Sub MagnetHold_Timer
	If ABS(MagnetBall.x - MagnetHold.x) < HoldStep * 2 Then
		If MagnetBall.x < MagnetHold.x Then MagnetBall.x = Magnetball.x + HoldStep
		If MagnetBall.x > MagnetHold.x Then MagnetBall.x = Magnetball.x - HoldStep
	Else
		MagnetBall.x  = MagnetHold.x
	End If

	If ABS(MagnetBall.y - MagnetHold.y) < HoldStep * 2 Then
		If MagnetBall.y < MagnetHold.y Then MagnetBall.y = Magnetball.y + HoldStep
		If MagnetBall.y > MagnetHold.y Then MagnetBall.y = Magnetball.y - HoldStep
	Else
		MagnetBall.y  = MagnetHold.y
	End If

	If ABS(MagnetBall.x - 103) < HoldStep * 2 Then
		MagnetBall.z = Magnetball.z + HoldStep		
	Else
		MagnetBall.z  = 103
	End If

	If MagnetBall.x = MagnetHold.x and MagnetBall.y = MagnetHold.y and MagnetBall.z = 103 Then
		me.timerenabled = false
	End If
End Sub

 Sub TrunkMagnets(aEnabled)
	CaughtByMagnet1.enabled = aEnabled
	CaughtByMagnet2.enabled = aEnabled
	CaughtByMagnet3.enabled = aEnabled
 End Sub
 
Sub BallPos(Xpos,Ypos,Zpos)
	MagnetBall.x = xpos
	MagnetBall.y = ypos
	MagnetBall.z = zpos
 End Sub
 
Sub sw36_Hit():vpmTimer.PulseSw 36: End Sub							' Opto subway switch

Sub sw47_Hit():vpmTimer.PulseSw 47:End Sub


'****************************************************
'* TRUNK SHAKE CODE BASED ON JP'S ******************
'****************************************************

Dim TrunkPos, tAngle, TrunkX, TrunkY
TrunkX = Trunk.x
TrunkY = Trunk.y

Sub ShakeTrunk
	Dim finalspeed
	finalspeed=INT(1 + SQR(ActiveBall.VelX * ActiveBall.VelX + ActiveBall.VelY * ActiveBall.VelY))
	tAngle = dAtn(ActiveBall.VelY/ActiveBall.VelX)
	If finalspeed >= 8 then
		TrunkPos = 8
	Else
		TrunkPos = INT(9 - 8 / finalspeed)
	End If
	tangle = -5
	TrunkShakeTimer.Enabled = 1
End Sub

Sub TrunkShakeTimer_Timer
	Trunk.x = TrunkX + TrunkPos * dSin(tAngle)/2
	Trunk.y = TrunkY - TrunkPos * dCos(tAngle)/2
	Trunk1.X = Trunk.X
	Trunk2.X = Trunk.X
	TrunkShadow.X = Trunk.X
	TrunkScrews.X = Trunk.X
	Trunk1.Y = Trunk.Y
	Trunk2.Y = Trunk.Y
	TrunkShadow.Y = Trunk.Y
	TrunkScrews.Y = Trunk.Y
	If TrunkPos = 0 Then TrunkShakeTimer.Enabled = 0:Exit Sub
	If TrunkPos < 0 Then
		TrunkPos = ABS(TrunkPos) - 1
	Else
		TrunkPos = - TrunkPos + 1
	End If
End Sub

'******************************************************
'			TIGER SAW ANIMATION
'******************************************************

Dim tsAngle:tsAngle=0
Dim stepAngle, stopRotation

'******		VPM controlled (only in prototypes)
Sub SolTigerSaw(enabled)
	If Enabled Then 
		CPC.TimerEnabled = 1
		CPC.TimerInterval = 20 
		SoundTigerSawMotor(SoundOn)
		stepAngle= 20   
		stopRotation=0
	Else
		SoundTigerSawMotor(SoundOff)
		stopRotation=1
	End If
	'debug.print "Tiger Saw " & enabled
End Sub

Sub CPC_Timer()
	Saw.Rotz = Saw.Rotz + stepAngle	
	If Saw.Rotz >= 360 Then   '360
		Saw.Rotz = Saw.Rotz - 360
	End If
	SawGold.Rotz = Saw.Rotz
	SawGoldTeeth.Rotz = Saw.Rotz

	If stopRotation Then
		stepAngle = stepAngle - 0.1
		If stepAngle <= 0 Then
			CPC.TimerEnabled = 0
		End If
	End If
End Sub

'******************************************************
' 			GENERAL ILLUMINATION
'******************************************************

Dim gistep, LGIOn, RGIOn

Sub UpdateGI(no, step)
	'TextBox.text = no & " " &  step
	Dim xx



	If step = 0 then exit sub 'only values from 1 to 8 are visible and reliable. 0 is not reliable and 7 & 8 are the same so...
	gistep = (step-1) / 7

	If step = 8 then 'GI is on
		DOF 101, DOFOn
	Else
		DOF 101, DOFOff
	End If

	Select Case no
		Case 0		' top
			If step = 8 then 'GI is on
				Sound_GI_Top_Relay(SoundOn)
			End If
			If step < 2 then 'GI is off
				Sound_GI_Top_Relay(SoundOff)
			End If

			For each xx in GITop:xx.IntensityScale = gistep:next			
			For each xx in GIBumpers:xx.IntensityScale = gistep:next

		Case 1		' bottom left
			If step = 8 then 'GI is on
				Sound_GI_BottomLeft_Relay(SoundOn)
				LGIOn = 1
			End If
			If step < 2 then 'GI is off
				Sound_GI_BottomLeft_Relay(SoundOff)
				LGIOn = 0 
			End If
			For each xx in GILeft:xx.IntensityScale = gistep:next

		Case 2		' bottom right
			If step = 8 then 'GI is on
				Sound_GI_BottomRight_Relay(SoundOn)
				RGIOn = 1
			End If
			If step <  2 then 'GI is off
				Sound_GI_BottomRight_Relay(SoundOff)
				RGIOn = 0
			End If
			For each xx in GIRight:xx.IntensityScale = gistep:next

		Case 3		' middle
			If step = 8 then 'GI is on
				Sound_GI_Middle_Relay(SoundOn)
			End If
			If step < 2 then 'GI is off
				Sound_GI_Middle_Relay(SoundOff)
			End If
			For each xx in GIMiddle:xx.IntensityScale = gistep:next
	End Select

	Table1.ColorGradeImage = "LUT" & LUTset & "_" & step - 1
	'Table1.ColorGradeImage = "LUT" & LUTset & "_" & step
	' change the intensity of the flasher depending on the gi to compensate for the gi lights being off
	For xx = 0 to 200
		FlashMax(xx) = 6 - gistep * 3 ' the maximum value of the flashers
	Next
End Sub


'***************************************************
'       JP's VP10 Fading Lamps & Flashers
'       Based on PD's Fading Light System
' SetLamp 0 is Off
' SetLamp 1 is On
' fading for non opacity objects is 4 steps
'***************************************************

Dim LampState(200), FadingLevel(200)
Dim FlashSpeedUp(200), FlashSpeedDown(200), FlashMin(200), FlashMax(200), FlashLevel(200)

InitLamps()             ' turn off the lights and flashers and reset them to the default parameters
LampTimer.Interval = 20 'lamp fading speed (20) (10) (5)
LampTimer.Enabled = 1

Sub LampTimer_Timer()
    Dim chgLamp, num, chg, ii
    chgLamp = Controller.ChangedLamps
    If Not IsEmpty(chgLamp) Then
        For ii = 0 To UBound(chgLamp)
            LampState(chgLamp(ii, 0) ) = chgLamp(ii, 1)       'keep the real state in an array
            FadingLevel(chgLamp(ii, 0) ) = chgLamp(ii, 1) + 4 'actual fading step
        Next
    End If
    UpdateLamps
End Sub

Sub InitLamps()
    Dim x
    For x = 0 to 200
        LampState(x) = 0         ' current light state, independent of the fading level. 0 is off and 1 is on
        FadingLevel(x) = 4       ' used to track the fading state
        FlashSpeedUp(x) = 1    ' faster speed when turning on the flasher (0.5) (0.4)
        FlashSpeedDown(x) = 0.5  ' slower speed when turning off the flasher (0.35) (0.2)
        FlashMax(x) = 1          ' the maximum value when on, usually 1
        FlashMin(x) = 0          ' the minimum value when off, usually 0
        FlashLevel(x) = 0        ' the intensity of the flashers, usually from 0 to 1
    Next
End Sub

Sub UpdateLamps
	NFadeL 11,  l11
	NFadeL 12,  l12
	NFadeL 13,  l13
	NFadeL 14,  l14
	NFadeL 15,  l15
	NFadeL 16,  l16
	NFadeL 17,  l17
	NFadeLm 18,  l18
	Flash 18, l18halo
	NFadeL 21,  l21
	NFadeL 22,  l22
	NFadeL 23,  l23
     NFadeL 24,  l24
     NFadeLm 25,  l25
	 Flash 25, L25halo
     NFadeLm 26,  l26
     NFadeLm 26,  l26a
	 Flashm 26, l26halo
     Flash 26, l26ahalo
     NFadeLm 27,  l27
	 Flash 27, l27halo
     NFadeLm 28,  l28
	 Flash 28, l28halo
     NFadeLm 31,  l31
	 Flash 31, l31halo
     NFadeLm 32,  l32
	 Flash 32, l32halo
     NFadeL 33,  l33
     NFadeL 34,  l34
     NFadeL 35,  l35
     NFadeLm 36,  l36
	 Flash 36, l36halo
     NFadeLm 37,  l37
     Flash 37,  l37a
     NFadeLm 38,  l38
     Flash 38,  l38a
     NFadeLm 41,  l41
	 Flash 41, L41halo
     NFadeL 42,  l42
     NFadeL 43,  l43
     NFadeLm 44,  l44
	 Flash 44, l44halo
     NFadeL 45,  l45
     NFadeL 45,  l45a
     NFadeLm 46,  l46
	 Flash 46, l46halo
     NFadeL 47,  l47
     NFadeLm 48,  l48
	 Flash 48, l48halo
     NFadeLm 51,  l51
	 Flash 51, l51halo
     NFadeLm 52,  l52
	 Flash 52, l52halo
     NFadeLm 53,  l53
	 Flash 53, l53halo
     NFadeLm 54,  l54
     NFadeLm 54,  l54a
	 Flashm 54, l54halo
	 Flash 54, l54ahalo
     NFadeLm 55,  l55
	 Flash 55, l55halo
     NFadeLm 56,  l56
	 Flash 56, l56halo
     NFadeLm 57,  l57
	 Flash 57, l57halo
     NFadeLm 58,  l58
	 Flash 58, l58halo
	NFadeL 61,  l61
	NFadeL 62,  l62
	NFadeLm 63,  l63
	Nfadel 63, l63b
	NFadeL 64,  l64
	NFadeL 65,  l65
	NFadeL 66,  l66
	NFadeL 67,  l67
	NFadeL 68,  l68
	NFadeL 71,  l71
	NFadeLm 72,  l72
	Flash 72, l72halo
	NFadeLm 73,  l73
	Flash 73, l73halo
	NFadeLm 74,  l74
	Flash 74, l74halo
	NFadeLm 75,  l75
	Flash 75, l75halo
	NFadeLm 76,  l76
	Flash 76, l76halo
	NFadeL 77,  l77
	NFadeLm 78,  l78
	Flash 78, l78halo
	NFadeLm 81,  l81
	NFadeLm 81,  l81a
	Flashm 85,  l85
	Flashm 85,  l85a
	Flash 85,  l85a3
	NFadeLm 86,  l86
	Flash 86, l86halo
	'FadeObj 86, CenterPostP, "3D_Centerpost_3", "3D_Centerpost_2", "3D_Centerpost_1", "3D_Centerpost"

'flashers

	NFadeLMod 120,F20
	NFadeLMod 120,F20a
	NFadeLMod 120,F20b
	NFadeLMod 120,F20c
	NFadeFMod 120, F20d
	NFadeFMod 120, F20e
	NFadeFMod 120, F20f
	NFadeFMod 120, F20g

	NFadeFMod 123, F23

	NFadeLMod 124,F24a
	NFadeLMod 124,F24b
	NFadeLMod 124,F24c
	NFadeLMod 124, F24d
	NFadeFMod 124, F24e

	NFadeLMod 125,F25
	NFadeLMod 125,F25a
	NFadeLMod 125,F25b
	NFadeLMod 125, F25d
	NFadeLMod 125, F25e
	NFadeLMod 125, F25f
	Flasho 125, Flasherlit3
	Flashb 125, Prim_F3
	NFadeFMod 125, F25g
	NFadeFMod 125, F25h
	NFadeFMod 125, F25i
	NFadeFMod 125, F25j
	NFadeFMod 125, F25k
	NFadeFMod 125, F25l
	NFadeFMod 125, F25m

	NFadeLMod 126,F26
	NFadeLMod 126,F26a
	NFadeLMod 126,F26b
	NFadeLMod 126, F26c
	NFadeLMod 126, F26d
	NFadeFMod 126, F26e
	NFadeFMod 126, F26f
	NFadeFMod 126, F27f

	NFadeLMod 127,F27
	NFadeLMod 127,F27a
	NFadeLMod 127,F27b
	NFadeLMod 127, F27c
	NFadeLMod 127, F27d
	NFadeLMod 127, F27e
					

	NFadeLMod 128,F28
	NFadeLMod 128,F28a
	NFadeLMod 128,F28b
	NFadeLMod 128, F28c
	NFadeLMod 128, F28d
	NFadeFMod 128, F28e
	NFadeFMod 128, F28f
	NFadeFMod 128, F28g
	NFadeFMod 128, F28g2
	NFadeFMod 128, F28h
	NFadeLMod 128, F24d001
	Flasho 128, Flasherlit1
	NFadeFMod 128, F28i

	If FlasherMod = 0 Then
		If FadingLevel(120) = 0.5 Then FadingLevel(120) = 0
		If FadingLevel(123) = 0.5 Then FadingLevel(123) = 0
		If FadingLevel(124) = 0.5 Then FadingLevel(124) = 0
		If FadingLevel(125) = 0.5 Then FadingLevel(125) = 0
		If FadingLevel(126) = 0.5 Then FadingLevel(126) = 0
		If FadingLevel(127) = 0.5 Then FadingLevel(127) = 0
		If FadingLevel(128) = 0.5 Then FadingLevel(128) = 0
	End If

	F23.Height = CenterPostP.TransZ + 1.2
End Sub

Sub SetModLamp(nr, level)
	LampState(nr) = FadingLevel(nr)
	FadingLevel(nr) = level / 255

	Select Case nr
		Case 120
			If LampState(nr) = 0 and FadingLevel(nr) > 0 then
				Sound_Flash_120_Relay(SoundOn)
			Elseif FadingLevel(nr) = 0 and LampState(nr) > 0 then 
				Sound_Flash_120_Relay(SoundOff)
			End If
		Case 123
			If LampState(nr) = 0 and FadingLevel(nr) > 0 then
				Sound_Flash_123_Relay(SoundOn) 
			Elseif FadingLevel(nr) = 0 and LampState(nr) > 0 then
				Sound_Flash_123_Relay(SoundOff)
			End If
		Case 124
			If LampState(nr) = 0 and FadingLevel(nr) > 0 then
				Sound_Flash_124_Relay(SoundOn) 
			Elseif FadingLevel(nr) = 0 and LampState(nr) > 0 then
				Sound_Flash_124_Relay(SoundOff)
			End If
		Case 125
			If LampState(nr) = 0 and FadingLevel(nr) > 0 then
				Sound_Flash_125_Relay(SoundOn)
			Elseif FadingLevel(nr) = 0 and LampState(nr) > 0 then
				Sound_Flash_125_Relay(SoundOff)
			End If
		Case 126
			If LampState(nr) = 0 and FadingLevel(nr) > 0 then
				Sound_Flash_126_Relay(SoundOn)
			Elseif FadingLevel(nr) = 0 and LampState(nr) > 0 then
				Sound_Flash_126_Relay(SoundOff)
			End If
		Case 127
			If LampState(nr) = 0 and FadingLevel(nr) > 0 then
				Sound_Flash_127_Relay(SoundOn)
			Elseif FadingLevel(nr) = 0 and LampState(nr) > 0 then
				Sound_Flash_127_Relay(SoundOff)
			End If
		Case 128
			If LampState(nr) = 0 and FadingLevel(nr) > 0 then
				Sound_Flash_128_Relay(SoundOn)
			Elseif FadingLevel(nr) = 0 and LampState(nr) > 0 then
				Sound_Flash_128_Relay(SoundOff)
			End If
	End Select	

End Sub

Sub NFadeLMod(nr, object)
	object.IntensityScale = FadingLevel(nr)
	object.state = 1
	object.visible = 1
End Sub

Sub NFadeFMod(nr, object)	'Flashers
	object.IntensityScale = FadingLevel(nr)
	'debug.print FadingLevel(nr)
End Sub

Sub Flasho(nr, object) 'Flupper Flasher
	dim matdim
	object.blenddisablelighting = FadingLevel(nr) * 2
	matdim = Round(10*FadingLevel(nr))

	If matdim > 6 then matdim = 9
	object.material = "domelit" & matdim

	If FadingLevel(nr) < 0.15 Then
		Object.visible = 0
	Else
		Object.visible = 1
	end If
End Sub

Sub Flashb(nr, object) 
	object.blenddisablelighting = FadingLevel(nr)/4
End Sub

Sub SetLamp(nr, value)
	LampState(nr) = FadingLevel(nr)
	FadingLevel(nr) = Abs(value)

	If LampState(nr) = 1 and FadingLevel(nr) = 0 Then
		FadingLevel(nr) = 0.5
	End If

	Select Case nr
		Case 120
			If value  then
				Sound_Flash_120_Relay(SoundOn)
			Else
				Sound_Flash_120_Relay(SoundOff)
			End If
		Case 123
			If value then
				Sound_Flash_123_Relay(SoundOn) 
			Else
				Sound_Flash_123_Relay(SoundOff)
			End If
		Case 124
			If value then
				Sound_Flash_124_Relay(SoundOn) 
			Else
				Sound_Flash_124_Relay(SoundOff)
			End If
		Case 125
			If value then
				Sound_Flash_125_Relay(SoundOn)
			Else
				Sound_Flash_125_Relay(SoundOff)
			End If
		Case 126
			If value then
				Sound_Flash_126_Relay(SoundOn)
			Else
				Sound_Flash_126_Relay(SoundOff)
			End If
		Case 127
			If value then
				Sound_Flash_127_Relay(SoundOn)
			Else
				Sound_Flash_127_Relay(SoundOff)
			End If
		Case 128
			If value then
				Sound_Flash_128_Relay(SoundOn)
			Else
				Sound_Flash_128_Relay(SoundOff)
			End If
	End Select	
End Sub


' Lights: used for VP10 standard lights, the fading is handled by VP itself

Sub NFadeL(nr, object)
    Select Case FadingLevel(nr)
        Case 4:object.state = 0:FadingLevel(nr) = 0
        Case 5:object.state = 1:FadingLevel(nr) = 1
    End Select
End Sub

Sub NFadeLm(nr, object) ' used for multiple lights
    Select Case FadingLevel(nr)
        Case 4:object.state = 0
        Case 5:object.state = 1
    End Select
End Sub

'Lights, Ramps & Primitives used as 4 step fading lights
'a,b,c,d are the images used from on to off

Sub FadeObj(nr, object, a, b, c, d)
	Select Case FadingLevel(nr)
		Case 2:object.image = d:FadingLevel(nr) = 0 'Off
		Case 3:object.image = c:FadingLevel(nr) = 2 'fading...
		Case 4:object.image = b:FadingLevel(nr) = 3 'fading...
		Case 5:object.image = a:FadingLevel(nr) = 1 'ON
 End Select
End Sub

Sub FadeObjm(nr, object, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 2:object.image = d
        Case 3:object.image = c
        Case 4:object.image = b
        Case 5:object.image = d
    End Select
End Sub

Sub NFadeObj(nr, object, a, b)
    Select Case FadingLevel(nr)
        Case 4:object.image = b:FadingLevel(nr) = 0 'off
        Case 5:object.image = a:FadingLevel(nr) = 1 'on
    End Select
End Sub

Sub NFadeObjm(nr, object, a, b)
    Select Case FadingLevel(nr)
        Case 4:object.image = b
        Case 5:object.image = a
    End Select
End Sub

' Flasher objects

Sub Flash(nr, object)
    Select Case FadingLevel(nr)
        Case 4 'off
            FlashLevel(nr) = FlashLevel(nr) - FlashSpeedDown(nr)
            If FlashLevel(nr) < FlashMin(nr) Then
                FlashLevel(nr) = FlashMin(nr)
                FadingLevel(nr) = 0 'completely off
            End if
            Object.IntensityScale = FlashLevel(nr)
        Case 5 ' on
            FlashLevel(nr) = FlashLevel(nr) + FlashSpeedUp(nr)
            If FlashLevel(nr) > FlashMax(nr) Then
                FlashLevel(nr) = FlashMax(nr)
                FadingLevel(nr) = 1 'completely on
            End if
            Object.IntensityScale = FlashLevel(nr)
    End Select
End Sub

Sub Flashm(nr, object) 'multiple flashers, it just sets the flashlevel
    Object.IntensityScale = FlashLevel(nr)
End Sub

'*****************
' Maths
'*****************

Const Pi = 3.1415927

Function dSin(degrees)
	dsin = sin(degrees * Pi/180)
	if ABS(dSin) < 0.000001 Then dSin = 0
	if ABS(dSin) > 0.999999 Then dSin = 1
End Function

Function dCos(degrees)
	dcos = cos(degrees * Pi/180)
	if ABS(dCos) < 0.000001 Then dCos = 0
	if ABS(dCos) > 0.999999 Then dCos = 1
End Function

Function dAtn(degrees)
	dAtn = atn(degrees * Pi/180)
End Function

Function RndInt(min, max)
    RndInt = Int(Rnd() * (max-min + 1) + min)' Sets a random number integer between min and max
End Function

Function RndNum(min, max)
    RndNum = Rnd() * (max-min) + min' Sets a random number between min and max
End Function

'******************************************************
' 			Mirrored Balls (based on Koadic's )
'******************************************************

Dim mDistY:mDistY = ABS (PFmirror.Y)								' mDistY is the the mirroring plane y component
Dim mangle															' mAngle angle between the mirrored pf and the pf itself

If DesktopMode Then
	mAngle= 22
Else
	mAngle= 80
End If

PFmirror.RotX = -mangle
Dim mballs : mballs = 4										' mballs is the maximum number of balls being reflected;
' 															' this number must match the number of kickers defined in the array.
Dim iball, cnt, mb, MKick
MKick = Array("", MKick1, MKick2, MKick3, MKick4)			' array of kickers that create/destroy balls
ReDim MBall(mballs+1),MBallStatus(mballs+1), BallM(mballs+1)
MBallStatus(0) = 0

Sub MirrorTrigger_Hit:NewMBall:End Sub						' on hit trigger the mirrored ball, on unhit destroy the ball and disable the timer
Sub MirrorTrigger_UnHit:ClearMBall:If MBallStatus(0) = 0 Then Me.TimerEnabled=0:End If:End Sub

Sub MirrorTrigger_Timer
	If MBallStatus(0) = 0 Then Me.TimerEnabled=0:Exit Sub
	For mb = 1 to mballs
		If MBallStatus(mb) > 0 Then
			BallM(mb).x = MBall(mb).x																								' mirrored ball x position
			BallM(mb).y = mDistY - SQR ((MBall(mb).y - mDistY)^2 + (MBall(mb).z)^2)* dCos (mAngle) + MBall(mb).z * dSin(mAngle)			' mirrored ball y position
			BallM(mb).z = SQR ((MBall(mb).y - mDistY)^2 + (MBall(mb).z)^2) * dSin(mAngle) + MBall(mb).z * dCos(mAngle)					' mirrored ball z position
		End If
	Next
End Sub

Sub NewMBall												' this creates the mirrored ball(s)
	For cnt = 1 to mballs
		If MBallStatus(cnt) = 0 Then
			Set MBall(cnt) = ActiveBall
			MBall(cnt).uservalue = cnt
			'Set BallM(cnt) = MKick(cnt).CreateSizedBallWithMass (Ballsize/2, BallMass)
			MBallStatus(cnt) = 1
			MBallStatus(0) = MBallStatus(0)+1
			Exit For
		End If
   	Next
	MirrorTrigger.TimerEnabled = 1
End Sub

Sub ClearMBall												' this destroys the mirrored ball(s)
   	iball = ActiveBall.uservalue
   	MBall(iball).UserValue = 0
   	MBallStatus(iBall) = 0
   	MBallStatus(0) = MBallStatus(0)-1
	'MKick(iball).DestroyBall
	BallM(iball).x = MKick(iball).x
	BallM(iball).y = MKick(iball).y
	BallM(iball).z = 25
End Sub

Sub InitMirror (Prim, mPrim)
		mPrim.Y = mDistY -  SQR ((ABS(Prim.y) - mDistY)^2 + (Prim.z)^2)* dCos(mAngle) + Prim.z * dSin(mAngle)
		mPrim.Z =  SQR ((ABS(Prim.y) - mDistY)^2 + (Prim.z)^2) * dSin(mAngle) + Prim.z * dCos(mAngle)
		mPrim.objRotX = Prim.objRotX -mAngle
End Sub

Sub InitMirror2 (Prim, mPrim)
		mPrim.Y = mDistY -  SQR ((ABS(Prim.y) - mDistY)^2 + (Prim.z)^2)* dCos(mAngle) + Prim.z * dSin(mAngle) + 20
		mPrim.Z =  SQR ((ABS(Prim.y) - mDistY)^2 + (Prim.z)^2) * dSin(mAngle) + Prim.z * dCos(mAngle) - 5
		mPrim.objRotX = Prim.objRotX -mAngle
End Sub

Sub InitMLights(obj, ypos, height)
	obj.Y = mDistY -  SQR((ABS(ypos) - mDistY)^2 + height^2)* dCos(mAngle)
	obj.Height =  SQR((ABS(ypos) - mDistY)^2 + height^2) * dSin(mAngle) + height * dCos(mAngle)
	obj.RotX = obj.RotX - mAngle 

End Sub

'******************************************************
'       	RealTime Updates
'******************************************************

'Set MotorCallback = GetRef("GameTimer")

Sub GameTimer_Timer
	FlipperL.RotZ = LeftFlipper.currentangle
	FlipperR.RotZ = RightFlipper.currentangle
	FlipperLSh.RotZ = LeftFlipper.currentangle
	FlipperRSh.RotZ = RightFlipper.currentangle
	WireGateL.RotX = Spinner1.currentangle
	WireGateR.RotX = Gate4.currentangle
	sw37p.RotX= -sw37.currentangle
	sw73p.RotZ= sw73flip.currentangle
	sw74p.RotZ= sw74flip.currentangle
	sw87p.RotZ= sw87flip.currentangle
	LLoopGateSw.RotY = -Gate3.currentangle*3/4
	LLoopGateSwm.RotY = -Gate3.currentangle*3/4
	RLoopGateSw.RotY = Gate1.currentangle
	RLoopGateSwm.RotY = Gate1.currentangle
	WireGate.RotX = -Gate2.currentangle
	WireGatem.RotX = -Gate2.currentangle
	RollingSoundUpdate
	cor.update

	If LGIOn = 0 Then
		If LeftFlipper.CurrentAngle < 80 and LeftUpOff = 0 Then
			FlipperL.image = LeftGIOffUp
			LeftUpOff = 1
			LeftDownOff = 0
			LeftUpOn = 0
			LeftDownOn = 0
		Elseif LeftFlipper.CurrentAngle >= 80 AND LeftDownOff = 0 Then 
			FlipperL.image = LeftGIOff
			LeftUpOff = 0
			LeftDownOff = 1
			LeftUpOn = 0
			LeftDownOn = 0
		End If
	Else
		If LeftFlipper.CurrentAngle < 80 and LeftUpOn = 0 Then
			FlipperL.image = LeftGIOnUP
			LeftUpOff = 0
			LeftDownOff = 0
			LeftUpOn = 1
			LeftDownOn = 0
		ElseIf LeftFlipper.CurrentAngle >= 80 and LeftDownOn = 0 Then
			FlipperL.image = LeftGIOn
			LeftUpOff = 0
			LeftDownOff = 0
			LeftUpOn = 0
			LeftDownOn = 1
		End If
	End If

	If RGIOn = 0 Then
		If rightflipper.CurrentAngle > -80 and RightUpOff = 0 Then
			FlipperR.image = RightGIOffUp
			RightUpOff = 1
			RightDownOff = 0
			RightUpOn = 0
			RightDownOn = 0
		ElseIf rightflipper.CurrentAngle <= -80 and RightDownOff = 0 Then
			FlipperR.image = RightGIOff
			RightUpOff = 0
			RightDownOff = 1
			RightUpOn = 0
			RightDownOn = 0
		End If
	Else
		If rightflipper.CurrentAngle > -80 and RightUpOn = 0 Then
			FlipperR.image = RightGIOnUp
			RightUpOff = 0
			RightDownOff = 0
			RightUpOn = 1
			RightDownOn = 0
		ElseIf rightflipper.CurrentAngle <= -80 and RightDownOn = 0 Then
			FlipperR.image = RightGIOn
			RightUpOff = 0
			RightDownOff = 0
			RightUpOn = 0
			RightDownOn = 1
		End If
	End If

End Sub

Dim RightGIOn, RightGIOnUp, RightGIOff, RightGIOffUp
Dim LeftGIOn, LeftGIOnUP, LeftGIOff, LeftGIOffUp
Dim RightUpOn, RightDownON, RightUpOff, RightDownOff
Dim LeftUpOn, LeftDownON, LeftUpOff, LeftDownOff

Sub PreloadImages
	If FlipperType = 0 Then
		RightGIOn = "rightflipper_giON_BLK"
		RightGIOnUp = "rightflipperUp_giON_BLK"
		RightGIOff = "rightflipper_giOff_BLK"
		RightGIOffUp = "rightflipperUp_giOff_BLK"

		LeftGIOn = "Leftflipper_giON_BLK"
		LeftGIOnUp = "LeftflipperUp_giON_BLK"
		LeftGIOff = "Leftflipper_giOff_BLK"
		LeftGIOffUp = "LeftflipperUp_giOff_BLK"
	
		FlipperL.image="leftflipper_giON_BLK"
		FlipperR.image="rightflipper_giON_BLK"
		FlipperL.image="leftflipper_giOFF_BLK"
		FlipperR.image="rightflipperUP_giOFF_BLK"
		FlipperL.image="leftflipperUP_giON_BLK"
		FlipperR.image="rightflipper_giOFF_BLK"
		FlipperL.image="leftflipperUP_giOFF_BLK"
		FlipperR.image="rightflipperUP_giON_BLK"
	Else
		RightGIOn = "rightflipper_giON"
		RightGIOnUp = "rightflipperUp_giON"
		RightGIOff = "rightflipper_giOff"
		RightGIOffUp = "rightflipperUp_giOff"

		LeftGIOn = "Leftflipper_giON"
		LeftGIOnUp = "LeftflipperUp_giON"
		LeftGIOff = "Leftflipper_giOff"
		LeftGIOffUp = "LeftflipperUp_giOff"

		FlipperL.image="leftflipper_giON"
		FlipperR.image="rightflipper_giON"
		FlipperL.image="leftflipper_giOFF"
		FlipperR.image="rightflipperUP_giOFF"
		FlipperL.image="leftflipperUP_giON"
		FlipperR.image="rightflipper_giOFF"
		FlipperL.image="leftflipperUP_giOFF"
		FlipperR.image="rightflipperUP_giON"
	End If
End Sub 


'******************************************************
'       Center Post (only in prototype)
'******************************************************

Sub SolMagicPost(enabled)
	If enabled then
		CenterPostP.TransZ = 26
		SoundCenterPostSolenoid(Up)
		CPC.IsDropped = 0
	Else
		SoundCenterPostSolenoid(Down)
		CenterPostP.TransZ = 0
		CPC.IsDropped = 1
	End If
End Sub

'*******	TABLE OPTIONS		***********************************

CenterPostP.visible = CenterPost
CPC.collidable = CenterPost
F23.visible = CenterPost
ScoopLight.visible = TDFlasher

If FlipperType = 2 then FlipperType = RndInt(0,1) 

Select Case TDFlasherColor
	'Red
		Case 0 :	ScoopLight.color = RGB (255,0,0):ScoopLight.colorfull = RGB (255,170,170)
	'Green
		Case 1 :	ScoopLight.color = RGB (0,255,0):ScoopLight.colorfull = RGB (170,255,170)
	'Blue
		Case 2 :	ScoopLight.color = RGB (0,0,255):ScoopLight.colorfull = RGB (170,170,255)
	'Yellow
		Case 3 :	ScoopLight.color = RGB (255,197,143):ScoopLight.colorfull = RGB (254,143,33)
	'Magenta
		Case 4 :	ScoopLight.color = RGB (255,0,255):ScoopLight.colorfull = RGB (255,170,255)
	'Cyan
		Case 5 :	ScoopLight.color = RGB (0,255,255):ScoopLight.colorfull = RGB (170,255,255)	
End Select

        If OutlaneDifficulty = 1 Then  'AXS
		OutlaneLeft1.Collidable = True :OutlaneLeft1.Visible = True
		OutlaneLeft2.Collidable = False:OutlaneLeft2.Visible  = False
		OutlaneLeft3.Collidable = False:OutlaneLeft3.Visible = False
		OutlaneLeft1a.Collidable = True 
		OutlaneLeft2a.Collidable = False
		OutlaneLeft3a.Collidable = False


		OutlaneRight1.Collidable = True:OutlaneRight1.Visible  = True
		OutlaneRight2.Collidable = False:OutlaneRight2.Visible  = False
		OutlaneRight3.Collidable = False:OutlaneRight3.Visible  = False
		OutlaneRight1a.Collidable = True
		OutlaneRight2a.Collidable = False
		OutlaneRight3a.Collidable = False
        End If

        If OutlaneDifficulty = 2 Then 
		OutlanePegL.transz = 15
		OutLanePegR.transz = 15

		OutlaneLeft1.Collidable = False:OutlaneLeft1.Visible  = False
		OutlaneLeft2.Collidable = True:OutlaneLeft2.Visible  = True
		OutlaneLeft3.Collidable = False:OutlaneLeft3.Visible  = False
		OutlaneLeft1a.Collidable = False
		OutlaneLeft2a.Collidable = True
		OutlaneLeft3a.Collidable = False

		OutlaneRight1.Collidable = False:OutlaneRight1.Visible  = False
		OutlaneRight2.Collidable = True:OutlaneRight2.Visible  = True
		OutlaneRight3.Collidable = False:OutlaneRight3.Visible = False
		OutlaneRight1a.Collidable = False
		OutlaneRight2a.Collidable = True
		OutlaneRight3a.Collidable = False
        End If

        If OutlaneDifficulty = 3 Then 
		OutlanePegL.transz = 30
		OutLanePegR.transz = 30

		OutlaneLeft1.Collidable = False:OutlaneLeft1.Visible = False
		OutlaneLeft2.Collidable = False:OutlaneLeft2.Visible = False
		OutlaneLeft3.Collidable = True:OutlaneLeft3.Visible  = True
		OutlaneLeft1a.Collidable = False 
		OutlaneLeft2a.Collidable = False
		OutlaneLeft3a.Collidable = True

		OutlaneRight1.Collidable = False:OutlaneRight1.Visible  = False
		OutlaneRight2.Collidable = False:OutlaneRight2.Visible  = False
		OutlaneRight3.Collidable = True:OutlaneRight3.Visible  = True
		OutlaneRight1a.Collidable = False
		OutlaneRight2a.Collidable = False
		OutlaneRight3a.Collidable = True
        End If

	If BladeArt = 1 Then
		BladeLeft.Visible = True
		BladeRight.Visible = True
	 Else
		BladeLeft.Visible = False
		BladeRight.Visible = False
	End If

	If TigersawMod = 1 Then
		Saw.Visible = False
		SawGold.Visible = True
		SawGoldTeeth.Visible = True
	Else
		Saw.Visible = True
		SawGold.Visible = False
		SawGoldTeeth.Visible = False
	End If

'******************************************************
'				FLIPPER AND RUBBER CORRECTION
'******************************************************

dim LF : Set LF = New FlipperPolarity
dim RF : Set RF = New FlipperPolarity

InitPolarity

Sub InitPolarity()
	dim x, a : a = Array(LF, RF)
	for each x in a
		'safety coefficient (diminishes polarity correction only)
		'x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 0	'don't mess with these
		x.AddPoint "Ycoef", 0, RightFlipper.Y-65, 1	'disabled
		x.AddPoint "Ycoef", 1, RightFlipper.Y-11, 1

		x.enabled = True
		'x.DebugOn = True : stickL.visible = True : tbpl.visible = True : vpmSolFlipsTEMP.DebugOn = True
		x.TimeDelay = 60
	Next

	'rf.report "Velocity"
	addpt "Velocity", 0, 0, 	1
	addpt "Velocity", 1, 0.1, 	1.07
	addpt "Velocity", 2, 0.2, 	1.15
	addpt "Velocity", 3, 0.3, 	1.25
	addpt "Velocity", 4, 0.41, 1.05
	addpt "Velocity", 5, 0.65, 	1.0'0.982
	addpt "Velocity", 6, 0.702, 0.968
	addpt "Velocity", 7, 0.95,  0.968
	addpt "Velocity", 8, 1.03, 	0.945

	AddPt "Polarity", 0, 0, 0
	AddPt "Polarity", 1, 0.05, -5.5
	AddPt "Polarity", 2, 0.4, -5.5
	AddPt "Polarity", 3, 0.8, -5.5	
	AddPt "Polarity", 4, 0.85, -5.25
	AddPt "Polarity", 5, 0.9, -4.25
	AddPt "Polarity", 6, 0.95, -3.75
	AddPt "Polarity", 7, 1, -3.25
	AddPt "Polarity", 8, 1.05, -2.25
	AddPt "Polarity", 9, 1.1, -1.5
	AddPt "Polarity", 10, 1.15, -1
	AddPt "Polarity", 11, 1.2, -0.5
	AddPt "Polarity", 12, 1.25, 0
	AddPt "Polarity", 13, 1.3, 0

	LF.Object = LeftFlipper	
	LF.EndPoint = EndPointLp	'you can use just a coordinate, or an object with a .x property. Using a couple of simple primitive objects
	RF.Object = RightFlipper
	RF.EndPoint = EndPointRp
End Sub

Sub AddPt(aStr, idx, aX, aY)	'debugger wrapper for adjusting flipper script in-game
	dim a : a = Array(LF, RF)
	dim x : for each x in a
		x.addpoint aStr, idx, aX, aY
	Next
End Sub

'Trigger Hit - .AddBall activeball
'Trigger UnHit - .PolarityCorrect activeball

Sub TriggerLF_Hit() : LF.Addball activeball : End Sub
Sub TriggerLF_UnHit() : LF.PolarityCorrect activeball : End Sub
Sub TriggerRF_Hit() : RF.Addball activeball : End Sub
Sub TriggerRF_UnHit() : RF.PolarityCorrect activeball : End Sub

'Methods:
'.TimeDelay - Delay before trigger shuts off automatically. Default = 80 (ms)
'.AddPoint - "Polarity", "Velocity", "Ycoef" coordinate points. Use one of these 3 strings, keep coordinates sequential. x = %position on the flipper, y = output
'.Object - set to flipper reference. Optional.
'.StartPoint - set start point coord. Unnecessary, if .object is used.

'Called with flipper - 
'ProcessBalls - catches ball data. 
' - OR - 
'.Fire - fires flipper.rotatetoend automatically + processballs. Requires .Object to be set to the flipper.

Class FlipperPolarity
	Public DebugOn, Enabled
	Private FlipAt	'Timer variable (IE 'flip at 723,530ms...)
	Public TimeDelay	'delay before trigger turns off and polarity is disabled TODO set time!
	private Flipper, FlipperStart,FlipperEnd, FlipperEndY, LR, PartialFlipCoef
	Private Balls(20), balldata(20)
	
	dim PolarityIn, PolarityOut
	dim VelocityIn, VelocityOut
	dim YcoefIn, YcoefOut
	Public Sub Class_Initialize 
		redim PolarityIn(0) : redim PolarityOut(0) : redim VelocityIn(0) : redim VelocityOut(0) : redim YcoefIn(0) : redim YcoefOut(0)
		Enabled = True : TimeDelay = 50 : LR = 1:  dim x : for x = 0 to uBound(balls) : balls(x) = Empty : set Balldata(x) = new SpoofBall : next 
	End Sub
	
	Public Property let Object(aInput) : Set Flipper = aInput : StartPoint = Flipper.x : End Property
	Public Property Let StartPoint(aInput) : if IsObject(aInput) then FlipperStart = aInput.x else FlipperStart = aInput : end if : End Property
	Public Property Get StartPoint : StartPoint = FlipperStart : End Property
	Public Property Let EndPoint(aInput) : FlipperEnd = aInput.x: FlipperEndY = aInput.y: End Property
	Public Property Get EndPoint : EndPoint = FlipperEnd : End Property	
	Public Property Get EndPointY: EndPointY = FlipperEndY : End Property

	
	Public Sub AddPoint(aChooseArray, aIDX, aX, aY) 'Index #, X position, (in) y Position (out) 
		Select Case aChooseArray
			case "Polarity" : ShuffleArrays PolarityIn, PolarityOut, 1 : PolarityIn(aIDX) = aX : PolarityOut(aIDX) = aY : ShuffleArrays PolarityIn, PolarityOut, 0
			Case "Velocity" : ShuffleArrays VelocityIn, VelocityOut, 1 :VelocityIn(aIDX) = aX : VelocityOut(aIDX) = aY : ShuffleArrays VelocityIn, VelocityOut, 0
			Case "Ycoef" : ShuffleArrays YcoefIn, YcoefOut, 1 :YcoefIn(aIDX) = aX : YcoefOut(aIDX) = aY : ShuffleArrays YcoefIn, YcoefOut, 0
		End Select
		if gametime > 100 then Report aChooseArray
	End Sub 

	Public Sub Report(aChooseArray) 	'debug, reports all coords in tbPL.text
		if not DebugOn then exit sub
		dim a1, a2 : Select Case aChooseArray
			case "Polarity" : a1 = PolarityIn : a2 = PolarityOut
			Case "Velocity" : a1 = VelocityIn : a2 = VelocityOut
			Case "Ycoef" : a1 = YcoefIn : a2 = YcoefOut 
			case else :tbpl.text = "wrong string" : exit sub
		End Select
		dim str, x : for x = 0 to uBound(a1) : str = str & aChooseArray & " x: " & round(a1(x),4) & ", " & round(a2(x),4) & vbnewline : next
		tbpl.text = str
	End Sub
	
	Public Sub AddBall(aBall) : dim x : for x = 0 to uBound(balls) : if IsEmpty(balls(x)) then set balls(x) = aBall : exit sub :end if : Next  : End Sub

	Private Sub RemoveBall(aBall)
		dim x : for x = 0 to uBound(balls)
			if TypeName(balls(x) ) = "IBall" then 
				if aBall.ID = Balls(x).ID Then
					balls(x) = Empty
					Balldata(x).Reset
				End If
			End If
		Next
	End Sub
	
	Public Sub Fire() 
		Flipper.RotateToEnd
		processballs
	End Sub

	Public Property Get Pos 'returns % position a ball. For debug stuff.
		dim x : for x = 0 to uBound(balls)
			if not IsEmpty(balls(x) ) then
				pos = pSlope(Balls(x).x, FlipperStart, 0, FlipperEnd, 1)
			End If
		Next		
	End Property

	Public Sub ProcessBalls() 'save data of balls in flipper range
		FlipAt = GameTime
		dim x : for x = 0 to uBound(balls)
			if not IsEmpty(balls(x) ) then
				balldata(x).Data = balls(x)
			End If
		Next
		PartialFlipCoef = ((Flipper.StartAngle - Flipper.CurrentAngle) / (Flipper.StartAngle - Flipper.EndAngle))
		PartialFlipCoef = abs(PartialFlipCoef-1)
	End Sub
	Private Function FlipperOn() : if gameTime < FlipAt+TimeDelay then FlipperOn = True : End If : End Function	'Timer shutoff for polaritycorrect
	
	Public Sub PolarityCorrect(aBall)
		if FlipperOn() then 
			dim tmp, BallPos, x, IDX, Ycoef : Ycoef = 1

			'y safety Exit
			if aBall.VelY > -8 then 'ball going down
				RemoveBall aBall
				exit Sub
			end if

			'Find balldata. BallPos = % on Flipper
			for x = 0 to uBound(Balls)
				if aBall.id = BallData(x).id AND not isempty(BallData(x).id) then 
					idx = x
					BallPos = PSlope(BallData(x).x, FlipperStart, 0, FlipperEnd, 1)
					if ballpos > 0.65 then  Ycoef = LinearEnvelope(BallData(x).Y, YcoefIn, YcoefOut)				'find safety coefficient 'ycoef' data
				end if
			Next

			If BallPos = 0 Then 'no ball data meaning the ball is entering and exiting pretty close to the same position, use current values.
				BallPos = PSlope(aBall.x, FlipperStart, 0, FlipperEnd, 1)
				if ballpos > 0.65 then  Ycoef = LinearEnvelope(aBall.Y, YcoefIn, YcoefOut)						'find safety coefficient 'ycoef' data
			End If

			'Velocity correction
			if not IsEmpty(VelocityIn(0) ) then
				Dim VelCoef
	 : 			VelCoef = LinearEnvelope(BallPos, VelocityIn, VelocityOut)

				if partialflipcoef < 1 then VelCoef = PSlope(partialflipcoef, 0, 1, 1, VelCoef)

				if Enabled then aBall.Velx = aBall.Velx*VelCoef
				if Enabled then aBall.Vely = aBall.Vely*VelCoef
			End If

			'Polarity Correction (optional now)
			if not IsEmpty(PolarityIn(0) ) then
				If StartPoint > EndPoint then LR = -1	'Reverse polarity if left flipper
				dim AddX : AddX = LinearEnvelope(BallPos, PolarityIn, PolarityOut) * LR
	
				if Enabled then aBall.VelX = aBall.VelX + 1 * (AddX*ycoef*PartialFlipcoef)
				'debug.print BallPos & " " & AddX & " " & Ycoef & " "& PartialFlipcoef & " "& VelCoef
				'playsound "fx_knocker"
			End If
		End If
		RemoveBall aBall
	End Sub
End Class


'================================
'Helper Functions


Sub ShuffleArray(ByRef aArray, byVal offset) 'shuffle 1d array
	dim x, aCount : aCount = 0
	redim a(uBound(aArray) )
	for x = 0 to uBound(aArray)	'Shuffle objects in a temp array
		if not IsEmpty(aArray(x) ) Then
			if IsObject(aArray(x)) then 
				Set a(aCount) = aArray(x)
			Else
				a(aCount) = aArray(x)
			End If
			aCount = aCount + 1
		End If
	Next
	if offset < 0 then offset = 0
	redim aArray(aCount-1+offset)	'Resize original array
	for x = 0 to aCount-1		'set objects back into original array
		if IsObject(a(x)) then 
			Set aArray(x) = a(x)
		Else
			aArray(x) = a(x)
		End If
	Next
End Sub

Sub ShuffleArrays(aArray1, aArray2, offset)
	ShuffleArray aArray1, offset
	ShuffleArray aArray2, offset
End Sub


Function BallSpeed(ball) 'Calculates the ball speed
    BallSpeed = SQR(ball.VelX^2 + ball.VelY^2 + ball.VelZ^2)
End Function

Function PSlope(Input, X1, Y1, X2, Y2)	'Set up line via two points, no clamping. Input X, output Y
	dim x, y, b, m : x = input : m = (Y2 - Y1) / (X2 - X1) : b = Y2 - m*X2
	Y = M*x+b
	PSlope = Y
End Function

Function NullFunctionZ(aEnabled):End Function	'1 argument null function placeholder	 TODO move me or replac eme

Class spoofball 
	Public X, Y, Z, VelX, VelY, VelZ, ID, Mass, Radius 
	Public Property Let Data(aBall)
		With aBall
			x = .x : y = .y : z = .z : velx = .velx : vely = .vely : velz = .velz
			id = .ID : mass = .mass : radius = .radius
		end with
	End Property
	Public Sub Reset()
		x = Empty : y = Empty : z = Empty  : velx = Empty : vely = Empty : velz = Empty 
		id = Empty : mass = Empty : radius = Empty
	End Sub
End Class

Function Distance(ax,ay,bx,by)
	Distance = SQR((ax - bx)^2 + (ay - by)^2)
End Function

Function DistancePL(px,py,ax,ay,bx,by) ' Distance between a point and a line where point is px,py
	DistancePL = ABS((by - ay)*px - (bx - ax) * py + bx*ay - by*ax)/Distance(ax,ay,bx,by)
End Function


'****************************************************************************
'PHYSICS DAMPENERS

'These are data mined bounce curves, 
'dialed in with the in-game elasticity as much as possible to prevent angle / spin issues.
'Requires tracking ballspeed to calculate COR


Sub dPosts_Hit(idx) 
	RubbersD.dampen Activeball
End Sub

Sub dSleeves_Hit(idx) 
	SleevesD.Dampen Activeball
End Sub

dim RubbersD : Set RubbersD = new Dampener	'frubber
RubbersD.name = "Rubbers"
RubbersD.debugOn = False	'shows info in textbox "TBPout"
RubbersD.Print = False	'debug, reports in debugger (in vel, out cor)
'cor bounce curve (linear)
'for best results, try to match in-game velocity as closely as possible to the desired curve
'RubbersD.addpoint 0, 0, 0.935	'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 0, 0, 0.935 '0.96	'point# (keep sequential), ballspeed, CoR (elasticity)
RubbersD.addpoint 1, 3.77, 0.935 '0.96
RubbersD.addpoint 2, 5.76, 0.942 '0.967	'dont take this as gospel. if you can data mine rubber elasticitiy, please help!
RubbersD.addpoint 3, 15.84, 0.874
RubbersD.addpoint 4, 56, 0.64	'there's clamping so interpolate up to 56 at least

dim SleevesD : Set SleevesD = new Dampener	'this is just rubber but cut down to 85%...
SleevesD.name = "Sleeves"
SleevesD.debugOn = False	'shows info in textbox "TBPout"
SleevesD.Print = False	'debug, reports in debugger (in vel, out cor)
SleevesD.CopyCoef RubbersD, 0.85

Class Dampener
	Public Print, debugOn 'tbpOut.text
	public name, Threshold 	'Minimum threshold. Useful for Flippers, which don't have a hit threshold.
	Public ModIn, ModOut
	Private Sub Class_Initialize : redim ModIn(0) : redim Modout(0): End Sub 

	Public Sub AddPoint(aIdx, aX, aY) 
		ShuffleArrays ModIn, ModOut, 1 : ModIn(aIDX) = aX : ModOut(aIDX) = aY : ShuffleArrays ModIn, ModOut, 0
		if gametime > 100 then Report
	End Sub

	public sub Dampen(aBall)
		if threshold then if BallSpeed(aBall) < threshold then exit sub end if end if
		dim RealCOR, DesiredCOR, str, coef
		DesiredCor = LinearEnvelope(cor.ballvel(aBall.id), ModIn, ModOut )
		RealCOR = BallSpeed(aBall) / cor.ballvel(aBall.id)
		coef = desiredcor / realcor 
		if debugOn then str = name & " in vel:" & round(cor.ballvel(aBall.id),2 ) & vbnewline & "desired cor: " & round(desiredcor,4) & vbnewline & _
		"actual cor: " & round(realCOR,4) & vbnewline & "ballspeed coef: " & round(coef, 3) & vbnewline 
		if Print then debug.print Round(cor.ballvel(aBall.id),2) & ", " & round(desiredcor,3)
		
		aBall.velx = aBall.velx * coef : aBall.vely = aBall.vely * coef
		'playsound "fx_knocker"
		if debugOn then TBPout.text = str
	End Sub

	Public Sub CopyCoef(aObj, aCoef) 'alternative addpoints, copy with coef
		dim x : for x = 0 to uBound(aObj.ModIn)
			addpoint x, aObj.ModIn(x), aObj.ModOut(x)*aCoef
		Next
	End Sub


	Public Sub Report() 	'debug, reports all coords in tbPL.text
		if not debugOn then exit sub
		dim a1, a2 : a1 = ModIn : a2 = ModOut
		dim str, x : for x = 0 to uBound(a1) : str = str & x & ": " & round(a1(x),4) & ", " & round(a2(x),4) & vbnewline : next
		TBPout.text = str
	End Sub
	

End Class

'Tracks ball velocity for judging bounce calculations & angle
'apologies to JimmyFingers is this is what his script does. I know his tracks ball velocity too but idk how it works in particular
dim cor : set cor = New CoRTracker
cor.debugOn = False
'cor.update() - put this on a low interval timer
Class CoRTracker
	public DebugOn 'tbpIn.text
	public ballvel

	Private Sub Class_Initialize : redim ballvel(0) : End Sub 
	'TODO this would be better if it didn't do the sorting every ms, but instead every time it's pulled for COR stuff
	Public Sub Update()	'tracks in-ball-velocity
		dim str, b, AllBalls, highestID : allBalls = getballs
		'if uBound(allballs) < 0 then if DebugOn then str = "no balls" : TBPin.text = str : exit Sub else exit sub end if: end if
		for each b in allballs
			if b.id >= HighestID then highestID = b.id
		Next

		if uBound(ballvel) < highestID then redim ballvel(highestID)	'set bounds

		for each b in allballs
			ballvel(b.id) = BallSpeed(b)
'			if DebugOn then 
'				dim s, bs 'debug spacer, ballspeed
'				bs = round(BallSpeed(b),1)
'				if bs < 10 then s = " " else s = "" end if
'				str = str & b.id & ": " & s & bs & vbnewline 
'				'str = str & b.id & ": " & s & bs & "z:" & b.z & vbnewline 
'			end if
		Next
		'if DebugOn then str = "ubound ballvels: " & ubound(ballvel) & vbnewline & str : if TBPin.text <> str then TBPin.text = str : end if
	End Sub
End Class

Function LinearEnvelope(xInput, xKeyFrame, yLvl)
	dim y 'Y output
	dim L 'Line
	dim ii : for ii = 1 to uBound(xKeyFrame)	'find active line
		if xInput <= xKeyFrame(ii) then L = ii : exit for : end if
	Next
	if xInput > xKeyFrame(uBound(xKeyFrame) ) then L = uBound(xKeyFrame)	'catch line overrun
	Y = pSlope(xInput, xKeyFrame(L-1), yLvl(L-1), xKeyFrame(L), yLvl(L) )

	'Clamp if on the boundry lines
	'if L=1 and Y < yLvl(LBound(yLvl) ) then Y = yLvl(lBound(yLvl) )
	'if L=uBound(xKeyFrame) and Y > yLvl(uBound(yLvl) ) then Y = yLvl(uBound(yLvl) )
	'clamp 2.0
	if xInput <= xKeyFrame(lBound(xKeyFrame) ) then Y = yLvl(lBound(xKeyFrame) ) 	'Clamp lower
	if xInput >= xKeyFrame(uBound(xKeyFrame) ) then Y = yLvl(uBound(xKeyFrame) )	'Clamp upper

	LinearEnvelope = Y
End Function


'////////////////////////////  MECHANICAL SOUNDS  ///////////////////////////
'//  This part in the script is an entire block that is dedicated to the physics sound system.
'//  Various scripts and sounds that may be pretty generic and could suit other WPC systems, but the most are tailored specifically for this table.

'///////////////////////////////  SOUND VARIABLES DECLARATION  //////////////////////////////
Dim FlipperUpAttackMinimumSoundLevel
Dim FlipperUpAttackMaximumSoundLevel
Dim FlipperUpAttackLeftSoundLevel
Dim FlipperUpAttackRightSoundLevel
Dim FlipperUpSoundLevel 
Dim FlipperDownSoundLevel
Dim FlipperLeftHitParm
Dim FlipperRightHitParm
Dim LeftRampSoundLevel
Dim RightRampSoundLevel
Dim RampFallbackSoundLevel
Dim LRHit1_volume
Dim LRHit2_volume
Dim LRHit3_volume
Dim LRHit4_volume
Dim LRHit5_volume
Dim LRHit6_volume
Dim LRHit7_volume
Dim RRHit1_volume
Dim RRHit2_volume
Dim RRHit3_volume
Dim RRHit4_volume
Dim RelayFlashUpperSoundLevel
Dim RelayFlashLowerSoundLevel
Dim RelayGISoundLevel
Dim TrunkHitSoundFactor
Dim TrunkMotorSoundLevel
Dim TrunkCatchSoundLevel
Dim TrunkMagnetSoundLevel
Dim TrunkBallDropSoundLevel
Dim TrunkEnteranceFrontSoundLevel
Dim TrunkEnteranceRearSoundLevel
Dim TrunkTrough_1SoundLevel
Dim TrunkTrough_2_MultiballSoundLevel
Dim TrunkTrough_3SoundLevel
Dim TrapdoorCloseSoundLevel
Dim TrapdoorOpenSoundLevel
Dim TrapdoorEnterSoundLevel
Dim TrapdoorSubReleaseSoundLevel
Dim TrapdoorEjectPopperSoundLevel
Dim TrapdoorBallDropOnPlayfieldSoundLevel
Dim BumperSoundFactor
Dim KnockerSoundLevel
Dim SlingshotSoundLevel
Dim LaneLoudImpactMinimumSoundLevel
Dim LaneLoudImpactMaximumSoundLevel
Dim LaneLoudImpactSoundLevel
Dim BallWithBallCollisionSoundFactor
Dim BallWithCaptiveBallCollisionSoundFactor
Dim BallBouncePlayfieldSoftFactor
Dim BallBouncePlayfieldHardFactor
Dim BallDropFromRampBehindSpinnerSoundLevel
Dim GateSoundLevel
Dim TargetSoundFactor
Dim SpinnerSoundLevel
Dim RolloverSoundLevel
Dim LeftRampDropToPlayfieldSoundLevel
Dim RightRampDropToPlayfieldSoundLevel
Dim FlapSoundLevel
Dim SkillTheatreEntranceFlapUpSoundLevel
Dim SkillTheatreEntranceFlapDownSoundLevel
Dim SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel
Dim SkillTheatreEntranceMetalRampSoundLevel
Dim VanishSolenoidLockSoundLevel
Dim VanishSolenoidKickoutSoundLevel
Dim VanishKickoutBallDropOnPlayfieldSoundLevel
Dim BallReleaseSoundLevel
Dim BallReleaseShooterLaneSoundLevel
Dim SpiritRingSolenoidCaptureSoundLevel
Dim SpiritRingMagnetSoundLevel
Dim MagnaSaveMagnetSoundLevel
Dim LoopPostSolenoidSoundFactor
Dim LoopPostMagnetSoundLevel
Dim DiverterPostSolenoidSoundLevel
Dim DiverterPostMagnetSoundLevel
Dim CenterPostSolenoidSoundLevel
Dim TigerSawMotorSoundLevel
Dim PlasticRightRampBallDropFromSpiritRingSoundLevel
Dim BallDropFromCatwalkRampToRampSoundLevel
Dim WireRampCatwalkSoundLevel
Dim RightOuterLoopRampAfterDropFromCatwalkSoundLevel
Dim RightOuterLoopRampFromBallGateSoundLevel
Dim RightOuterLoopRampAfterDropFromSkillTheatreEntranceSoundLevel
Dim RubberStrongSoundFactor
Dim RubberWeakSoundFactor
Dim RubberFlipperSoundFactor
Dim WallImpactSoundFactor
Dim MetalImpactSoundFactor
Dim BottomArchBallGuideSoundFactor
Dim FlipperBallGuideSoundFactor
Dim PlungerReleaseSoundLevel
Dim PlungerPullSoundLevel
Dim CoinSoundLevel
Dim NudgeLeftSoundLevel
Dim NudgeRightSoundLevel
Dim NudgeCenterSoundLevel
Dim StartButtonSoundLevel
Dim LutToggleSoundLevel
Dim DrainSoundLevel
Dim WireformAntiRebountRailSoundFactor
Dim RollingSoundFactor
Dim InnerLoopSoundFactor
Dim LaneSoundFactor
Dim LaneEnterSoundFactor

'///////////////////////////////  GENERAL HELPERS VARIABLE DECLARATION  //////////////////////////////
Dim GlobalSoundLevel
Dim SoundOn : SoundOn = 1
Dim SoundOff : SoundOff = 0
Dim SoundOff_SpiritRing : SoundOff_SpiritRing = 2
Dim Up : Up = 0
Dim Down : Down = 1
Dim ActuatorOpened : ActuatorOpened = 1
Dim ActuatorClosed : ActuatorClosed = 0
Dim NoBallLocked : NoBallLocked = 0
Dim OneBallLocked : OneBallLocked = 1
Dim TwoBallsLocked : TwoBallsLocked = 2
Dim Vanish_sw83 : Vanish_sw83 = 1
Dim Vanish_sw84 : Vanish_sw84 = 1


'///////////////////////////////  SOUNDS PARAMETERS  //////////////////////////////
GlobalSoundLevel = 3													'relative sound level sound relays only; This is not used for global sound effects volume.
LutToggleSoundLevel = 0.5												'volume level; range [0, 1]
CoinSoundLevel = 1														'volume level; range [0, 1]
NudgeLeftSoundLevel = 1													'volume level; range [0, 1]
NudgeRightSoundLevel = 1												'volume level; range [0, 1]
NudgeCenterSoundLevel = 1												'volume level; range [0, 1]
StartButtonSoundLevel = 0.1												'volume level; range [0, 1]
PlungerReleaseSoundLevel = 1											'volume level; range [0, 1]
PlungerPullSoundLevel = 1												'volume level; range [0, 1]
RollingSoundFactor = 1.1												'volume multiplier; must not be zero


'///////////////////////-----Solenoids, Kickers and Flash Relays-----///////////////////////
FlipperUpAttackMinimumSoundLevel = 0.010           						'volume level; range [0, 1]
FlipperUpAttackMaximumSoundLevel = 0.635								'volume level; range [0, 1]
FlipperUpSoundLevel = 1.0                        						'volume level; range [0, 1]
FlipperDownSoundLevel = 0.45                      						'volume level; range [0, 1]
FlipperLeftHitParm = FlipperUpSoundLevel								'sound helper; not configurable
FlipperRightHitParm = FlipperUpSoundLevel								'sound helper; not configurable
RelayFlashUpperSoundLevel = 0.0025 * GlobalSoundLevel * 14				'volume level; range [0, 1];
RelayFlashLowerSoundLevel = 0.0075 * GlobalSoundLevel					'volume level; range [0, 1];
RelayGISoundLevel = 0.025 * GlobalSoundLevel * 14						'volume level; range [0, 1];
SlingshotSoundLevel = 0.95												'volume level; range [0, 1]
BumperSoundFactor = 4.25												'volume multiplier; must not be zero
KnockerSoundLevel = 1 													'volume level; range [0, 1]
LoopPostSolenoidSoundFactor = 3											'volume multiplier; must not be zero
LoopPostMagnetSoundLevel = 1											'volume level; range [0, 1]
DiverterPostSolenoidSoundLevel = 3										'volume level; range [0, 1]
DiverterPostMagnetSoundLevel = 1										'volume level; range [0, 1]
CenterPostSolenoidSoundLevel = 1										'volume level; range [0, 1]

'///////////////////////-----Loops and Lanes-----///////////////////////
InnerLoopSoundFactor = 0.25												'volume multiplier; must not be zero
LaneSoundFactor = 0.15													'volume multiplier; must not be zero
LaneEnterSoundFactor = 0.3												'volume multiplier; must not be zero
LaneLoudImpactMinimumSoundLevel = 0										'volume level; range [0, 1]
LaneLoudImpactMaximumSoundLevel = 0.3									'volume level; range [0, 1]


'///////////////////////-----Ramps-----///////////////////////
'///////////////////////-----Plastic Ramps-----///////////////////////
LeftRampSoundLevel = 0.1												'volume level; range [0, 1]
RightRampSoundLevel = 0.1												'volume level; range [0, 1]
RampFallbackSoundLevel = 0.2											'volume level; range [0, 1]
'///////////////////////-----Wire Ramps-----///////////////////////
SkillTheatreEntranceMetalRampSoundLevel = 1								'volume level; range [0, 1]
RightOuterLoopRampAfterDropFromSkillTheatreEntranceSoundLevel = 1   	'volume level; range [0, 1]
RightOuterLoopRampFromBallGateSoundLevel = 0.9							'volume level; range [0, 1]
WireRampCatwalkSoundLevel = 0.75										'volume level; range [0, 1]
'///////////////////////-----Ramp Flaps-----///////////////////////
FlapSoundLevel = 0.8													'volume level; range [0, 1]
SkillTheatreEntranceFlapUpSoundLevel = 1								'volume level; range [0, 1]
SkillTheatreEntranceFlapDownSoundLevel = 1								'volume level; range [0, 1]


'///////////////////////-----Ball Drops, Bumps and Collisions-----///////////////////////
BallWithBallCollisionSoundFactor = 3.2									'volume multiplier; must not be zero
BallWithCaptiveBallCollisionSoundFactor = 13							'volume multiplier; must not be zero
BallBouncePlayfieldSoftFactor = 0.025									'volume multiplier; must not be zero
BallBouncePlayfieldHardFactor = 0.025									'volume multiplier; must not be zero
BallDropFromRampBehindSpinnerSoundLevel = 0.85							'volume level; range [0, 1]
BallDropFromCatwalkRampToRampSoundLevel = 0.8							'volume level; range [0, 1]
LeftRampDropToPlayfieldSoundLevel = 0.9									'volume level; range [0, 1]
RightRampDropToPlayfieldSoundLevel = 0.9								'volume level; range [0, 1]
RightOuterLoopRampAfterDropFromCatwalkSoundLevel = 0.9					'volume level; range [0, 1]
SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel = 0.85			'volume level; range [0, 1]
TrapdoorBallDropOnPlayfieldSoundLevel = 0.8								'volume level; range [0, 1]
VanishKickoutBallDropOnPlayfieldSoundLevel = 0.85						'volume level; range [0, 1]
PlasticRightRampBallDropFromSpiritRingSoundLevel = 1					'volume level; range [0, 1]
WallImpactSoundFactor = 0.075											'volume multiplier; must not be zero
MetalImpactSoundFactor = 0.075											'volume multiplier; must not be zero


'///////////////////////-----Gates, Spinners, Rollovers and Targets-----///////////////////////
GateSoundLevel = 0.5													'volume level; range [0, 1]
TargetSoundFactor = 0.0025												'volume multiplier; must not be zero
SpinnerSoundLevel = 0.002												'volume level; range [0, 1]
RolloverSoundLevel = 0.25                              					'volume level; range [0, 1]
RubberStrongSoundFactor = 0.055											'volume multiplier; must not be zero
RubberWeakSoundFactor = 0.075											'volume multiplier; must not be zero
RubberFlipperSoundFactor = 0.075										'volume multiplier; must not be zero


'///////////////////////-----Ball Release, Guides and Drain-----///////////////////////
DrainSoundLevel = 0.8														'volume level; range [0, 1]
BallReleaseSoundLevel = 1												'volume level; range [0, 1]
BallReleaseShooterLaneSoundLevel = 1									'volume level; range [0, 1]
BottomArchBallGuideSoundFactor = 0.2									'volume multiplier; must not be zero
FlipperBallGuideSoundFactor = 0.015										'volume multiplier; must not be zero
WireformAntiRebountRailSoundFactor = 0.04								'volume multiplier; must not be zero

'///////////////////////////////  THEATRE OF MAGIC SPECIFIC SOUND PARAMETERS  //////////////////////////////
TrunkHitSoundFactor = 0.25												'volume multiplier; must not be zero
TrunkMotorSoundLevel = 0.6                             					'volume level; range [0, 1]
TrunkCatchSoundLevel = 1                              					'volume level; range [0, 1]
TrunkMagnetSoundLevel = 0.05                           					'volume level; range [0, 1]
TrunkBallDropSoundLevel = 1                            					'volume level; range [0, 1]
TrunkEnteranceFrontSoundLevel = 1                      					'volume level; range [0, 1]
TrunkEnteranceRearSoundLevel = 1                       					'volume level; range [0, 1]
TrunkTrough_1SoundLevel = 1                            					'volume level; range [0, 1]
TrunkTrough_2_MultiballSoundLevel = 0.95               					'volume level; range [0, 1]
TrunkTrough_3SoundLevel = 1                              				'volume level; range [0, 1]
TrapdoorCloseSoundLevel = 0.8                             				'volume level; range [0, 1]
TrapdoorOpenSoundLevel = 0.8		                       				'volume level; range [0, 1]
TrapdoorEnterSoundLevel = 1                             				'volume level; range [0, 1]
TrapdoorSubReleaseSoundLevel = 0.85                            			'volume level; range [0, 1]
TrapdoorEjectPopperSoundLevel = 1  		                           		'volume level; range [0, 1]
SpiritRingSolenoidCaptureSoundLevel = 1                             	'volume level; range [0, 1]
SpiritRingMagnetSoundLevel = 0.2                             			'volume level; range [0, 1]
MagnaSaveMagnetSoundLevel = 1											'volume level; range [0, 1]
TigerSawMotorSoundLevel = 0.1											'volume level; range [0, 1]
VanishSolenoidLockSoundLevel = 0.4										'volume level; range [0, 1]
VanishSolenoidKickoutSoundLevel = 0.8									'volume level; range [0, 1]



'/////////////////////////////  SOUND PLAYBACK FUNCTIONS  ////////////////////////////
'/////////////////////////////  POSITIONAL SOUND PLAYBACK METHODS  ////////////////////////////
' Positional sound playback methods will play a sound, depending on the X,Y position of the table element or depending on ActiveBall object position
' These are similar subroutines that are less complicated to use (e.g. simply use standard parameters for the PlaySound call)
' For surround setup - positional sound playback functions will fade between front and rear surround channels and pan between left and right channels
' For stereo setup - positional sound playback functions will only pan between left and right channels
' For mono setup - positional sound playback functions will not pan between left and right channels and will not fade between front and rear channels

' PlaySound full syntax - PlaySound(string, int loopcount, float volume, float pan, float randompitch, int pitch, bool useexisting, bool restart, float front_rear_fade)
' Note - These functions will not work (currently) for walls/slingshots as these do not feature a simple, single X,Y position
Sub PlaySoundAtLevelStatic(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelExistingStatic(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 1, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticLoop(playsoundparams, aVol, tableobj)
    PlaySound playsoundparams, -1, aVol * VolumeDial, AudioPan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelStaticRandomPitch(playsoundparams, aVol, randomPitch, tableobj)
    PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtLevelActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLevelExistingActiveBall(playsoundparams, aVol)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ActiveBall), 0, 0, 1, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtLeveTimerActiveBall(playsoundparams, aVol, ballvariable)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ballvariable), 0, 0, 0, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelTimerExistingActiveBall(playsoundparams, aVol, ballvariable)
	PlaySound playsoundparams, 0, aVol * VolumeDial, AudioPan(ballvariable), 0, 0, 1, 0, AudioFade(ballvariable)
End Sub

Sub PlaySoundAtLevelRoll(playsoundparams, aVol, pitch)
    PlaySound playsoundparams, -1, aVol * VolumeDial, AudioPan(tableobj), randomPitch, 0, 0, 0, AudioFade(tableobj)
End Sub

'/////////////////////////////  SUPPORTING BALL & SOUND FUNCTIONS  ////////////////////////////
Function AudioFade(tableobj) ' Fades between front and back of the table (for surround systems or 2x2 speakers, etc), depending on the Y position on the table. "table1" is the name of the table
	Dim tmp
	Select Case PositionalSoundPlaybackConfiguration
		Case 1
			AudioFade = 0
		Case 2
			AudioFade = 0
		Case 3
			tmp = tableobj.y * 2 / tableheight-1
			'tmp = tableobj.x * 2 / table1.height-1
			If tmp > 0 Then
				AudioFade = Csng(tmp ^10)
			Else
				AudioFade = Csng(-((- tmp) ^10) )
			End If
	End Select
End Function

Function AudioPan(tableobj) ' Calculates the pan for a tableobj based on the X position on the table. "table1" is the name of the table
	Dim tmp
	Select Case PositionalSoundPlaybackConfiguration
		Case 1
			AudioPan = 0
		Case 2
			tmp = tableobj.x * 2 / tablewidth-1
		    'tmp = tableobj.x * 2 / table1.width-1
			If tmp > 0 Then
				AudioPan = Csng(tmp ^10)
			Else
				AudioPan = Csng(-((- tmp) ^10) )
			End If
		Case 3
			tmp = tableobj.x * 2 / tablewidth-1
			'tmp = tableobj.x * 2 / table1.width-1
			If tmp > 0 Then
				AudioPan = Csng(tmp ^10)
			Else
				AudioPan = Csng(-((- tmp) ^10) )
			End If
	End Select
End Function

Function Vol(ball) ' Calculates the volume of the sound based on the ball speed
	Vol = Csng(BallVel(ball) ^2)
	'Vol = Csng(BallVel(ball) ^2/55)
	'Vol = Csng(BallVel(ball) ^2)
End Function

Function Pitch(ball) ' Calculates the pitch of the sound based on the ball speed
    Pitch = BallVel(ball) * 20
End Function

Function BallVel(ball) 'Calculates the ball speed
    BallVel = INT(SQR((ball.VelX ^2) + (ball.VelY ^2) ) )
End Function

Function VolPlayfieldRoll(ball) ' Calculates the roll volume of the sound based on the ball speed
	VolPlayfieldRoll = RollingSoundFactor * 0.0005 * Csng(BallVel(ball) ^3)
End Function

Function VolPlasticRampRoll(ball) ' Calculates the roll volume of the sound based on the ball speed
	VolPlasticRampRoll = RollingSoundFactor * 0.0005 * Csng(BallVel(ball) ^3)
End Function

Function PitchPlayfieldRoll(ball) ' Calculates the roll pitch of the sound based on the ball speed
    PitchPlayfieldRoll = BallVel(ball) ^2 * 15
End Function

Function PitchPlasticRamp(ball) ' Calculates the pitch of the sound based on the ball speed - used for plastic ramps roll sound
    PitchPlasticRamp = BallVel(ball) * 20
End Function


'/////////////////////////////  WIRE RAMP TIMERS  ////////////////////////////
'Measures for InRect function

'All plastic ramps
'InRect(BOT(b).x, BOT(b).y, 23,469,733,469,797,1390,7,2127) 

'Magic trunk
'InRect(BOT(b).x, BOT(b).y, 190,803,405,776,425,1057,216,1082) 

'Catwalk wire ramp
'InRect(BOT(b).x, BOT(b).y, 147,1040,760,1685,695,1748,83,1101)

'Complete right wire ramp
'InRect(BOT(b).x, BOT(b).y, 733,469,938,511,938,2010,660,1895)



Sub WireRampTimer1_Timer()
	' 4 point polygon that contains a complete right wire ramp
	' This timer is enabled from SoundRightOuterLoopRampFromBallGate sub
	If ballvariableWireRampTimer1.VelY > 0 and InRect(ballvariableWireRampTimer1.x, ballvariableWireRampTimer1.y, 733,469,938,511,938,2010,660,1895) Then
		'PlaySoundAtLevelTimerExistingActiveBall ("TOM_RightOuterLoop_Enter_From_Gate_Roll"), RightOuterLoopRampFromBallGateSoundLevel, ballvariableWireRampTimer1
		PlaySoundAtLevelTimerExistingActiveBall ("TOM_RightOuterLoop_Enter_From_Gate_Roll"), RollingSoundFactor * 0.00025 * Csng(BallVel(ballvariableWireRampTimer1) ^3) * VolumeDial, ballvariableWireRampTimer1
	Else
		Me.Enabled = 0
	End If
End Sub


Sub WireRampTimer2_Timer()
	' 4 point polygon that contains a complete right wire ramp
	' This timer is enabled from SoundRightOuterLoopRampAfterDropFromSkillTheatreEntrance sub
	If InRect(ballvariableWireRampTimer2.x, ballvariableWireRampTimer2.y, 733,469,938,511,938,2010,660,1895) Then
		'PlaySoundAtLevelTimerExistingActiveBall ("TOM_RightOuterLoopRampAfterDropFromSkillTheatreEntrance"), RollingSoundFactor * 0.0005 * Csng(BallVel(ballvariableWireRampTimer2) ^3) * VolumeDial, ballvariableWireRampTimer2
		PlaySoundAtLevelTimerExistingActiveBall ("TOM_RightOuterLoopRampAfterDropFromSkillTheatreEntrance"), RollingSoundFactor * 0.0005 * Csng(BallVel(ballvariableWireRampTimer2) ^3) * VolumeDial, ballvariableWireRampTimer2
	Else
		Me.Enabled = 0
	End If
End Sub


Sub WireRampTimer3_Timer()
	' 4 point polygon that contains a complete right wire ramp
	' This timer is enabled from SoundRightOuterLoopRampAfterDropFromCatwalk sub
	If InRect(ballvariableWireRampTimer3.x, ballvariableWireRampTimer3.y, 733,469,938,511,938,2010,660,1895) Then
		'PlaySoundAtLevelTimerExistingActiveBall ("TOM_RightOuterLoopRampAfterDropFromCatwalk_3"), RightOuterLoopRampAfterDropFromCatwalkSoundLevel, ballvariableWireRampTimer3
		PlaySoundAtLevelTimerExistingActiveBall ("TOM_RightOuterLoopRampAfterDropFromCatwalk_3"), RollingSoundFactor * 0.0005 * Csng(BallVel(ballvariableWireRampTimer3) ^4) * VolumeDial, ballvariableWireRampTimer3
	Else
		Me.Enabled = 0
	End If
End Sub


Sub WireRampTimer4_Timer()
	' 4 point polygon that contains a catwalk wire ramp
	' This timer is enabled from SoundWireRampCatwalk sub
	If InRect(ballvariableWireRampTimer4.x, ballvariableWireRampTimer4.y, 135,1028,760,1685,695,1748,71,1089) Then
		PlaySoundAtLevelTimerExistingActiveBall ("TOM_Catwalk_Ramp_3"), WireRampCatwalkSoundLevel, ballvariableWireRampTimer4
		If ballvariableWireRampTimer4.velx > 4.5 + ((ballvariableWireRampTimer4.x - 130)/600 * 5.75) then ballvariableWireRampTimer4.velx = 4.5 + ((ballvariableWireRampTimer4.x - 130)/600 * 5.75)
	Else
		Me.Enabled = 0
	End If
End Sub



'///////////////////////  JP'S VP10 ROLLING SOUNDS, BALL SHADOWS & OTHER MISC  ////////////////////////////
Dim BallShadow
BallShadow = Array (BallShadow1, BallShadow2, BallShadow3, BallShadow4, BallShadow5, BallShadow6, BallShadow7, BallShadow8, BallShadow9, BallShadow10, BallShadow11)

Const tnob = 11 ' total number of balls
ReDim rolling(tnob)
ReDim ramprolling(tnob)
InitRolling

Sub InitRolling
    Dim i
    For i = 0 to tnob
        rolling(i) = False
	ramprolling(i) = False
    Next
End Sub

Sub RollingSoundUpdate()
	Dim BOT, b, shadowZ
	BOT = GetBalls

	For b = 0 to UBound(BOT)
		If BOT(b).y > 430 Then 

			If BOT(b).z < 27 and BOT(b).z > 23 Then

				' play the rolling sound for each ball
				If BallVel(BOT(b) ) > 1 Then
					rolling(b) = True
					PlaySound ("TOM_BallRoll_" & b), -1, VolPlayfieldRoll(BOT(b)) * 1.1 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlayfieldRoll(BOT(b)), 1, 0, AudioFade(BOT(b))
				End If

			ElseIf BOT(b).z > 46 Then

				' play the plastic ramp rolling sound for each ball
				If BallVel(BOT(b) ) > 1 and InRect(BOT(b).x, BOT(b).y, 23,469,733,469,797,1390,7,2127) and Not InRect(BOT(b).x, BOT(b).y, 190,803,405,776,425,1057,216,1082) and Not InRect(BOT(b).x, BOT(b).y, 147,1040,760,1685,695,1748,83,1101) Then
					ramprolling(b) = True
					PlaySound ("TOM_BallRoll_PlasticRamp_" & b), -1, (VolPlasticRampRoll(BOT(b)))/10 * VolumeDial, AudioPan(BOT(b)), 0, PitchPlasticRamp(BOT(b)), 1, 0, AudioFade(BOT(b))
				Else
					If ramprolling(b) = True Then
						ramprolling(b) = False
						StopSound ("TOM_BallRoll_PlasticRamp_" & b)			
					End If
				End If

				'Shooter Ramp Helper
				If BOT(b).x > 838 and BOT(b).y > 1310 and BOT(b).y < 1375 and BOT(b).z > 120 and BOT(b).z < 150 and  BOT(b).velz < -5 and SLHelp < 1 Then
					BOT(b).vely = - 9
					BOT(b).velx = 1
					SLHelp = 5
				End If

			Elseif BOT(b).z < 20 Then
				'Trunk Entrance
				If InRect(BOT(b).x, BOT(b).y,277,945,363,939,369,1015,285,1022) and  BOT(b).z > -35 and BOT(b).velz < -1 Then
					SetTOMB BOT(b), 1
				ElseIf InRect(BOT(b).x, BOT(b).y,227,766,386,754,392,847,230,861) and BOT(b).z > -35 and BOT(b).velz < -1 Then
					SetTOMB BOT(b), 2
				ElseIf BOT(b).z < -1000 Then 'save ball that fell off table
					BOT(b).z = -35
					BOT(b).x = 394
					BOT(b).y = 1163
				End If
			End If

			

			'Ball Shadows
			BallShadow(b).X = BOT(b).X + (BOT(b).X - tablewidth/2)/10
			BallShadow(b).Y = BOT(b).Y + 15 - (abs((BOT(b).X - tablewidth/2)/20))/4

			If BOT(b).X > 875 AND BOT(b).Y > 935 Then 
				shadowZ = BOT(b).Z
				BallShadow(b).X = BOT(b).X 
			Else 
				shadowZ = 1
			End If

			BallShadow(b).height = shadowZ

			If BOT(b).Z > 20 Then
				BallShadow(b).visible = 1
			Else
				BallShadow(b).visible = 0
			End If


			
			If rolling(b) = True and  (BallVel(BOT(b) ) <= 1 or BOT(B).z < 23 or BOT(b).z > 27) Then
				StopSound ("TOM_BallRoll_" & b)
				rolling(b) = False
			End If

			If ramprolling(b) = True and BOT(b).z <= 46 Then
				ramprolling(b) = False
				StopSound ("TOM_BallRoll_PlasticRamp_" & b)
			End If


		End If
	Next

	If TOMB1 > 0 Then TOMB1 = TOMB1 - 1
	If TOMB2 > 0 Then TOMB2 = TOMB2 - 1
	If TOMB3 > 0 Then TOMB3 = TOMB3 - 1
	If TOMB4 > 0 Then TOMB4 = TOMB4 - 1
	If SLHelp > 0 Then SLHelp = SLHelp - 1
End Sub

Dim TOMB1, TOMB2, TOMB3, TOMB4, TOMBCount, SLHelp
TOMBCount = 20

Sub SetTOMB(ball, entrance)
	If ball is TOMBall1 and TOMB1 = 0 Then
		TOMB1 = TOMBCount
		TrunkSound entrance
	ElseIf ball is TOMBall2 and TOMB2 = 0  Then
		TOMB2 = TOMBCount
		TrunkSound entrance
	ElseIf ball is TOMBall3 and TOMB3 = 0  Then
		TOMB3 = TOMBCount
		TrunkSound entrance
	ElseIf ball is TOMBall4 and TOMB4 = 0  Then
		TOMB4 = TOMBCount
		TrunkSound entrance 
	End If
End Sub

Sub TrunkSound(entrance)
	If entrance = 1 Then 'Front Entrance
		vpmtimer.addtimer 200, "RandomSoundTrunkEnteranceFront '"
	ElseIf entrance = 2 Then 'Back Entrance
		vpmtimer.addtimer 200, "RandomSoundTrunkEnteranceRear '"
	End If
End Sub


'/////////////////////////////  JP'S VP10 BALL COLLISION SOUND  ////////////////////////////
Sub OnBallBallCollision(ball1, ball2, velocity)
	Dim snd
	Select Case Int(Rnd*7)+1
		Case 1 : snd = "TOM_WD_Ball_Collide_1"
		Case 2 : snd = "TOM_WD_Ball_Collide_2"
		Case 3 : snd = "TOM_WD_Ball_Collide_3"
		Case 4 : snd = "TOM_WD_Ball_Collide_4"
		Case 5 : snd = "TOM_WD_Ball_Collide_5"
		Case 6 : snd = "TOM_WD_Ball_Collide_6"
		Case 7 : snd = "TOM_WD_Ball_Collide_7"
	End Select

	If (ball1 Is CapL2 Or ball2 Is CapL2) and Not (ball1 is CapL1) and Not (ball2 is CapL1) and velocity > 10 Then
		PlaySound ("TOM_WD_Ball_Collide_Hard"), 0, Csng(velocity) ^2 / 200 * BallWithCaptiveBallCollisionSoundFactor * VolumeDial, AudioPan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)
	End If

	PlaySound (snd), 0, Csng(velocity) ^2 / 200 * BallWithBallCollisionSoundFactor * VolumeDial, AudioPan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)
End Sub


'/////////////////////////////  GENERAL SOUND SUBROUTINES  ////////////////////////////
Sub SoundStartButton()
	PlaySoundAtLevelStatic ("WD_Start_Button"), StartButtonSoundLevel, Prim_Apron1
End Sub

Sub SoundPlungerPull()
	PlaySoundAtLevelStatic ("WD_Plunger_Pull_1"), PlungerPullSoundLevel, Plunger
End Sub

Sub SoundPlungerReleaseBall()
	PlaySoundAtLevelStatic ("WD_Plunger_Release_Ball"), PlungerReleaseSoundLevel, Plunger
End Sub

Sub SoundPlungerReleaseNoBall()
	PlaySoundAtLevelStatic ("WD_Plunger_Release_No_Ball"), PlungerReleaseSoundLevel, Plunger
End Sub

Sub SoundNudgeLeft()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySound ("Nudge_1"), 0, NudgeLeftSoundLevel * VolumeDial, -0.1, 0.25
		Case 2 : PlaySound ("Nudge_2"), 0, NudgeLeftSoundLevel * VolumeDial, -0.1, 0.25
		Case 3 : PlaySound ("Nudge_3"), 0, NudgeLeftSoundLevel * VolumeDial, -0.1, 0.25
	End Select
End Sub

Sub SoundNudgeRight()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySound ("Nudge_1"), 0, NudgeRightSoundLevel * VolumeDial, 0.1, 0.25
		Case 2 : PlaySound ("Nudge_2"), 0, NudgeRightSoundLevel * VolumeDial, 0.1, 0.25
		Case 3 : PlaySound ("Nudge_3"), 0, NudgeRightSoundLevel * VolumeDial, 0.1, 0.25
	End Select
End Sub

Sub SoundNudgeCenter()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySoundAtLevelStatic ("Nudge_1"), NudgeCenterSoundLevel * VolumeDial, Prim_Apron1
		Case 2 : PlaySoundAtLevelStatic ("Nudge_2"), NudgeCenterSoundLevel * VolumeDial, Prim_Apron1
		Case 3 : PlaySoundAtLevelStatic ("Nudge_3"), NudgeCenterSoundLevel * VolumeDial, Prim_Apron1
	End Select
	'PlaySound ("Nudge_1"), 0, NudgeCenterSoundLevel * VolumeDial, 0, 0.25
	'PlaySound ("Nudge_2"), 0, NudgeCenterSoundLevel * VolumeDial, 0, 0.25
	'PlaySound ("Nudge_3"), 0, NudgeCenterSoundLevel * VolumeDial, 0, 0.25
End Sub


'/////////////////////////////  THEATRE OF MAGIC SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  ROLLOVER SOUNDS  ////////////////////////////
Sub RandomSoundRollover()
	Select Case Int(Rnd*4)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Rollover_1"), RolloverSoundLevel
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Rollover_2"), RolloverSoundLevel
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Rollover_3"), RolloverSoundLevel
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Rollover_4"), RolloverSoundLevel
	End Select
End Sub

'/////////////////////////////  BALL GATES AND BRACKET GATES SOUNDS  ////////////////////////////
Sub SoundRampBrktGate1(toggle)
	If toggle = SoundOn Then
		PlaySoundAtLevelStatic ("TOM_Small_Gate_1"), GateSoundLevel * 0.2 , sw75
	End If
	If toggle = SoundOff Then
		Stopsound "TOM_Small_Gate_1"
	End If
End Sub

Sub SoundRampBrktGate2(toggle)
	If toggle = SoundOn Then
		PlaySoundAtLevelStatic ("TOM_Small_Gate_2"), GateSoundLevel * 0.2, sw76
	End If
	If toggle = SoundOff Then
		Stopsound "TOM_Small_Gate_2"
	End If
End Sub

Sub SoundBallGate1()
	PlaySoundAtLevelStatic ("TOM_Gate_FastTrigger_1"), GateSoundLevel, Gate1
End Sub

Sub SoundBallGate2()
	PlaySoundAtLevelStatic ("TOM_Gate2_5"), GateSoundLevel, Gate2
	End Sub

Sub SoundBallGate3()
	PlaySoundAtLevelStatic ("TOM_Gate3_3"), GateSoundLevel, Gate3
End Sub

Sub SoundBallGate6()
	PlaySoundAtLevelStatic ("TOM_Gate_FastTrigger_4"), GateSoundLevel * 0.25, Gate6
End Sub

Sub SoundBallGate_c1()
	PlaySoundAtLevelStatic ("TOM_Gate_C1_TopKickout"), GateSoundLevel, c1
End Sub

Sub SoundGate1Actuator(toggle)
	Select Case toggle
		Case ActuatorOpened
			PlaySoundAtLevelStatic ("TOM_Gate_FastTrigger_1"), 0.8 * GateSoundLevel, Gate1
		Case ActuatorClosed
			PlaySoundAtLevelStatic ("TOM_Gate_FastTrigger_4"), 0.8 * GateSoundLevel , Gate1
	End Select
End Sub

Sub SoundGate3Actuator(toggle)
	Select Case toggle
		Case ActuatorOpened
			PlaySoundAtLevelStatic ("TOM_Gate_FastTrigger_1"), 0.8 * GateSoundLevel, Gate3
		Case ActuatorClosed
			PlaySoundAtLevelStatic ("TOM_Gate_FastTrigger_4"), 0.8 * GateSoundLevel , Gate3
	End Select
End Sub


'/////////////////////////////  SPINNER  ////////////////////////////
Sub SoundSpinner()
	PlaySoundAtLevelStatic ("TOM_NK_Spinner_12"), SpinnerSoundLevel, sw37
End Sub


'/////////////////////////////  TARGET HIT SOUNDS  ////////////////////////////
Sub RandomSoundTargetHitStrong()
	Select Case Int(Rnd*4)+1
		Case 1 : PlaySoundAtLevelActiveBall SoundFX("TOM_Target_Hit_5",DOFTargets), Vol(ActiveBall) * 0.45 * TargetSoundFactor
		Case 2 : PlaySoundAtLevelActiveBall SoundFX("TOM_Target_Hit_6",DOFTargets), Vol(ActiveBall) * 0.45 * TargetSoundFactor
		Case 3 : PlaySoundAtLevelActiveBall SoundFX("TOM_Target_Hit_7",DOFTargets), Vol(ActiveBall) * 0.45 * TargetSoundFactor
		Case 4 : PlaySoundAtLevelActiveBall SoundFX("TOM_Target_Hit_8",DOFTargets), Vol(ActiveBall) * 0.45 * TargetSoundFactor		
	End Select
End Sub

Sub RandomSoundTargetHitWeak()
	Select Case Int(Rnd*4)+1		
		Case 1 : PlaySoundAtLevelActiveBall SoundFX("TOM_Target_Hit_1",DOFTargets), Vol(ActiveBall) * TargetSoundFactor
		Case 2 : PlaySoundAtLevelActiveBall SoundFX("TOM_Target_Hit_2",DOFTargets), Vol(ActiveBall) * TargetSoundFactor
		Case 3 : PlaySoundAtLevelActiveBall SoundFX("TOM_Target_Hit_3",DOFTargets), Vol(ActiveBall) * TargetSoundFactor
		Case 4 : PlaySoundAtLevelActiveBall SoundFX("TOM_Target_Hit_4",DOFTargets), Vol(ActiveBall) * TargetSoundFactor
	End Select
End Sub

'/////////////////////////////  BALL BOUNCE SOUNDS  ////////////////////////////
Sub RandomSoundBallBouncePlayfieldSoft()
	Select Case Int(Rnd*9)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Soft_1"), Vol(ActiveBall) * BallBouncePlayfieldSoftFactor
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Soft_2"), Vol(ActiveBall) * BallBouncePlayfieldSoftFactor * 0.5
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Soft_3"), Vol(ActiveBall) * BallBouncePlayfieldSoftFactor * 0.8
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Soft_4"), Vol(ActiveBall) * BallBouncePlayfieldSoftFactor * 0.5
		Case 5 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Soft_5"), Vol(ActiveBall) * BallBouncePlayfieldSoftFactor
		Case 6 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_1"), Vol(ActiveBall) * BallBouncePlayfieldSoftFactor * 0.2
		Case 7 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_2"), Vol(ActiveBall) * BallBouncePlayfieldSoftFactor * 0.2
		Case 8 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_5"), Vol(ActiveBall) * BallBouncePlayfieldSoftFactor * 0.2
		Case 9 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_7"), Vol(ActiveBall) * BallBouncePlayfieldSoftFactor * 0.3
	End Select
End Sub

Sub RandomSoundBallBouncePlayfieldHard()
	Select Case Int(Rnd*7)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_1"), Vol(ActiveBall) * BallBouncePlayfieldHardFactor
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_2"), Vol(ActiveBall) * BallBouncePlayfieldHardFactor
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_3"), Vol(ActiveBall) * BallBouncePlayfieldHardFactor
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_4"), Vol(ActiveBall) * BallBouncePlayfieldHardFactor
		Case 5 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_5"), Vol(ActiveBall) * BallBouncePlayfieldHardFactor
		Case 6 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_6"), Vol(ActiveBall) * BallBouncePlayfieldHardFactor
		Case 7 : PlaySoundAtLevelActiveBall ("TOM_Ball_Bounce_Playfield_Hard_7"), Vol(ActiveBall) * BallBouncePlayfieldHardFactor
	End Select
End Sub

'/////////////////////////////  RAMPS BALL DROP TO PLAYFIELD SOUNDS  ////////////////////////////
'/////////////////////////////  PLASTIC LEFT RAMP - EXIT HOLE - TO PLAYFIELD - SOUNDS  ////////////////////////////
Sub RandomSoundLeftRampDropToPlayfield()
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Left_Ramp_1"), LeftRampDropToPlayfieldSoundLevel, RHelp1
		Case 2 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Left_Ramp_2"), LeftRampDropToPlayfieldSoundLevel, RHelp1
		Case 3 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Left_Ramp_3"), LeftRampDropToPlayfieldSoundLevel, RHelp1
		Case 4 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Left_Ramp_4"), LeftRampDropToPlayfieldSoundLevel, RHelp1
		Case 5 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Left_Ramp_5"), LeftRampDropToPlayfieldSoundLevel, RHelp1
	End Select
End Sub

'/////////////////////////////  WIRE RIGHT OUTER LOOP RAMP - EXIT HOLE - TO PLAYFIELD - SOUND  ////////////////////////////
Sub RandomSoundRightRampDropToPlayfield()
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Right_Ramp_1"), RightRampDropToPlayfieldSoundLevel, RHelp2
		Case 2 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Right_Ramp_3"), RightRampDropToPlayfieldSoundLevel, RHelp2
		Case 3 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Right_Ramp_4"), RightRampDropToPlayfieldSoundLevel, RHelp2
		Case 4 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Right_Ramp_5"), RightRampDropToPlayfieldSoundLevel, RHelp2
		Case 5 : PlaySoundAtLevelStatic ("TOM_Ball_Drop_From_Right_Ramp_6"), RightRampDropToPlayfieldSoundLevel, RHelp2
	End Select
End Sub

'/////////////////////////////  TRAPDOOR  - TO PLAYFIELD - SOUND  ////////////////////////////
Sub RandomSoundTrapdoorBallDropOnPlayfield()
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_1_Delayed"), TrapdoorBallDropOnPlayfieldSoundLevel, TrapdoorBallDropPosition
		Case 2 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_2_Delayed"), TrapdoorBallDropOnPlayfieldSoundLevel, TrapdoorBallDropPosition
		Case 3 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_3_Delayed"), TrapdoorBallDropOnPlayfieldSoundLevel, TrapdoorBallDropPosition
		Case 4 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_4_Delayed"), TrapdoorBallDropOnPlayfieldSoundLevel, TrapdoorBallDropPosition
		Case 5 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_5_Delayed"), TrapdoorBallDropOnPlayfieldSoundLevel, TrapdoorBallDropPosition
	End Select
End Sub


'/////////////////////////////  PLASTIC RAMPS FLAPS  ////////////////////////////
Dim Ramp1HitFlag : Ramp1HitFlag = 0
Dim Ramp2HitFlag : Ramp2HitFlag = 0
'/////////////////////////////  PLASTIC RAMPS FLAPS - EVENTS  ////////////////////////////
Sub RamppHelper1_Hit()
	If (ActiveBall.VelY > 0 & Ramp1HitFlag = 0) Then 
		'ball is traveling down the playfield
		RandomSoundRampFlapDown()
		Ramp1HitFlag = 1
	ElseIf (ActiveBall.VelY < 0 & Ramp1HitFlag = 0) Then
		'ball is traveling up the playfield
		RandomSoundRampFlapUp()
		Ramp1HitFlag = 1	
	End If
End Sub

Sub RamppHelper1_UnHit()
	If ActiveBall.VelY > 0 Then
		'ball does not make it up the ramp and it rolls back down
		Ramp1HitFlag = 0
	End If
End Sub

Sub RamppHelper2_Hit()
	If (ActiveBall.VelY > 0 & Ramp2HitFlag = 0) Then 
		'ball is traveling down the playfield
		RandomSoundRampFlapDown()
		Ramp2HitFlag = 1
	ElseIf (ActiveBall.VelY < 0 & Ramp2HitFlag = 0) Then
		RandomSoundRampFlapUp()
		Ramp2HitFlag = 1
	End If
End Sub

Sub RamppHelper2_UnHit()
	If ActiveBall.VelY > 0 Then
		'ball does not make it up the ramp and it rolls back down
		Ramp2HitFlag = 0
	End If
End Sub
'/////////////////////////////  PLASTIC RAMPS FLAPS - SOUNDS  ////////////////////////////
Sub RandomSoundRampFlapUp()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Ramp_Flap_Up_1"), FlapSoundLevel
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Ramp_Flap_Up_2"), FlapSoundLevel
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Ramp_Flap_Up_3"), FlapSoundLevel
	End Select
End Sub

Sub RandomSoundRampFlapDown()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Ramp_Flap_Down_1"), FlapSoundLevel
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Ramp_Flap_Down_2"), FlapSoundLevel
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Ramp_Flap_Down_3"), FlapSoundLevel
	End Select
End Sub


'/////////////////////////////  SHOOTER RAMP - THEATRE ENTRANCE FLAP - SOUNDS  ////////////////////////////
Sub SoundSkillTheatreEntranceFlapUpEnter()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
		PlaySoundAtLevelStatic ("TOM_SkillTheatreEntrancePlasticEnter_2"), SkillTheatreEntranceFlapUpSoundLevel, RampFlap1
	Else
		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelStatic ("TOM_Shooter_Lane_Flap_FallBack_FlapExit_1"), SkillTheatreEntranceFlapUpSoundLevel, RampFlap1
			Case 2 : PlaySoundAtLevelStatic ("TOM_Shooter_Lane_Flap_FallBack_FlapExit_2"), SkillTheatreEntranceFlapUpSoundLevel, RampFlap1
		End Select
 	End If	
End Sub

Sub SoundSkillTheatreEntranceFlapUpExit()
	Select Case Int(Rnd*2)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Shooter_Lane_Flap_FallBack_FlapEnter_1"), SkillTheatreEntranceFlapUpSoundLevel, RampFlap1
		Case 2 : PlaySoundAtLevelStatic ("TOM_Shooter_Lane_Flap_FallBack_FlapEnter_2"), SkillTheatreEntranceFlapUpSoundLevel, RampFlap1
	End Select
End Sub

Sub SoundSkillTheatreEntranceFlapDownEnter()
	Select Case Int(Rnd*2)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Shooter_Lane_Flap_FallBack_FlapEnter_1"), SkillTheatreEntranceFlapDownSoundLevel, RampFlap1
		Case 2 : PlaySoundAtLevelStatic ("TOM_Shooter_Lane_Flap_FallBack_FlapEnter_2"), SkillTheatreEntranceFlapDownSoundLevel, RampFlap1
	End Select
End Sub

Sub SoundSkillTheatreEntranceFlapDownExit()
	Select Case Int(Rnd*2)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Shooter_Lane_Flap_FallBack_FlapExit_1"), SkillTheatreEntranceFlapDownSoundLevel, RampFlap1
		Case 2 : PlaySoundAtLevelStatic ("TOM_Shooter_Lane_Flap_FallBack_FlapExit_2"), SkillTheatreEntranceFlapDownSoundLevel, RampFlap1
	End Select
End Sub

Sub SoundSkillTheatreEntranceRampRollUp()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
		PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceMetalRamp"), SkillTheatreEntranceMetalRampSoundLevel, RHelp14
	End If
End Sub


'/////////////////////////////  SHOOTER RAMP - THEATRE ENTRANCE - EXIT HOLE - TO WIRE RIGHT OUTER LOOP RAMP - SOUNDS  ////////////////////////////
Sub RandomSoundSkillTheatreEntranceToRightOuterLoopRampDrop()
	Select Case Int(Rnd*10)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_1"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4
		Case 2 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_2"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4
		Case 3 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_3"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4	
		Case 4 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_4"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4
		Case 5 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_5"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4
		Case 6 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_6"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4
		Case 7 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_7"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4
		Case 8 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_8"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4
		Case 9 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_9"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4
		Case 10 : PlaySoundAtLevelStatic ("TOM_SkillTheatreEntranceToRightOuterLoopRampDrop_10"), SkillTheatreEntranceToRightOuterLoopRampDropSoundLevel, RHelp4
	End Select
End Sub

'/////////////////////////////  WIRE RIGHT OUTER LOOP SOUND AFTER BALL DROP FROM THEATRE ENTRANCE  ////////////////////////////
Sub SoundRightOuterLoopRampAfterDropFromSkillTheatreEntrance(toggle, ballvariableWireRampTimer2)
	Select Case toggle
		Case SoundOn
			WireRampTimer2.Interval = 10
			WireRampTimer2.Enabled = 1
		Case SoundOff
			StopSound "TOM_RightOuterLoopRampAfterDropFromSkillTheatreEntrance"
	End Select
End Sub


'/////////////////////////////  DRAIN SOUNDS  ////////////////////////////
Sub RandomSoundDrain()
	Select Case Int(Rnd*11)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Drain_1"), DrainSoundLevel, OutHole
		Case 2 : PlaySoundAtLevelStatic ("TOM_Drain_2"), DrainSoundLevel, OutHole
		Case 3 : PlaySoundAtLevelStatic ("TOM_Drain_3"), DrainSoundLevel, OutHole
		Case 4 : PlaySoundAtLevelStatic ("TOM_Drain_4"), DrainSoundLevel, OutHole
		Case 5 : PlaySoundAtLevelStatic ("TOM_Drain_5"), DrainSoundLevel, OutHole
		Case 6 : PlaySoundAtLevelStatic ("TOM_Drain_6"), DrainSoundLevel, OutHole
		Case 7 : PlaySoundAtLevelStatic ("TOM_Drain_7"), DrainSoundLevel, OutHole
		Case 8 : PlaySoundAtLevelStatic ("TOM_Drain_8"), DrainSoundLevel, OutHole
		Case 9 : PlaySoundAtLevelStatic ("TOM_Drain_9"), DrainSoundLevel, OutHole
		Case 10 : PlaySoundAtLevelStatic ("TOM_Drain_10"), DrainSoundLevel, OutHole
		Case 11 : PlaySoundAtLevelStatic ("TOM_Drain_10"), DrainSoundLevel, OutHole
	End Select
End Sub


'/////////////////////////////  TROUGH BALL RELEASE SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundBallRelease()
	Select Case Int(Rnd*7)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Trough_To_Shooter_Solenoid_1",DOFContactors), BallReleaseSoundLevel, sw32
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Trough_To_Shooter_Solenoid_2",DOFContactors), BallReleaseSoundLevel, sw32
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Trough_To_Shooter_Solenoid_3",DOFContactors), BallReleaseSoundLevel, sw32
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Trough_To_Shooter_Solenoid_4",DOFContactors), BallReleaseSoundLevel, sw32
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Trough_To_Shooter_Solenoid_5",DOFContactors), BallReleaseSoundLevel, sw32
		Case 6 : PlaySoundAtLevelStatic SoundFX("TOM_Trough_To_Shooter_Solenoid_6",DOFContactors), BallReleaseSoundLevel, sw32
		Case 7 : PlaySoundAtLevelStatic SoundFX("TOM_Trough_To_Shooter_Solenoid_7",DOFContactors), BallReleaseSoundLevel, sw32
	End Select
End Sub

'/////////////////////////////  SHOOTER LANE - BALL RELEASE ROLL IN SHOOTER LANE SOUND - SOUND  ////////////////////////////
Sub SoundBallReleaseShooterLane(toggle)
	Select Case toggle
		Case SoundOn
			PlaySoundAtLevelActiveBall ("WD_Ball_Launched_From_Shooter_Lane_3"), BallReleaseShooterLaneSoundLevel
		Case SoundOff
			StopSound "WD_Ball_Launched_From_Shooter_Lane_3"
	End Select
End Sub

'/////////////////////////////  DISAPPEARING POSTS  ////////////////////////////
'/////////////////////////////  DISAPPEARING POSTS - LOOP POST - SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundLoopPostSolenoid(toggle)
	Select Case toggle
		Case Up
			Select Case Int(Rnd*2)+1
				Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_LoopPost_UP_3",DOFContactors), 0.75 * LoopPostSolenoidSoundFactor, LoopPostPlacement
				Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_LoopPost_UP_4",DOFContactors), 0.75 * LoopPostSolenoidSoundFactor, LoopPostPlacement
			End Select
		Case Down
			Select Case Int(Rnd*2)+1
				Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_LoopPost_DOWN_3",DOFContactors), 0.9 * LoopPostSolenoidSoundFactor, LoopPostPlacement
				Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_LoopPost_DOWN_4",DOFContactors), 0.9 * LoopPostSolenoidSoundFactor, LoopPostPlacement
			End Select
	End Select
End Sub
'/////////////////////////////  DISAPPEARING POSTS - LOOP POST - MAGNET SOUNDS  ////////////////////////////
Sub SoundLoopPostMagnet(toggle)
	Select Case toggle	
		Case SoundOn
			PlaySoundAtLevelStaticLoop SoundFX("TOM_Vanish_Post_Magnet_Humm_Loop_2",DOFShaker), LoopPostMagnetSoundLevel, LoopPostPlacement
		Case SoundOff
			StopSound "TOM_Vanish_Post_Magnet_Humm_Loop_2"
	End Select
End Sub

'/////////////////////////////  DISAPPEARING POSTS - VANISH DIVERTER POST - SOLENOID SOUNDS  ////////////////////////////
Sub SoundDiverterPostSolenoid(toggle)
	Select Case toggle
		Case Up
			PlaySoundAtLevelStatic SoundFX("TOM_Diverter_UP_2",DOFContactors), DiverterPostSolenoidSoundLevel, DivPostPlacement
		Case Down
			PlaySoundAtLevelStatic SoundFX("TOM_Diverter_DOWN_2",DOFContactors), DiverterPostSolenoidSoundLevel, DivPostPlacement
	End Select
End Sub
'/////////////////////////////  DISAPPEARING POSTS - VANISH DIVERTER POST - MAGNET SOUNDS  ////////////////////////////
Sub SoundDiverterPostMagnet(toggle)
	Select Case toggle
		Case SoundOn
			PlaySoundAtLevelStaticLoop SoundFX("TOM_Vanish_Post_Magnet_Humm_Loop_2",DOFShaker), DiverterPostMagnetSoundLevel, DivPostPlacement
		Case SoundOff
			StopSound "TOM_Vanish_Post_Magnet_Humm_Loop_2"
	End Select
End Sub

'/////////////////////////////  DISAPPEARING POSTS - CENTER POST - SOLENOID SOUNDS  ////////////////////////////
Sub SoundCenterPostSolenoid(toggle)
	Select Case toggle
		Case Up
			PlaySoundAtLevelStatic SoundFX("TOM_Diverter_UP_2",DOFContactors), CenterPostSolenoidSoundLevel, CenterPostP
		Case Down
			PlaySoundAtLevelStatic SoundFX("TOM_Diverter_DOWN_2",DOFContactors), CenterPostSolenoidSoundLevel, CenterPostP
	End Select
End Sub

'/////////////////////////////  KNOCKER SOLENOID  ////////////////////////////
Sub KnockerSolenoid()
	PlaySoundAtLevelStatic SoundFX("TOM_Knocker_5",DOFKnocker), KnockerSoundLevel, KnockerPosition
End Sub

'/////////////////////////////  VANISH MECHANISM  ////////////////////////////
'/////////////////////////////  VANISH MECHANISM - LOCKING SOUNDS  ////////////////////////////
Sub SoundVanishSolenoidLock(toggle)
	Select Case toggle
		Case Vanish_sw83
			PlaySoundAtLevelStatic ("TOM_Vanish_Lock_Ball_Enter_sw83"), VanishSolenoidLockSoundLevel, sw83
		Case Vanish_sw84
			PlaySoundAtLevelStatic ("TOM_Vanish_Lock_Ball_Enter_sw84"), 0.3 * VanishSolenoidLockSoundLevel, sw84
	End Select
End Sub

'/////////////////////////////  VANISH MECHANISM - KICKOUT SOLENOID SOUNDS  ////////////////////////////
Sub SoundVanishSolenoidKickout(scenario)
	Select Case scenario
		Case NoBallLocked
			PlaySoundAtLevelStatic SoundFX("TOM_Vanish_Kickout_0_Balls_Locked",DOFContactors), VanishSolenoidKickoutSoundLevel, sw83
		Case OneBallLocked
			PlaySoundAtLevelStatic SoundFX("TOM_Vanish_Kickout_1_Balls_Locked",DOFContactors), VanishSolenoidKickoutSoundLevel, sw83
		Case TwoBallsLocked
			PlaySoundAtLevelStatic SoundFX("TOM_Vanish_Kickout_2_Balls_Locked",DOFContactors), VanishSolenoidKickoutSoundLevel, sw83
	End Select
End Sub

'/////////////////////////////  VANISH MECHANISM - BALL DROP TO PLAYFIELD - SOUND  ////////////////////////////
Sub RandomSoundVanishKickoutBallDropOnPlayfield()
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_1_Delayed"), VanishKickoutBallDropOnPlayfieldSoundLevel, sw86
		Case 2 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_2_Delayed"), VanishKickoutBallDropOnPlayfieldSoundLevel, sw86
		Case 3 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_3_Delayed"), VanishKickoutBallDropOnPlayfieldSoundLevel, sw86
		Case 4 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_4_Delayed"), VanishKickoutBallDropOnPlayfieldSoundLevel, sw86
		Case 5 : PlaySoundAtLevelStatic ("TOM_Trapdoor_Ball_Drop_Playfield_5_Delayed"), VanishKickoutBallDropOnPlayfieldSoundLevel, sw86
	End Select
End Sub


'/////////////////////////////  SLINGSHOT SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundSlingshotLeft()
	Select Case Int(Rnd*10)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L1_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L2_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L3_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L4_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L5_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
		Case 6 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L6_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
		Case 7 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L7_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
		Case 8 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L8_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
		Case 9 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L9_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
		Case 10 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_L10_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING2
	End Select
End Sub

Sub RandomSoundSlingshotRight()
	Select Case Int(Rnd*8)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_R1_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING1
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_R2_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING1
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_R3_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING1
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_R4_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING1
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_R5_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING1
		Case 6 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_R6_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING1
		Case 7 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_R7_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING1
		Case 8 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Sling_Rework_R9_Strong_Layered",DOFContactors), SlingshotSoundLevel, SLING1
	End Select
End Sub


'/////////////////////////////  BUMPER SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundBumperA()
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Top_1",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper1
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Top_2",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper1
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Top_3",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper1
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Top_4",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper1
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Top_5",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper1
	End Select
End Sub

Sub RandomSoundBumperB()
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Middle_1",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper2
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Middle_2",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper2
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Middle_3",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper2
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Middle_4",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper2
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Middle_5",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper2
	End Select
End Sub

Sub RandomSoundBumperC()
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Bottom_1",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper3
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Bottom_2",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper3
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Bottom_3",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper3
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Bottom_4",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper3
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Bumpers_Reworked_v2_Bottom_5",DOFContactors), Vol(ActiveBall) * BumperSoundFactor, Bumper3
	End Select
End Sub


'/////////////////////////////  FLIPPER BATS SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  FLIPPER BATS SOLENOID ATTACK SOUND  ////////////////////////////
Sub SoundFlipperUpAttackLeft()
	FlipperUpAttackLeftSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
	PlaySoundAtLevelStatic ("TOM_Calle_Flipper_Attack-L01"), FlipperUpAttackLeftSoundLevel, LeftFlipper
End Sub

Sub SoundFlipperUpAttackRight()
	FlipperUpAttackRightSoundLevel = RndNum(FlipperUpAttackMinimumSoundLevel, FlipperUpAttackMaximumSoundLevel)
		PlaySoundAtLevelStatic ("TOM_Calle_Flipper_Attack-R01"), FlipperUpAttackLeftSoundLevel, RightFlipper
End Sub

'/////////////////////////////  FLIPPER BATS SOLENOID CORE SOUND  ////////////////////////////
Sub RandomSoundFlipperUpLeft()
	Select Case Int(Rnd*11)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L01",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L02",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L07",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L08",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L09",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 6 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L10",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 7 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L12",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 8 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L14",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 9 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L18",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 10 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L20",DOFFlippers), FlipperLeftHitParm, LeftFlipper
		Case 11 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_L26",DOFFlippers), FlipperLeftHitParm, LeftFlipper
	End Select
End Sub

Sub RandomSoundFlipperUpRight()
	Select Case Int(Rnd*11)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R01",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R02",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R03",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R04",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R05",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 6 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R06",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 7 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R07",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 8 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R08",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 9 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R09",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 10 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R10",DOFFlippers), FlipperRightHitParm, RightFlipper
		Case 11 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Flipper_R11",DOFFlippers), FlipperRightHitParm, RightFlipper
	End Select
End Sub

Sub RandomSoundReflipUpLeft()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_ReFlip_L01",DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, LeftFlipper
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_ReFlip_L02",DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, LeftFlipper
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_ReFlip_L03",DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, LeftFlipper
	End Select
End Sub

Sub RandomSoundReflipUpRight()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_ReFlip_R01",DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, RightFlipper
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_ReFlip_R02",DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, RightFlipper
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_ReFlip_R03",DOFFlippers), (RndNum(0.8, 1))*FlipperUpSoundLevel, RightFlipper
	End Select
End Sub

Sub RandomSoundFlipperDownLeft()
	Select Case Int(Rnd*7)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Left_Down_1_Bass",DOFFlippers), FlipperDownSoundLevel, LeftFlipper
		Case 2 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Left_Down_2_Bass",DOFFlippers), FlipperDownSoundLevel, LeftFlipper
		Case 3 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Left_Down_3_Bass",DOFFlippers), FlipperDownSoundLevel, LeftFlipper
		Case 4 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Left_Down_4_Bass",DOFFlippers), FlipperDownSoundLevel, LeftFlipper
		Case 5 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Left_Down_5_Bass",DOFFlippers), FlipperDownSoundLevel, LeftFlipper
		Case 6 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Left_Down_6_Bass",DOFFlippers), FlipperDownSoundLevel, LeftFlipper
		Case 7 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Left_Down_7_Bass",DOFFlippers), FlipperDownSoundLevel, LeftFlipper
	End Select
End Sub

Sub RandomSoundFlipperDownRight()
	Select Case Int(Rnd*8)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Right_Down_1_Bass",DOFFlippers), FlipperDownSoundLevel, RightFlipper
		Case 2 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Right_Down_2_Bass",DOFFlippers), FlipperDownSoundLevel, RightFlipper
		Case 3 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Right_Down_3_Bass",DOFFlippers), FlipperDownSoundLevel, RightFlipper
		Case 4 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Right_Down_4_Bass",DOFFlippers), FlipperDownSoundLevel, RightFlipper
		Case 5 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Right_Down_5_Bass",DOFFlippers), FlipperDownSoundLevel, RightFlipper
		Case 6 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Right_Down_6_Bass",DOFFlippers), FlipperDownSoundLevel, RightFlipper
		Case 7 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Right_Down_7_Bass",DOFFlippers), FlipperDownSoundLevel, RightFlipper
		Case 8 : PlaySoundAtLevelStatic SoundFX("WD_TOM_Flipper_Right_Down_8_Bass",DOFFlippers), FlipperDownSoundLevel, RightFlipper
	End Select
End Sub

'/////////////////////////////  FLIPPER BATS BALL COLLIDE SOUND  ////////////////////////////

Sub LeftFlipperCollide(parm)
	FlipperLeftHitParm = parm/10
	If FlipperLeftHitParm > 1 Then
		FlipperLeftHitParm = 1
	End If
	FlipperLeftHitParm = FlipperUpSoundLevel * FlipperLeftHitParm
	RandomSoundRubberFlipper(parm)
End Sub

Sub RightFlipperCollide(parm)
	FlipperRightHitParm = parm/10
	If FlipperRightHitParm > 1 Then
		FlipperRightHitParm = 1
	End If
	FlipperRightHitParm = FlipperUpSoundLevel * FlipperRightHitParm
 	RandomSoundRubberFlipper(parm)
End Sub

Sub RandomSoundRubberFlipper(parm)
	Select Case Int(Rnd*7)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Normal_1"), parm / 10 * RubberFlipperSoundFactor
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Normal_2"), parm / 10 * RubberFlipperSoundFactor
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Normal_3"), parm / 10 * RubberFlipperSoundFactor
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Normal_4"), parm / 10 * RubberFlipperSoundFactor
		Case 5 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Normal_5"), parm / 10 * RubberFlipperSoundFactor
		Case 6 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Normal_6"), parm / 10 * RubberFlipperSoundFactor
		Case 7 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Normal_7"), parm / 10 * RubberFlipperSoundFactor
	End Select
End Sub


'/////////////////////////////  PLASTIC LEFT RAMP (CENTER STAIRCASE) SOUND EVENTS  ////////////////////////////
'/////////////////////////////  PLASTIC LEFT RAMP (CENTER STAIRCASE) ENTRANCE  ////////////////////////////
Sub LRHitEnter_Hit()
		If ActiveBall.VelY < 0 Then PlaySoundAtLevelActiveBall ("TOM_LeftRamp_Enter2"), LeftRampSoundLevel
		If ActiveBall.VelY > 0 Then PlaySoundAtLevelActiveBall ("TOM_Ramp_Fallback_1"), RampFallbackSoundLevel
End Sub

Sub LRHit8_Hit()
		If ActiveBall.VelY > 0 Then PlaySoundAtLevelActiveBall ("TOM_Ramp_Fallback_3"), RampFallbackSoundLevel
End Sub
'/////////////////////////////  PLASTIC LEFT RAMP (CENTER STAIRCASE) HIT TRIGGERS  ////////////////////////////
Sub LRHit1_Hit()
	LRHit1_volume = LeftRampSoundLevel
	PlaySoundAtLevelStatic ("TOM_C_Ramp_1_Improved2"), LRHit1_volume, LRHit1
End Sub 

Sub LRHit2_Hit()
	LRHit2_volume = LeftRampSoundLevel
	LRHit1.TimerInterval = 5
	LRHit1.TimerEnabled = 1
	PlaySoundAtLevelStatic ("TOM_C_Ramp_2_Improved2"), LRHit2_volume, LRHit2
End Sub

Sub LRHit3_Hit()
	LRHit3_volume = LeftRampSoundLevel
	LRHit2.TimerInterval = 5
	LRHit2.TimerEnabled = 1
	PlaySoundAtLevelStatic ("TOM_C_Ramp_3_Improved2"), LRHit3_volume, LRHit3
End Sub

Sub LRHit4_Hit()
	LRHit4_volume = LeftRampSoundLevel
	LRHit3.TimerInterval = 5
	LRHit3.TimerEnabled = 1
	PlaySoundAtLevelStatic ("TOM_C_Ramp_4_Improved2"), LRHit4_volume, LRHit4
End Sub

Sub LRHit5_Hit()
	LRHit5_volume = LeftRampSoundLevel
	LRHit4.TimerInterval = 5
	LRHit4.TimerEnabled = 1
	PlaySoundAtLevelStatic ("TOM_C_Ramp_5_Improved2"), LRHit5_volume, LRHit5
End Sub

Sub LRHit6_Hit()
	LRHit6_volume = LeftRampSoundLevel
	LRHit5.TimerInterval = 5
	LRHit5.TimerEnabled = 1
	PlaySoundAtLevelStatic ("TOM_C_Ramp_6_Improved2"), LRHit6_volume, LRHit6
End Sub

Sub LRHit7_Hit()
	LRHit7_volume = LeftRampSoundLevel
	LRHit6.TimerInterval = 5
	LRHit6.TimerEnabled = 1
	PlaySoundAtLevelStatic ("TOM_C_Ramp_7_Improved2"), LRHit7_volume, LRHit7
End Sub

Sub sw75_Hit()
	If ActiveBall.VelY > 0 Then PlaySoundAtLevelActiveBall ("TOM_Ramp_Fallback_2"), RampFallbackSoundLevel
End Sub


'/////////////////////////////  PLASTIC LEFT RAMP (CENTER STAIRCASE) SOUND TIMERS  ////////////////////////////
Sub LRHit1_Timer()
	If LRHit1_volume > 0 Then
		LRHit1_volume = LRHit1_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_C_Ramp_1_Improved2"), LRHit1_volume, LRHit1
	Else
		Me.TimerEnabled = 0
	End If
End Sub

Sub LRHit2_Timer()
	If LRHit2_volume > 0 Then
		LRHit2_volume = LRHit2_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_C_Ramp_2_Improved2"), LRHit2_volume, LRHit2
	Else
		Me.TimerEnabled = 0
	End If
End Sub

Sub LRHit3_Timer()
	If LRHit3_volume > 0 Then
		LRHit3_volume = LRHit3_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_C_Ramp_3_Improved2"), LRHit3_volume, LRHit3
	Else
		Me.TimerEnabled = 0
	End If
End Sub

Sub LRHit4_Timer()
	If LRHit4_volume > 0 Then
		LRHit4_volume = LRHit4_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_C_Ramp_4_Improved2"), LRHit4_volume, LRHit4
	Else
		Me.TimerEnabled = 0
	End If
End Sub

Sub LRHit5_Timer()
	If LRHit5_volume > 0 Then
		LRHit5_volume = LRHit5_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_C_Ramp_5_Improved2"), LRHit5_volume, LRHit5
	Else
		Me.TimerEnabled = 0
	End If
End Sub

Sub LRHit6_Timer()
	If LRHit6_volume > 0 Then
		LRHit6_volume = LRHit6_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_C_Ramp_6_Improved2"), LRHit6_volume, LRHit6
	Else
		Me.TimerEnabled = 0
	End If
End Sub

Sub LRHit7_Timer()
	If LRHit7_volume > 0 Then
		LRHit7_volume = LRHit7_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_C_Ramp_7_Improved2"), LRHit7_volume, LRHit7
	Else
		Me.TimerEnabled = 0
	End If
End Sub


'/////////////////////////////  PLASTIC RIGHT RAMP (RIGHT STAIRCASE) SOUND EVENTS  ////////////////////////////
'/////////////////////////////  PLASTIC RIGHT RAMP (RIGHT STAIRCASE) ENTRANCE  ////////////////////////////
Sub RRHitEnter_Hit()
		If ActiveBall.VelY < 0 Then PlaySoundAtLevelActiveBall ("TOM_R_Ramp_1"), RightRampSoundLevel
End Sub

Sub RRHit5_Hit()
		If ActiveBall.VelY > 0 Then PlaySoundAtLevelActiveBall ("TOM_Ramp_Fallback_3"), RampFallbackSoundLevel
End Sub
'/////////////////////////////  PLASTIC RIGHT RAMP (RIGHT STAIRCASE) HIT TRIGGERS  ////////////////////////////
Sub RRHit1_Hit()
	RRHit1_volume = RightRampSoundLevel
	PlaySoundAtLevelStatic ("TOM_R_Ramp_2"), RRHit1_volume, RRHit1
End Sub 

Sub RRHit2_Hit()
	RRHit2_volume = RightRampSoundLevel
	RRHit1.TimerInterval = 5
	RRHit1.TimerEnabled = 1
	PlaySoundAtLevelStatic ("TOM_R_Ramp_3"), RRHit2_volume, RRHit2
End Sub

Sub RRHit3_Hit()
	RRHit3_volume = RightRampSoundLevel
	RRHit2.TimerInterval = 5
	RRHit2.TimerEnabled = 1
	PlaySoundAtLevelStatic ("TOM_R_Ramp_4"), RRHit3_volume, RRHit3
End Sub

Sub RRHit4_Hit()
	If ActiveBall.VelY > 0 Then PlaySoundAtLevelStatic ("TOM_Ramp_Fallback_2"), RampFallbackSoundLevel, RRHit4
End Sub

Sub RRHit7_Hit()
	If ActiveBall.VelY > 0 Then PlaySoundAtLevelStatic ("TOM_Ramp_Fallback_1"), RampFallbackSoundLevel, RRHit7
End Sub

Sub sw76_Hit()
	If ActiveBall.VelY > 0 Then PlaySoundAtLevelStatic ("TOM_Ramp_Fallback_2"), RampFallbackSoundLevel, sw76
End Sub

Sub RRHit6_Hit()
	If Gate4Enabled Then 
		If ActiveBall.VelY >= 0 Then
			Select Case Int(Rnd*3)+1
				Case 1 : PlaySoundAtLevelStatic ("TOM_Ramp_Fallback_InitialStopHit_1"), RampFallbackSoundLevel, RRHit6
				Case 2 : PlaySoundAtLevelStatic ("TOM_Ramp_Fallback_InitialStopHit_2"), RampFallbackSoundLevel, RRHit6
				Case 3 : PlaySoundAtLevelStatic ("TOM_Ramp_Fallback_InitialStopHit_3"), RampFallbackSoundLevel, RRHit6
			End Select
		End If
	Gate4Enabled = 0
	End If
End Sub

'/////////////////////////////  PLASTIC RIGHT RAMP (RIGHT STAIRCASE) SOUND TIMERS  ////////////////////////////
Sub RRHit1_Timer()
	If RRHit1_volume > 0 Then
		RRHit1_volume = RRHit1_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_R_Ramp_2"), RRHit1_volume, RRHit1
	Else
		Me.TimerEnabled = 0
	End If
End Sub

Sub RRHit2_Timer()
	If RRHit2_volume > 0 Then
		RRHit2_volume = RRHit2_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_R_Ramp_3"), RRHit2_volume, RRHit2
	Else
		Me.TimerEnabled = 0
	End If
End Sub

Sub RRHit3_Timer()
	If RRHit3_volume > 0 Then
		RRHit3_volume = RRHit3_volume - 0.05
		PlaySoundAtLevelExistingStatic ("TOM_R_Ramp_4"), RRHit3_volume, RRHit3
	Else
		Me.TimerEnabled = 0
	End If
End Sub

'/////////////////////////////  PLASTIC RIGHT RAMP (RIGHT STAIRCASE) DIVERTS  ////////////////////////////
Sub SoundPlasticRightRamp(scenario)
	Select Case scenario
		Case SoundOn
			'Currently not implemented. Maybe in the future

		Case SoundOff
			'Currently not implemented. Maybe in the future

		Case SoundOff_SpiritRing
			RRHit4_volume = RightRampSoundLevel
			RRHit3.TimerInterval = 5
			RRHit3.TimerEnabled = 1
	End Select
End Sub

'/////////////////////////////  PLASTIC RIGHT RAMP (RIGHT STAIRCASE) - EXIT HOLE - BALL FALLS TO THE RIGHT INLANE BEHIND SPINNER ON PLAYFIELD - SOUNDS   ////////////////////////////
Sub RandomSoundBallDropFromRampBehindSpinner()
	Select Case Int(Rnd*2)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Ball_Bounce_Playfield_From_Right_Staircase_1"), BallDropFromRampBehindSpinnerSoundLevel, RHelp5
		Case 2 : PlaySoundAtLevelStatic ("TOM_Ball_Bounce_Playfield_From_Right_Staircase_2"), BallDropFromRampBehindSpinnerSoundLevel, RHelp5
	End Select
End Sub


'/////////////////////////////  SPIRIT RING SOUNDS  ////////////////////////////
Sub SoundSpiritRingSolenoidCapture()
	PlaySoundAtLevelStatic SoundFX("TOM_NK_SpiritRing_Capture",DOFShaker), SpiritRingSolenoidCaptureSoundLevel, SpiritMagnet
End Sub


Sub SoundSpiritRingMagnet(toggle)
	Select Case toggle
		Case SoundOn
			PlaySoundAtLevelStatic SoundFX("TOM_SpiritRing_Magnet_Start",DOFShaker), SpiritRingMagnetSoundLevel, SpiritMagnet
			PlaySoundAtLevelStaticLoop SoundFX("TOM_SpiritRing_Magnet_Loop",DOFShaker), SpiritRingMagnetSoundLevel, SpiritMagnet
		Case SoundOff
			StopSound "TOM_SpiritRing_Magnet_Loop"
	End Select
End Sub

'/////////////////////////////  SPIRIT RING RELEASE BALL TO PLASTIC RIGHT RAMP  ////////////////////////////
Sub SoundPlasticRightRampBallDropFromSpiritRing()
	PlaySoundAtLevelStatic ("TOM_NK_SpiritRing_Release_3"), PlasticRightRampBallDropFromSpiritRingSoundLevel, SpiritMagnet
End Sub

'/////////////////////////////  WIRE CROSSOVER CATWALK RAMP SOUNDS  ////////////////////////////
'/////////////////////////////  PLASTIC LEFT RAMP (CENTER STAIRCASE) TO WIRE CROSSOEVER CATWALK BALL DIVERT ENTRANCE - SOUND  ////////////////////////////
Sub SoundWireRampCatwalk(toggle)
	Select Case toggle
		Case SoundOn
			WireRampTimer4.Interval = 10
			WireRampTimer4.Enabled = 1
		Case SoundOff
			WireRampTimer4.Enabled = 0
			StopSound "TOM_Catwalk_Ramp_3"
	End Select
End Sub

'/////////////////////////////  WIRE RAMPS  ////////////////////////////
'/////////////////////////////  WIRE CROSSOEVER CATWALK RAMP TO WIRE RIGHT RAMP OUTER LOOP BALL DROP  ////////////////////////////
Sub RandomSoundDropFromCatwalkRampToRamp()
	Select Case Int(Rnd*4)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_DropFromCatwalkRampToRamp_1"), BallDropFromCatwalkRampToRampSoundLevel, RHelp3
		Case 2 : PlaySoundAtLevelStatic ("TOM_DropFromCatwalkRampToRamp_2"), BallDropFromCatwalkRampToRampSoundLevel, RHelp3
		Case 3 : PlaySoundAtLevelStatic ("TOM_DropFromCatwalkRampToRamp_3"), BallDropFromCatwalkRampToRampSoundLevel, RHelp3
		Case 4 : PlaySoundAtLevelStatic ("TOM_DropFromCatwalkRampToRamp_4"), BallDropFromCatwalkRampToRampSoundLevel, RHelp3
	End Select
End Sub

'/////////////////////////////  WIRE CROSSOEVER CATWALK RAMP - EXIT HOLE - TO WIRE RIGHT OUTER LOOP RAMP - SOUND  ////////////////////////////
Sub SoundRightOuterLoopRampAfterDropFromCatwalk(toggle, ballvariableWireRampTimer3)
	Select Case toggle
		Case SoundOn
			WireRampTimer3.Interval = 10
			WireRampTimer3.Enabled = 1
		Case SoundOff
			StopSound "TOM_RightOuterLoopRampAfterDropFromCatwalk_3"
	End Select
End Sub

'/////////////////////////////  WIRE RIGHT OUTER LOOP RAMP - ENTRANCE - FROM BALL GATE - SOUND  ////////////////////////////
Sub SoundRightOuterLoopRampFromBallGate(toggle)
	Select Case toggle
		Case SoundOn
			WireRampTimer1.Interval = 10
			WireRampTimer1.Enabled = 1
		Case SoundOff
			WireRampTimer1.Enabled = 0
			StopSound "TOM_RightOuterLoop_Enter_From_Gate_Roll"
	End Select
End Sub


'/////////////////////////////  MAGNA SAVE MAGNETS SOUNDS  ////////////////////////////
Sub SoundMagnaSaveLeftMagnet(toggle)
	Select Case toggle
		Case SoundOn
			PlaySoundAtLevelStatic SoundFX("TOM_Magna_Save_1",DOFShaker), MagnaSaveMagnetSoundLevel, LMagnet
		Case SoundOff
			StopSound "TOM_Magna_Save_1"
	End Select
End Sub	

Sub SoundMagnaSaveRightMagnet(toggle)
	Select Case toggle
		Case SoundOn
			PlaySoundAtLevelStatic SoundFX("TOM_Magna_Save_2",DOFShaker), MagnaSaveMagnetSoundLevel, RMagnet
		Case SoundOff
			StopSound "TOM_Magna_Save_2"
	End Select
End Sub	


'/////////////////////////////  TRAP DOOR SOUNDS  ////////////////////////////
'/////////////////////////////  TRAP DOOR CLOSE/OPEN SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundTrapdoorClose()
	Select Case Int(Rnd*4)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_Close_1_3",DOFContactors), TrapdoorCloseSoundLevel, TDHole
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_Close_2_3",DOFContactors), TrapdoorCloseSoundLevel, TDHole
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_Close_3_3",DOFContactors), TrapdoorCloseSoundLevel, TDHole
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_Close_4_3",DOFContactors), TrapdoorCloseSoundLevel, TDHole
	End Select
End Sub

Sub RandomSoundTrapdoorOpen()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Open_2",DOFContactors), TrapdoorOpenSoundLevel, TDHole
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Open_2",DOFContactors), TrapdoorOpenSoundLevel, TDHole
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Open_2",DOFContactors), TrapdoorOpenSoundLevel, TDHole
	End Select
End Sub

'/////////////////////////////  TRAP DOOR ENTER SOUNDS  ////////////////////////////
Sub RandomSoundTrapdoorEnter()
	Select Case Int(Rnd*5)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_NK_Trapdoor_Enter_1"), TrapdoorEnterSoundLevel, TDHole
		Case 2 : PlaySoundAtLevelStatic ("TOM_NK_Trapdoor_Enter_2"), TrapdoorEnterSoundLevel, TDHole
		Case 3 : PlaySoundAtLevelStatic ("TOM_NK_Trapdoor_Enter_3"), TrapdoorEnterSoundLevel, TDHole
		Case 4 : PlaySoundAtLevelStatic ("TOM_NK_Trapdoor_Enter_4"), TrapdoorEnterSoundLevel, TDHole
		Case 5 : PlaySoundAtLevelStatic ("TOM_NK_Trapdoor_Enter_5"), TrapdoorEnterSoundLevel, TDHole
	End Select
End Sub

'/////////////////////////////  TRAP DOOR SUB RELEASE SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundTrapdoorSubRelease()
	Select Case Int(Rnd*9)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_SubRelease_1",DOFContactors), TrapdoorSubReleaseSoundLevel, sw41
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_SubRelease_2",DOFContactors), TrapdoorSubReleaseSoundLevel, sw41
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_SubRelease_3",DOFContactors), TrapdoorSubReleaseSoundLevel, sw41
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_SubRelease_4",DOFContactors), TrapdoorSubReleaseSoundLevel, sw41
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_SubRelease_5",DOFContactors), TrapdoorSubReleaseSoundLevel, sw41
		Case 6 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_SubRelease_6",DOFContactors), TrapdoorSubReleaseSoundLevel, sw41
		Case 7 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_SubRelease_7",DOFContactors), TrapdoorSubReleaseSoundLevel, sw41
		Case 8 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_SubRelease_8",DOFContactors), TrapdoorSubReleaseSoundLevel, sw41
		Case 9 : PlaySoundAtLevelStatic SoundFX("TOM_Trapdoor_SubRelease_9",DOFContactors), TrapdoorSubReleaseSoundLevel, sw41
	End Select
End Sub

'/////////////////////////////  TRAP DOOR POPPER SOLENOID SOUNDS  ////////////////////////////
Sub RandomSoundTrapdoorEjectPopper()
	Select Case Int(Rnd*8)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Eject_1",DOFContactors), TrapdoorEjectPopperSoundLevel, sw44
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Eject_2",DOFContactors), TrapdoorEjectPopperSoundLevel, sw44
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Eject_3",DOFContactors), TrapdoorEjectPopperSoundLevel, sw44
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Eject_4",DOFContactors), TrapdoorEjectPopperSoundLevel, sw44
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Eject_5",DOFContactors), TrapdoorEjectPopperSoundLevel, sw44
		Case 6 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Eject_6",DOFContactors), TrapdoorEjectPopperSoundLevel, sw44
		Case 7 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Eject_7",DOFContactors), TrapdoorEjectPopperSoundLevel, sw44
		Case 8 : PlaySoundAtLevelStatic SoundFX("TOM_Calle_Trapdoor_Eject_8",DOFContactors), TrapdoorEjectPopperSoundLevel, sw44
	End Select
End Sub

'/////////////////////////////  TRAP DOOR FLASH RELAY SOUND  ////////////////////////////
'/////////////////////////////  TRAP DOOR FLASH RELAY ENABLER  ////////////////////////////
Sub SoundScoopLightFlashRelay(toggle)
	Select Case toggle
		Case SoundOn
			ScoopLight.TimerInterval = 100
			ScoopLight.TimerEnabled = 1
		Case SoundOff
			ScoopLight.TimerEnabled = 0
	End Select
End Sub

'/////////////////////////////  TRAP DOOR FLASH RELAY TIMER  ////////////////////////////
Sub ScoopLight_Timer
	PlaySoundAtLevelStatic ("JON_Relay_3_On_Off_5"), RelayFlashLowerSoundLevel, TDHole
End Sub


'/////////////////////////////  MAGIC TRUNK SOUNDS  ////////////////////////////
'/////////////////////////////  MAGIC TRUNK MOTOR  ////////////////////////////
Sub SoundTrunkMotor(toggle)
	Select Case toggle
		Case SoundOn
			PlaySoundAtLevelStaticRandomPitch SoundFX("TOM_Trunk_Motor_Long",DOFGear), TrunkMotorSoundLevel, 0.055, Trunk
		Case SoundOff
			StopSound "TOM_Trunk_Motor_Long"
			PlaySoundAtLevelStaticRandomPitch ("TOM_Trunk_Motor_Stop"), TrunkMotorSoundLevel, 0.25, Trunk
	End Select
End Sub

'/////////////////////////////  MAGIC TRUNK MAGNET CATCH ////////////////////////////
Sub RandomSoundTrunkCatch()
	Select Case Int(Rnd*8)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Magnet_Catch_1_Deep",DOFShaker), TrunkCatchSoundLevel, Trunk
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Magnet_Catch_2_Deep",DOFShaker), TrunkCatchSoundLevel, Trunk
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Magnet_Catch_3_Deep",DOFShaker), TrunkCatchSoundLevel, Trunk
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Magnet_Catch_4_Deep",DOFShaker), TrunkCatchSoundLevel, Trunk
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Magnet_Catch_5_Deep",DOFShaker), TrunkCatchSoundLevel, Trunk
		Case 6 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Magnet_Catch_6_Deep",DOFShaker), TrunkCatchSoundLevel, Trunk
		Case 7 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Magnet_Catch_7_Deep",DOFShaker), TrunkCatchSoundLevel, Trunk
		Case 8 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Magnet_Catch_8_Deep",DOFShaker), TrunkCatchSoundLevel, Trunk
	End Select
End Sub

'/////////////////////////////  MAGIC TRUNK MAGNET  ////////////////////////////
Sub SoundTrunkMagnet(toggle)
	Select Case toggle
		Case SoundOn
			PlaySoundAtLevelStatic ("TOM_Trunk_Magnet_Start"), TrunkMagnetSoundLevel, Trunk
			PlaySoundAtLevelStaticLoop SoundFX("TOM_Trunk_Magnet_Loop",DOFShaker), TrunkMagnetSoundLevel, Trunk
		Case SoundOff
			StopSound "TOM_Trunk_Magnet_Loop"
			PlaySoundAtLevelStatic ("TOM_Magna_Save_Start"), 0.5 * TrunkMagnetSoundLevel, Trunk
	End Select
End Sub

'/////////////////////////////  MAGIC TRUNK MAGNET RELEASE BALL TO PLAYFIELD ////////////////////////////
Sub SoundTrunkBallDrop()
	Select Case Int(Rnd*1)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Trunk_Magnet_Release_Ball_Drop_1"), TrunkBallDropSoundLevel, Trunk
	End Select
End Sub


'/////////////////////////////  MAGIC TRUNK BALL ENTRANCE - FRONT ////////////////////////////
Sub RandomSoundTrunkEnteranceFront()
	Select Case Int(Rnd*7)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Front_1"), TrunkEnteranceFrontSoundLevel, Trunk
		Case 2 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Front_2"), TrunkEnteranceFrontSoundLevel, Trunk
		Case 3 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Front_3"), TrunkEnteranceFrontSoundLevel, Trunk
		Case 4 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Front_4"), TrunkEnteranceFrontSoundLevel, Trunk
		Case 5 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Front_5"), TrunkEnteranceFrontSoundLevel, Trunk
		Case 6 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Front_6"), TrunkEnteranceFrontSoundLevel, Trunk
		Case 7 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Front_7"), TrunkEnteranceFrontSoundLevel, Trunk	
	End Select
End Sub

'/////////////////////////////  MAGIC TRUNK BALL ENTRANCE - REAR ////////////////////////////
Sub RandomSoundTrunkEnteranceRear()
	Select Case Int(Rnd*6)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Rear_1"), TrunkEnteranceRearSoundLevel, Trunk
		Case 2 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Rear_2"), TrunkEnteranceRearSoundLevel, Trunk
		Case 3 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Rear_3"), TrunkEnteranceRearSoundLevel, Trunk
		Case 4 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Rear_4"), TrunkEnteranceRearSoundLevel, Trunk
		Case 5 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Rear_5"), TrunkEnteranceRearSoundLevel, Trunk
		Case 6 : PlaySoundAtLevelStatic ("TOM_Trunk_Entrance_Rear_6"), TrunkEnteranceRearSoundLevel, Trunk
	End Select
End Sub

'/////////////////////////////  MAGIC TRUNK TROUGH AND BALL LOCKING TROUGH  ////////////////////////////
Sub RandomSoundTrunkTrough_1()
	Select Case Int(Rnd*6)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Trough_2",DOFContactors), TrunkTrough_1SoundLevel, SwCheckMode
		Case 2 : 'Play Nothing
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Trough_3",DOFContactors), TrunkTrough_1SoundLevel, SwCheckMode
		Case 4 : 'Play Nothing
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Trough_4",DOFContactors), TrunkTrough_1SoundLevel, SwCheckMode
		Case 6 : 'Play Nothing
	End Select
End Sub

Sub RandomSoundTrunkTrough_2_Multiball()
	Select Case Int(Rnd*6)+1
		Case 1 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Entrance_Rear_Solenoids_1",DOFContactors), TrunkTrough_2_MultiballSoundLevel, SwCheckMode
		Case 2 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Entrance_Rear_Solenoids_2",DOFContactors), TrunkTrough_2_MultiballSoundLevel, SwCheckMode
		Case 3 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Entrance_Rear_Solenoids_3",DOFContactors), TrunkTrough_2_MultiballSoundLevel, SwCheckMode
		Case 4 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Entrance_Rear_Solenoids_4",DOFContactors), TrunkTrough_2_MultiballSoundLevel, SwCheckMode
		Case 5 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Entrance_Rear_Solenoids_5",DOFContactors), TrunkTrough_2_MultiballSoundLevel, SwCheckMode
		Case 6 : PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Entrance_Rear_Solenoids_6",DOFContactors), TrunkTrough_2_MultiballSoundLevel, SwCheckMode
	End Select
End Sub

Sub SoundTrunkTrough_3()
	PlaySoundAtLevelStatic SoundFX("TOM_Trunk_Trough_1",DOFContactors), TrunkTrough_3SoundLevel, SwCheckMode
End Sub

'/////////////////////////////  MAGIC TRUNK BALL HITS ////////////////////////////
Sub RandomTrunkHit()
	Select Case Int(Rnd*20)+1
		Case 1 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_1"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 2 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_2"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 3 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_3"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 4 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_4"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 5 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_5"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 6 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_6"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 7 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_7"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 8 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_8"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 9 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_9"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 10 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_10"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 11 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_11"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 12 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_12"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 13 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_13"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 14 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_14"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 15 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_15"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 16 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_16"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 17 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_17"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 18 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_18"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 19 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_19"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
		Case 20 : PlaySoundAtLevelStatic ("TOM_Trunk_Hit_20"), Vol(ActiveBall) * TrunkHitSoundFactor, Trunk
	End Select
End Sub



'/////////////////////////////  TIGER SAW MOTOR  ////////////////////////////
Sub SoundTigerSawMotor(toggle)
	Select Case toggle
		Case SoundOn
			PlaySoundAtLevelStaticLoop SoundFX("TOM_SawMod_Loop",DOFGear), TigerSawMotorSoundLevel, Saw
		Case SoundOff
			StopSound "TOM_SawMod_Loop"
	End Select
End Sub



'/////////////////////////////  GENERAL ILLUMINATION RELAYS  ////////////////////////////
Sub Sound_GI_Top_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_GI_On"), 0.025*RelayGISoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_GI_On"), 0.025*RelayGISoundLevel, GITopPosition
			'StopSound "Jon_GI_Off"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_GI_Off"), 0.025*RelayGISoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_GI_Off"), 0.025*RelayGISoundLevel, GITopPosition
			'StopSound "Jon_GI_On"
	End Select
End Sub

Sub Sound_GI_BottomLeft_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_GI_On"), 0.025*RelayGISoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_GI_On"), 0.025*RelayGISoundLevel, GILeftPosition
			'StopSound "Jon_GI_Off"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_GI_Off"), 0.025*RelayGISoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_GI_Off"), 0.025*RelayGISoundLevel, GILeftPosition
			'StopSound "Jon_GI_On"
	End Select
End Sub

Sub Sound_GI_BottomRight_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_GI_On"), 0.025*RelayGISoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_GI_On"), 0.025*RelayGISoundLevel, GIRightPosition
			'StopSound "Jon_GI_Off"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_GI_Off"), 0.025*RelayGISoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_GI_Off"), 0.025*RelayGISoundLevel, GIRightPosition
			'StopSound "Jon_GI_On"
	End Select
End Sub


Sub Sound_GI_Middle_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_GI_On"), 0.025*RelayGISoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_GI_On"), 0.025*RelayGISoundLevel, GIMiddlePosition
			'StopSound "Jon_GI_Off"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_GI_Off"), 0.025*RelayGISoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_GI_Off"), 0.025*RelayGISoundLevel, GIMiddlePosition
			'StopSound "Jon_GI_On"
	End Select
End Sub


'/////////////////////////////  PLAYFIELD FLASH RELAYS  ////////////////////////////
Sub Sound_Flash_120_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.025*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.025*RelayFlashUpperSoundLevel, F23
			'StopSound "Jon_Relay_Off_2"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.025*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.025*RelayFlashUpperSoundLevel, F23
			'StopSound "Jon_Relay_On_2"
	End Select
End Sub

Sub Sound_Flash_123_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.025*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.025*RelayFlashUpperSoundLevel, F23
			'StopSound "Jon_Relay_Off_2"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.025*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.025*RelayFlashUpperSoundLevel, F23
			'StopSound "Jon_Relay_On_2"
	End Select
End Sub

Sub Sound_Flash_124_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.025*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.025*RelayFlashUpperSoundLevel, F24c
			'StopSound "Jon_Relay_Off_2"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.025*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.025*RelayFlashUpperSoundLevel, F24c
			'StopSound "Jon_Relay_On_2"
	End Select
End Sub

Sub Sound_Flash_125_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.25*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.25*RelayFlashUpperSoundLevel, l41
			'StopSound "Jon_Relay_Off_2"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.25*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.25*RelayFlashUpperSoundLevel, l41
			'StopSound "Jon_Relay_On_2"
	End Select
End Sub

Sub Sound_Flash_126_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.025*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.025*RelayFlashUpperSoundLevel, f26d
			'StopSound "Jon_Relay_Off_2"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.025*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.025*RelayFlashUpperSoundLevel, f26d

			'StopSound "Jon_Relay_On_2"
	End Select
End Sub

Sub Sound_Flash_127_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.25*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_On_2"), 0.25*RelayFlashUpperSoundLevel, BB2
			'StopSound "Jon_Relay_Off_2"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.25*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_2"), 0.25*RelayFlashUpperSoundLevel, BB2
			'StopSound "Jon_Relay_On_2"
	End Select
End Sub

Sub Sound_Flash_128_Relay(toggle)
	Select Case toggle
		Case SoundOn
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_On_HighPitched"), 0.25*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_On_HighPitched"), 0.25*RelayFlashUpperSoundLevel, f28b
			'StopSound "Jon_Relay_Off_HighPitched"
		Case SoundOff
			If RelaysPosition = 1 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_HighPitched"), 0.25*RelayFlashUpperSoundLevel, GITopPosition
			If RelaysPosition = 2 Then PlaySoundAtLevelStatic ("Jon_Relay_Off_HighPitched"), 0.25*RelayFlashUpperSoundLevel, f28b
			'StopSound "Jon_Relay_On_HighPitched"
	End Select
End Sub


'/////////////////////////////  VARIOUS PLAYFIELD SOUND SUBROUTINES  ////////////////////////////
'/////////////////////////////  RUBBERS AND POSTS  ////////////////////////////
'/////////////////////////////  RUBBERS - EVENTS  ////////////////////////////
Sub Rubbers_Hit(idx)
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 5 then
 		RandomSoundRubberStrong() 
	End if
	If finalspeed <= 5 then
 		RandomSoundRubberWeak()
 	End If	
End Sub
'/////////////////////////////  POSTS - EVENTS  ////////////////////////////
Sub Posts_Hit(idx)
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 5 then
 		RandomSoundRubberStrong() 
	End if
	If finalspeed <= 5 then
 		RandomSoundRubberWeak()
 	End If	
End Sub
'/////////////////////////////  RUBBERS AND POSTS - STRONG IMPACTS  ////////////////////////////
Sub RandomSoundRubberStrong()
	Select Case Int(Rnd*10)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Slingshot_Strong_1"), Vol(ActiveBall) * RubberStrongSoundFactor
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Slingshot_Strong_2"), Vol(ActiveBall) * RubberStrongSoundFactor
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Slingshot_Strong_3"), Vol(ActiveBall) * RubberStrongSoundFactor
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Slingshot_Strong_4"), Vol(ActiveBall) * RubberStrongSoundFactor
		Case 5 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Slingshot_Strong_5"), Vol(ActiveBall) * RubberStrongSoundFactor
		Case 6 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Slingshot_Strong_6"), Vol(ActiveBall) * RubberStrongSoundFactor
		Case 7 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Slingshot_Strong_7"), Vol(ActiveBall) * RubberStrongSoundFactor
		Case 8 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Slingshot_Strong_8"), Vol(ActiveBall) * RubberStrongSoundFactor
		Case 9 : PlaySoundAtLevelActiveBall ("TOM_Rubber_Flipper_Slingshot_Strong_9"), Vol(ActiveBall) * RubberStrongSoundFactor
		Case 10 : PlaySoundAtLevelActiveBall ("TOM_Rubber_1_Hard"), Vol(ActiveBall) * RubberStrongSoundFactor * 0.6
	End Select
End Sub

'/////////////////////////////  RUBBERS AND POSTS - WEAK IMPACTS  ////////////////////////////
Sub RandomSoundRubberWeak()
	Select Case Int(Rnd*9)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Rubber_1"), Vol(ActiveBall) * RubberWeakSoundFactor
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Rubber_2"), Vol(ActiveBall) * RubberWeakSoundFactor
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Rubber_3"), Vol(ActiveBall) * RubberWeakSoundFactor
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Rubber_3"), Vol(ActiveBall) * RubberWeakSoundFactor
		Case 5 : PlaySoundAtLevelActiveBall ("TOM_Rubber_5"), Vol(ActiveBall) * RubberWeakSoundFactor
		Case 6 : PlaySoundAtLevelActiveBall ("TOM_Rubber_6"), Vol(ActiveBall) * RubberWeakSoundFactor
		Case 7 : PlaySoundAtLevelActiveBall ("TOM_Rubber_7"), Vol(ActiveBall) * RubberWeakSoundFactor
		Case 8 : PlaySoundAtLevelActiveBall ("TOM_Rubber_8"), Vol(ActiveBall) * RubberWeakSoundFactor
		Case 9 : PlaySoundAtLevelActiveBall ("TOM_Rubber_9"), Vol(ActiveBall) * RubberWeakSoundFactor
	End Select
End Sub

'/////////////////////////////  WALL IMPACTS  ////////////////////////////
Sub RandomSoundWall()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 16 then 
		Select Case Int(Rnd*5)+1
			Case 1 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_1"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 2 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_2"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 3 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_5"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 4 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_7"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 5 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_9"), Vol(ActiveBall) * WallImpactSoundFactor
		End Select
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
		Select Case Int(Rnd*4)+1
			Case 1 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_3"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 2 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_4"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 3 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_6"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 4 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_8"), Vol(ActiveBall) * WallImpactSoundFactor
		End Select
 	End If
	If finalspeed < 6 Then
		Select Case Int(Rnd*3)+1
			Case 1 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_4"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 2 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_6"), Vol(ActiveBall) * WallImpactSoundFactor
			Case 3 : PlaySoundAtLevelExistingActiveBall ("TOM_Wall_Hit_8"), Vol(ActiveBall) * WallImpactSoundFactor
		End Select
	End if
End Sub

'/////////////////////////////  WALL IMPACTS EVENTS  ////////////////////////////
Sub Wall169_Hit()
	RandomSoundMetal()
End Sub

Sub Wall228_Hit()
	RandomSoundMetal()
End Sub

Sub Wall227_Hit()
	RandomSoundMetal()
End Sub

Sub Wall277_Hit()
	RandomSoundMetal()
End Sub

Sub Wall276_Hit()
	RandomSoundMetal()
End Sub

Sub Wall99_Hit()
	RandomSoundMetal()
End Sub

Sub Wall233_Hit()
	RandomSoundMetal()
End Sub

Sub Wall11_Hit()
	RandomSoundMetal()
End Sub

Sub LoopPost_Hit()
	RandomSoundMetal()
End Sub



'/////////////////////////////  METAL TOUCH SOUNDS  ////////////////////////////
Sub RandomSoundMetal()
	Select Case Int(Rnd*13)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_1"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_2"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_3"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_4"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 5 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_5"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 6 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_6"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 7 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_7"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 8 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_8"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 9 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_9"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 10 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_10"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 11 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_11"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 12 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_12"), Vol(ActiveBall) * MetalImpactSoundFactor
		Case 13 : PlaySoundAtLevelActiveBall ("TOM_Metal_Touch_13"), Vol(ActiveBall) * MetalImpactSoundFactor
	End Select
End Sub

'/////////////////////////////  BOTTOM ARCH BALL GUIDE  ////////////////////////////
'/////////////////////////////  BOTTOM ARCH BALL GUIDE - SOFT BOUNCES  ////////////////////////////
Sub RandomSoundBottomArchBallGuide()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 16 then 
 		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("TOM_Apron_Bounce_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("TOM_Apron_Bounce_2"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
		End Select
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
 		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("TOM_Apron_Bounce_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("TOM_Apron_Bounce_Soft_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
		End Select
 	End If
	If finalspeed < 6 Then
 		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("TOM_Apron_Bounce_Soft_1"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("TOM_Apron_Medium_3"), Vol(ActiveBall) * BottomArchBallGuideSoundFactor
		End Select
	End if
End Sub

'/////////////////////////////  BOTTOM ARCH BALL GUIDE - HARD HITS  ////////////////////////////
Sub RandomSoundBottomArchBallGuideHardHit()
	Select Case Int(Rnd*3)+1
		Case 1 : PlaySoundAtLevelActiveBall ("WD_Drain_On_Metal_Under_Apron_1"), BottomArchBallGuideSoundFactor * 0.25
		Case 2 : PlaySoundAtLevelActiveBall ("WD_Drain_On_Metal_Under_Apron_2"), BottomArchBallGuideSoundFactor * 0.25
		Case 3 : PlaySoundAtLevelActiveBall ("WD_Drain_On_Metal_Under_Apron_3"), BottomArchBallGuideSoundFactor * 0.25
	End Select
End Sub

'/////////////////////////////  FLIPPER BALL GUIDE  ////////////////////////////
Sub RandomSoundFlipperBallGuide()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 16 then 
 		Select Case Int(Rnd*2)+1
			Case 1 : PlaySoundAtLevelActiveBall ("TOM_Apron_Hard_1"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("TOM_Apron_Hard_2"),  Vol(ActiveBall) * 0.8 * FlipperBallGuideSoundFactor
		End Select
	End if
	If finalspeed >= 6 AND finalspeed <= 16 then
 		Select Case Int(Rnd*3)+1
			Case 1 : PlaySoundAtLevelActiveBall ("TOM_Apron_Medium_1"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("TOM_Apron_Medium_2"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 3 : PlaySoundAtLevelActiveBall ("TOM_Apron_Medium_3"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
		End Select
 	End If
	If finalspeed < 6 Then
 		Select Case Int(Rnd*7)+1
			Case 1 : PlaySoundAtLevelActiveBall ("TOM_Apron_Soft_1"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("TOM_Apron_Soft_2"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 3 : PlaySoundAtLevelActiveBall ("TOM_Apron_Soft_3"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 4 : PlaySoundAtLevelActiveBall ("TOM_Apron_Soft_4"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 5 : PlaySoundAtLevelActiveBall ("TOM_Apron_Soft_5"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 6 : PlaySoundAtLevelActiveBall ("TOM_Apron_Soft_6"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
			Case 7 : PlaySoundAtLevelActiveBall ("TOM_Apron_Soft_7"),  Vol(ActiveBall) * FlipperBallGuideSoundFactor
		End Select
	End if
End Sub


'/////////////////////////////  WIREFORM ANTI-REBOUNT RAILS  ////////////////////////////
Sub RandomSoundWireformAntiRebountRail()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 2 then 
 		Select Case Int(Rnd*5)+1
			Case 1 : PlaySoundAtLevelActiveBall ("TOM_Wireform_Anti_Rebound_Rail_3"),  Vol(ActiveBall) * WireformAntiRebountRailSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("TOM_Wireform_Anti_Rebound_Rail_4"),  Vol(ActiveBall) * WireformAntiRebountRailSoundFactor
			Case 3 : PlaySoundAtLevelActiveBall ("TOM_Wireform_Anti_Rebound_Rail_5"),  Vol(ActiveBall) * WireformAntiRebountRailSoundFactor
			Case 4 : PlaySoundAtLevelActiveBall ("TOM_Wireform_Anti_Rebound_Rail_6"),  Vol(ActiveBall) * WireformAntiRebountRailSoundFactor
			Case 5 : PlaySoundAtLevelActiveBall ("TOM_Wireform_Anti_Rebound_Rail_7"),  Vol(ActiveBall) * WireformAntiRebountRailSoundFactor
		End Select
	End if
	If finalspeed < 2 Then
 		Select Case Int(Rnd*3)+1
			Case 1 : PlaySoundAtLevelActiveBall ("TOM_Wireform_Anti_Rebound_Rail_1"),  Vol(ActiveBall) * WireformAntiRebountRailSoundFactor
			Case 2 : PlaySoundAtLevelActiveBall ("TOM_Wireform_Anti_Rebound_Rail_2"),  Vol(ActiveBall) * WireformAntiRebountRailSoundFactor
			Case 3 : PlaySoundAtLevelActiveBall ("TOM_Wireform_Anti_Rebound_Rail_8"),  Vol(ActiveBall) * WireformAntiRebountRailSoundFactor
		End Select
	End if
End Sub


'/////////////////////////////  LANES AND INNER LOOPS  ////////////////////////////
'/////////////////////////////  INNER LOOPS - LEFT ENTRANCE - EVENTS  ////////////////////////////
Sub InnerLoopEnterLeft_Hit()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
		If ActiveBall.VelY < 0 Then RandomSoundInnerLoopLeftEnter()
	End If
End Sub

'/////////////////////////////  INNER LOOPS - LEFT ENTRANCE - SOUNDS  ////////////////////////////
Sub RandomSoundInnerLoopLeftEnter()
	Select Case Int(Rnd*4)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Inner_Loop_L1"), Vol(ActiveBall) * InnerLoopSoundFactor
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Inner_Loop_L2"), Vol(ActiveBall) * InnerLoopSoundFactor
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Inner_Loop_L3"), Vol(ActiveBall) * InnerLoopSoundFactor
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Inner_Loop_L4"), Vol(ActiveBall) * InnerLoopSoundFactor
	End Select
End Sub

'/////////////////////////////  INNER LOOPS - RIGHT ENTRANCE  ////////////////////////////
'/////////////////////////////  INNER LOOPS - RIGHT ENTRANCE - EVENTS  ////////////////////////////
Sub InnerLoopEnterRight_Hit()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
		If ActiveBall.VelY < 0 Then RandomSoundInnerLoopLeftEnter()
	End If
End Sub

'/////////////////////////////  INNER LOOPS - RIGHT ENTRANCE - SOUNDS  ////////////////////////////
Sub RandomSoundInnerLoopRightEnter()
	Select Case Int(Rnd*4)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Inner_Loop_R1"), Vol(ActiveBall) * InnerLoopSoundFactor
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Inner_Loop_R2"), Vol(ActiveBall) * InnerLoopSoundFactor
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Inner_Loop_R3"), Vol(ActiveBall) * InnerLoopSoundFactor
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Inner_Loop_R4"), Vol(ActiveBall) * InnerLoopSoundFactor
	End Select
End Sub

'/////////////////////////////  LEFT LANE ENTRANCE  ////////////////////////////
'/////////////////////////////  LEFT LANE ENTRANCE - EVENTS  ////////////////////////////
Sub LLaneEnter_Hit()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
		If ActiveBall.VelY < 0 Then PlaySoundAtLevelActiveBall ("TOM_Ball_Enter_Left_Lane"), Vol(ActiveBall) * LaneEnterSoundFactor : RandomSoundLaneLeftEnter()
	End If
End Sub
'/////////////////////////////  LEFT LANE ENTRANCE - SOUNDS  ////////////////////////////
Sub RandomSoundLaneLeftEnter()
	Select Case Int(Rnd*4)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Lane_L1"), Vol(ActiveBall) * LaneSoundFactor * 1.4
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Lane_L2"), Vol(ActiveBall) * LaneSoundFactor * 1.4
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Lane_L3"), Vol(ActiveBall) * LaneSoundFactor * 1.4
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Lane_L4"), Vol(ActiveBall) * LaneSoundFactor * 1.4
	End Select
End Sub

'/////////////////////////////  RIGHT LANE ENTRANCE (RIGHT ORBIT)  ////////////////////////////
'/////////////////////////////  RIGHT LANE ENTRANCE (RIGHT ORBIT) - EVENTS  ////////////////////////////
Sub RLaneEnter_Hit()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 10 then
		If ActiveBall.VelY < 0 Then PlaySoundAtLevelActiveBall ("TOM_Ball_Enter_Right_Lane"), Vol(ActiveBall) * LaneEnterSoundFactor : RandomSoundLaneRightEnter()
	End If
End Sub
'/////////////////////////////  RIGHT LANE ENTRANCE (RIGHT ORBIT) - SOUNDS  ////////////////////////////
Sub RandomSoundLaneRightEnter()
	Select Case Int(Rnd*5)+1
		'Case 1 : PlaySoundAtLevelActiveBall ("TOM_Lane_R1_Shoter"), Vol(ActiveBall) * LaneSoundFactor
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Lane_R2"), Vol(ActiveBall) * LaneSoundFactor
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Lane_R3_Shorter"), Vol(ActiveBall) * LaneSoundFactor
		Case 3 : PlaySoundAtLevelActiveBall ("TOM_Lane_R4_Shorter"), Vol(ActiveBall) * LaneSoundFactor
		Case 4 : PlaySoundAtLevelActiveBall ("TOM_Lane_R5"), Vol(ActiveBall) * LaneSoundFactor
		Case 5 : PlaySoundAtLevelActiveBall ("TOM_Lane_R6"), Vol(ActiveBall) * LaneSoundFactor
	End Select
End Sub


'/////////////////////////////  LANE ENTRANCE LOUD IMPACT  ////////////////////////////
'/////////////////////////////  LANE ENTRANCE LOUD IMPACT - EVENTS  ////////////////////////////
Sub RLaneHitLoud_Hit()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If finalspeed > 20 then
		If ActiveBall.VelY < 0 Then PlaySoundAtLevelActiveBall ("TOM_Ball_Enter_Right_Lane"), Vol(ActiveBall) * 0.55 : RandomSoundLaneLoudImpact()
	End If
End Sub

'/////////////////////////////  LANE ENTRANCE LOUD IMPACT - SOUNDS  ////////////////////////////
Sub RandomSoundLaneLoudImpact()
	LaneLoudImpactSoundLevel = RndNum(LaneLoudImpactMinimumSoundLevel, LaneLoudImpactMaximumSoundLevel)	
	Select Case Int(Rnd*2)+1
		Case 1 : PlaySoundAtLevelActiveBall ("TOM_Lane_Loud_Impact_1"), LaneLoudImpactSoundLevel
		Case 2 : PlaySoundAtLevelActiveBall ("TOM_Lane_Loud_Impact_2"), LaneLoudImpactSoundLevel
	End Select
End Sub



'/////////////////////////////  RAMP HELPERS BALL VARIABLES  ////////////////////////////
Dim ballvariableWireRampTimer1
Dim ballvariableWireRampTimer2
Dim ballvariableWireRampTimer3
Dim ballvariableWireRampTimer4


'/////////////////////////////  PLASTIC LEFT RAMP - EXIT HOLE - TO PLAYFIELD - EVENT  ////////////////////////////
Sub RHelp1_Hit()
	vpmtimer.addtimer 150, "RandomSoundLeftRampDropToPlayfield() '"
End Sub

Sub Wall25_Hit()
	LRHit7.TimerInterval = 5
	LRHit7.TimerEnabled = 1
End Sub

'/////////////////////////////  WIRE RIGHT OUTER LOOP RAMP - EXIT HOLE - TO PLAYFIELD - EVENT  ////////////////////////////
Sub RHelp2_Hit()
	vpmtimer.addtimer 150, "RandomSoundRightRampDropToPlayfield() '"
	Call SoundRightOuterLoopRampAfterDropFromCatwalk(SoundOff, ballvariableWireRampTimer3)
	Call SoundRightOuterLoopRampAfterDropFromSkillTheatreEntrance(SoundOff, ballvariableWireRampTimer2)
	SoundRightOuterLoopRampFromBallGate(SoundOff)
End Sub

'/////////////////////////////  WIRE CROSSOEVER CATWALK RAMP - EXIT HOLE - TO WIRE RIGHT OUTER LOOP RAMP - EVENT  ////////////////////////////
Sub RHelp3_Hit()
	vpmtimer.addtimer 30, "RandomSoundDropFromCatwalkRampToRamp() '"
	SoundWireRampCatwalk(SoundOff)
	Set ballvariableWireRampTimer3 = ActiveBall	
	vpmtimer.addtimer 400, "Call SoundRightOuterLoopRampAfterDropFromCatwalk(SoundOn, ballvariableWireRampTimer3) '"
End Sub

'/////////////////////////////  SHOOTER RAMP - THEATRE ENTRANCE - EXIT HOLE - TO WIRE RIGHT OUTER LOOP RAMP - EVENT   ////////////////////////////
Sub RHelp4_Hit()
	RandomSoundSkillTheatreEntranceToRightOuterLoopRampDrop()
	Set ballvariableWireRampTimer2 = ActiveBall	
	vpmtimer.addtimer 200, "Call SoundRightOuterLoopRampAfterDropFromSkillTheatreEntrance(SoundOn, ballvariableWireRampTimer2) '"
End Sub


'/////////////////////////////  PLASTIC RIGHT RAMP (RIGHT STAIRCASE) - EXIT HOLE - BALL FALLS TO THE RIGHT INLANE BEHIND SPINNER ON PLAYFIELD - EVENT   ////////////////////////////
Sub RHelp5_Hit()
	vpmtimer.addtimer 50, "RandomSoundBallDropFromRampBehindSpinner '"
End Sub

'/////////////////////////////  PLASTIC LEFT RAMP (CENTER STAIRCASE) TO WIRE CROSSOEVER CATWALK BALL DIVERT ENTRANCE - EVENT   ////////////////////////////
Sub RHelp6_Hit()
	RRHit4_volume = RightRampSoundLevel
	RRHit3.TimerInterval = 5
	RRHit3.TimerEnabled = 1
	Set ballvariableWireRampTimer4 = ActiveBall
	SoundWireRampCatwalk(SoundOn)
End Sub

'/////////////////////////////  WIRE RIGHT OUTER LOOP RAMP - ENTRANCE AND ROLL - FROM BALL GATE - EVENTS   ////////////////////////////
Sub RHelp7_Hit()
 	dim finalspeed
  	finalspeed=SQR(activeball.velx * activeball.velx + activeball.vely * activeball.vely)
 	If ActiveBall.VelX > 0 And finalspeed > 15 then
		PlaySoundAtLevelActiveBall ("TOM_RightOuterLoop_Enter_From_Gate_BumpEnter"), RightOuterLoopRampFromBallGateSoundLevel
	End If
End Sub

Sub RHelp7_UnHit()
	If ActiveBall.VelX < 0 Then 
		SoundRightOuterLoopRampFromBallGate(SoundOff)
	End If
	If ActiveBall.VelX > 0 Then 
		Set ballvariableWireRampTimer1 = ActiveBall
		SoundRightOuterLoopRampFromBallGate(SoundOn)
	End IF
End Sub

'/////////////////////////////  SHOOTER LANE - BALL RELEASE ROLL IN SHOOTER LANE SOUND - EVENT   ////////////////////////////
Sub RHelp9_Hit()
	SoundBallReleaseShooterLane(SoundOn)
End Sub

Sub sw15_Hit()
	SoundBallReleaseShooterLane(SoundOff)
End Sub

'/////////////////////////////  SHOOTER RAMP - THEATRE ENTRANCE FLAP - EVENT   ////////////////////////////
Sub RHelp10_Hit()
	If ActiveBall.VelY < 0 Then
		SoundSkillTheatreEntranceFlapUpEnter()
		SoundBallReleaseShooterLane(SoundOff)
	End If
End Sub

Sub RHelp10_UnHit()
	If ActiveBall.VelY > 0 Then
		SoundSkillTheatreEntranceFlapDownExit()
		SoundBallReleaseShooterLane(SoundOff)
		SoundBallReleaseShooterLane(SoundOn)
	End If
End Sub

Sub RHelp11_Hit()
	If ActiveBall.VelY > 0 Then
		SoundSkillTheatreEntranceFlapDownEnter()
		SoundBallReleaseShooterLane(SoundOff)
		SoundBallReleaseShooterLane(SoundOn)
	End If
End Sub

Sub RHelp11_UnHit()
	If ActiveBall.VelY < 0 Then
		SoundSkillTheatreEntranceFlapUpExit()
		SoundBallReleaseShooterLane(SoundOff)
	End If
End Sub

'/////////////////////////////  SHOOTER RAMP - THEATRE ENTRANCE METAL RAMP ROLL UP - EVENT   ////////////////////////////
Sub RHelp14_Hit()
	If ActiveBall.VelY < 0 Then
		SoundSkillTheatreEntranceRampRollUp()
	End If
End Sub
