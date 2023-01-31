@ECHO ON
cd C:\Windows\Microsoft.NET\Framework\v4.0.30319\
InstallUtil C:\EverythingAtWork\CLIENTCODE_NOTIFICATION_PROD\AISExtreme.WindowsService.exe
net start _CLIENTCODE_ServiceHost
net start _CLIENTCODE_ServiceBackgroundSchedule
net start _CLIENTCODE_ServiceAutoSendEmail
net start _CLIENTCODE_ServiceResendEmail
net start _CLIENTCODE_ServiceResendEmail

