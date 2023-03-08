set turbo=%~dp0..\..\..\ThirdParty\TurboPascal
set path=%path%;%~dp0..\..\..\ThirdParty\DOSBox;%turbo%
start DOSBox -noconsole -conf editor.conf