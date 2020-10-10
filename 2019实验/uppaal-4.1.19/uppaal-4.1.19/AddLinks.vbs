Set WshShell = CreateObject("WScript.Shell")
menu = WshShell.SpecialFolders("StartMenu")
programfiles = WshShell.SpecialFolders("ProgramFiles")

' locate the current installation paths
Set fso = CreateObject("Scripting.FileSystemObject")
here = fso.GetParentFolderName(WScript.ScriptFullName)
vername = UCase(fso.GetFolder(here).Name)

Function readFromRegistry (strRegistryKey)
    Dim value
    On Error Resume Next
    value = WshShell.RegRead( strRegistryKey )
    If err.number <> 0 Then
        readFromRegistry=""
    Else
        readFromRegistry=value
    End If
End Function

' Locate Java 6 installation from registry:
Dim regPaths(12)
regPaths(0) = "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\1.8\JavaHome"
regPaths(1) = "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Development Kit\1.8\JavaHome"
regPaths(2) = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment\1.8\JavaHome"
regPaths(3) = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Development Kit\1.8\JavaHome"
regPaths(4) = "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\1.7\JavaHome"
regPaths(5) = "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Development Kit\1.7\JavaHome"
regPaths(6) = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment\1.7\JavaHome"
regPaths(7) = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Development Kit\1.7\JavaHome"
regPaths(8) = "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\1.6\JavaHome"
regPaths(9) = "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Development Kit\1.6\JavaHome"
regPaths(10) = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment\1.6\JavaHome"
regPaths(11) = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Development Kit\1.6\JavaHome"

For Each regPath in regPaths
	jrePath = readFromRegistry(regPath)
	If (jrePath <> "") Then Exit For
Next
If (jrePath = "") Then
	WScript.Echo "Java Runtime Environment (JRE) was not found." & vbCr & vbCr _
	    & "Please make sure that Java is installed."
	WScript.Quit
End If

javawPath = jrePath & "\bin\javaw.exe"

' clean the PATH:
Set WSHUserEnv = WshShell.Environment("USER")
newpath = ""
For Each segment In Split(WSHUserEnv("PATH"), ";")
	If InStr(1, LCase(segment), "uppaal") = 0 Then
		If newpath = "" Then
			newpath = segment
		Else
			newpath = newpath & ";" & segment
		End If
	Else
		q = "An earlier UPPAAL installation has been found at" & vbCr & "  " _
			& segment & vbCr & vbCr & "Remove it from the PATH?"
		If WshShell.Popup(q,0,vername,4+32+4096+65536) = vbNo Then
			If newpath = "" Then
				newpath = segment
			Else
				newpath = newpath & ";" & segment
			End If
		End If
	End If
Next

targetDir = here
icondir = targetDir & "\uppaal.ico"
'working = WshShell.SpecialFolders("MyDocuments")
working = targetDir & "\demo"
descr = "Timed automata model-checking tool suite"

' add current installation:
thisInstall = targetDir & "\bin-Win32"
q = "Add this UPPAAL installation to the PATH?" & vbCr & thisInstall & vbCr _
    & vbCr & "(useful to run verifyta from command line)"
If WshShell.Popup( q,0,vername,4+32+4096+65536 ) = vbYes Then
	WSHUserEnv("PATH") = newpath & ";" & thisInstall
Else
	WSHUserEnv("PATH") = newpath
End If

