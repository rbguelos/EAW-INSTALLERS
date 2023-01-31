@ECHO ON
cd C:\Windows\Microsoft.NET\Framework\v4.0.30319\
InstallUtil C:\EverythingAtWork\CLIENTCODE_NOTIFICATION_TEST\AISExtreme.WindowsService.exe
net start TEST_CLIENTCODE_ServiceHostTEST
net start TEST_CLIENTCODE_ServiceBackgroundScheduleTEST
net start TEST_CLIENTCODE_ServiceAutoSendEmailTEST
net start TEST_CLIENTCODE_ServiceResendEmailTEST
net start TEST_CLIENTCODE_ServiceResendEmailTEST

