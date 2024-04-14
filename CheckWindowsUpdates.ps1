<#
Script Name: WinUpdates.ps1
Author: Luigi Schillaci
Description: Windows update automatic e-mail notification.
Date: 10/04/2024
Version: 1.0
#>

# Get the computer's username
$computerName = $env:COMPUTERNAME

$body = "" # Initialize variable
# Configuration of email credentials and settings
$smtpServer = "smtps.aruba.it"  # SMTP Server for Aruba
$smtpPort = "587"  # Port 587 for Aruba
$smtpFrom = "from@aruba.it"  # Sender's PEC email address
$smtpTo = "to@aruba.it" # Recipient's (PE)C email address
$username = "from@aruba.it"  # Username for SMTP authentication
$password = "pass"  # Password for SMTP authentication
$subject = "New updates available on $computerName"

# Function to check for updates and get detailed information
function GetAvailableUpdates {
  
    $session = New-Object -ComObject Microsoft.Update.Session
   
    $searcher = $session.CreateUpdateSearcher()
    
    $results = $searcher.Search("IsInstalled=0")
   
    $updatesList = @()

    foreach ($update in $results.Updates) {
        Write-Host " - $($update.Title)"
        $updatesList += $update.Title
    }

    return $updatesList
}

# Function to send emails to PEC 
function SendPECEmail {
    param (
        [string]$smtpServer,
        [int]$smtpPort,
        [string]$smtpFrom,
        [string]$smtpTo,
        [string]$username,
        [string]$password,
        [string]$subject,
        [string]$body
    )
    $smtp = New-Object System.Net.Mail.SmtpClient($smtpServer, $smtpPort)
    $smtp.EnableSsl = $true  # Enable SSL/TLS connection
    $smtp.Credentials = New-Object System.Net.NetworkCredential($username, $password)

    $mail = New-Object System.Net.Mail.MailMessage($smtpFrom, $smtpTo)
    $mail.Subject = $subject
    $mail.Body = $body
    try {
        $smtp.Send($mail)
        return
    } catch [System.Net.Mail.SmtpException] {
        Write-Host "SMTP Error: $_"
    } catch {
        Write-Host "Unhandled error: $_"
    }
}

# Call the function and if there are updates, add them to the body, otherwise print and exit
$availableUpdates = GetAvailableUpdates
if ($availableUpdates.Count -gt 0) {
    Write-Host "Available updates:"
    foreach ($update in $availableUpdates) {
        $body += "Title: $update`n"
        $body += "---------------------`n"
    }
} else {
     Write-Host "No updates available."
     Start-Sleep -Seconds 15
     return  
}

# Send email to PEC on Aruba
SendPECEmail -smtpServer $smtpServer -smtpPort $smtpPort -smtpFrom $smtpFrom -smtpTo $smtpTo -username $username -password $password -subject $subject -body $body