Sub createLink (strLocation, linkName, arguments)
    Set oShellLink = WshShell.CreateShortcut(strLocation & "\" & linkName & ".lnk")
    oShellLink.TargetPath = javawPath
    oShellLink.Arguments = arguments
    oShellLink.WindowStyle = 1
    oShellLink.IconLocation = icondir
    oShellLink.Description = descr
    oShellLink.WorkingDirectory = working
    oShellLink.Save
End Sub

' check for proxy
javaArgs = ""
proxyEnable = readFromRegistry("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable")
If proxyEnable>0 Then
	q = "Looks like proxy is used to access Internet." & vbCr & vbCr _
		& "Setup the proxy for UPPAAL too?" & vbCr & vbCr _
		& "(license check requires Internet access)"
	If WshShell.Popup(q,0,vername,4+32+4096+65536) = vbYes Then
		proxy = readFromRegistry("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer")
		if Len(proxy)>0 Then
			proxySettings = Split(proxy, ":")
			proxyHost = proxySettings(0)
			proxyPort = proxySettings(1)
		End If
		proxyHost = Trim(InputBox("Enter proxy host", vername, proxyHost))
		proxyPort = Trim(InputBox("Enter proxy port number", vername, proxyPort))
		proxyUser = Trim(InputBox("Enter proxy username", vername))
		proxyPass = Trim(InputBox("Enter proxy password", vername))
		If Len(proxyHost)+Len(proxyPort)+Len(proxyUser)+Len(proxyPass)>0 Then
			javaArgs = javaArgs & " -DproxySet=true"
		End If
		If Len(proxyHost)>0 Then
			javaArgs = javaArgs & " -Dhttp.proxyHost=" & proxyHost
		End If
		If Len(proxyPort)>0 Then
			javaArgs = javaArgs & " -Dhttp.proxyPort=" & proxyPort
		End If
		If Len(proxyUser)>0 Then
			javaArgs = javaArgs & " -Dhttp.proxyUser=" & proxyUser
		End If
		If Len(proxyPass)>0 Then
			javaArgs = javaArgs & " -Dhttp.proxyPassword=" & proxyPass
		End If
	End If
End If

javaArgs = javaArgs & " -jar """ & targetDir & "\uppaal.jar"""
englishArgs = " -Duser.language=en" & javaArgs

' finished with Java arguments, start with Uppaal arguments:
uppaalArgs = ""

' ask for UPPAAL server
q = "Do you use remote UPPAAL server?" & vbCr & vbCr & "(socketserver has to be running on the remote machine)"
If WshShell.Popup(q,0,vername,4+32+4096+65536) = vbYes Then
	serverHost = Trim(InputBox("Enter UPPAAL server hostname", vername))
	serverPort = Trim(InputBox("Enter UPPAAL server port number" & vbCr & "(default is 2350)", vername))
	if Len(serverHost)>0 Then
		uppaalArgs = uppaalArgs & " --serverHost " & serverHost
	End If
	if Len(serverPort)>0 Then
		uppaalArgs = uppaalArgs & " --serverPort " & serverPort
	End If
End If

' add links:
programs = WshShell.SpecialFolders("Programs")
Select Case GetLocale Mod 256
Case 4,6,17,39
	' link for supported original locales (CN,DA,JA,LT):
	Call createLink (programs, vername, javaArgs & uppaalArgs)
	' link for English locale just in case:
	q = "Create a link to UPPAAL in English?"
	If WshShell.Popup(q,0,vername,4+32+4096+65536) = vbYes Then
		Call createLink (programs, vername & " in English", englishArgs & uppaalArgs)
		englishToo = 1
		msg = "Links to UPPAAL have been added to Programs."
	Else
		englishToo = 0
		msg = "A link to UPPAAL has been added to Programs."
	End If
Case Else
	' link just for the original locale (EN=9 and others, unsupported):
	Call createLink (programs, vername, javaArgs & uppaalArgs)
	englishToo = 0
	msg = "A link to UPPAAL has been added to Programs."
End Select

q = "Create the same link(s) on Desktop?"
If WshShell.Popup(q,0,vername,4+32+4096+65536) = vbYes Then
	desktop = WshShell.SpecialFolders("Desktop")
	Call createLink (desktop, vername, javaArgs & uppaalArgs)
	If englishToo>0 Then
		Call createLink (desktop, vername & " in English", englishArgs & uppaalArgs)
	End If
	msg = "Links to UPPAAL have been added."
End If

msg = msg & vbCr & vbCr & "Enjoy!"& vbCr & vbCr & "UPPAAL Team"
WshShell.Popup msg,15,vername,64+4096+65536+524288
