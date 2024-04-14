# Description
This script is designed to check for available Windows updates on a local machine and notify the user via email if updates are found. It utilizes PowerShell to interact with the Windows Update API and SMTP to send notifications.

## Features
Checks for available Windows updates. <br>
Sends notification emails if updates are found. <br>
Customizable SMTP server and email credentials. <br>


## Requirements
Windows operating system. <br>
PowerShell installed. <br>
SMTP server credentials for sending email notifications. <br>


## Installation
Clone or download the repository to your local machine. <br>
Open the script WindowsUpdateChecker.ps1 in a text editor. <br> 
Update the following variables with your SMTP server information and email credentials: <br>
$smtpServer: SMTP server address. <br>
$smtpPort: SMTP port. <br>
$smtpFrom: Sender's email address. <br>
$smtpTo: Recipient's email address. <br>
$username: SMTP authentication username. <br>
$password: SMTP authentication password. <br>
Save the changes. <br>


## Usage
Open PowerShell. <br>
Navigate to the directory where WindowsUpdateChecker.ps1 is located.<br> 
Run the script by executing the command: .\WindowsUpdateChecker.ps1.<br> 
If updates are found, you will receive an email notification.<br>
**OR**   <br>
Modify the file path in the provided batch file (RunWinUpdates.bat) to match the location of the script, and then execute the batch file by double-clicking it.<br>


## Configuration<br> 
Modify the script to customize the notification email subject and body according to your preferences. <br>
Adjust the script's schedule or integrate it with task scheduling tools for periodic checks. <br>


## Contributing
Contributions are welcome! If you have suggestions, feature requests, or bug reports, please open an issue or submit a pull request.
